# Architecture Decision Record (ADR)

## Secure Banking Branch Locator — Cubic Flutter Assessment

**Author:** Developer  
**Date:** February 2026  
**Status:** Accepted

---

## Table of Contents

1. [Project Overview](#1-project-overview)
2. [Architecture Pattern](#2-architecture-pattern)
3. [Local Storage — Hive CE](#3-local-storage--hive-ce)
4. [Encryption at Rest — AES-256 via HiveAesCipher](#4-encryption-at-rest--aes-256-via-hiveaecipher)
5. [Key Management — Flutter Secure Storage](#5-key-management--flutter-secure-storage)
6. [Biometric Authentication — Hardware-Backed Keys](#6-biometric-authentication--hardware-backed-keys)
7. [Network & Performance — Isolates](#7-network--performance--isolates)
8. [Offline-First Data Strategy](#8-offline-first-data-strategy)
9. [Firebase Security Rules](#9-firebase-security-rules)
10. [State Management — BLoC / Cubit](#10-state-management--bloc--cubit)
11. [Dependency Injection — GetIt + Injectable](#11-dependency-injection--getit--injectable)
12. [Navigation — GoRouter with Auth Guards](#12-navigation--gorouter-with-auth-guards)
13. [Summary of Key Decisions](#13-summary-of-key-decisions)

---

## 1. Project Overview

The app is a **Secure Banking Branch Locator** that satisfies the following requirements:

| Requirement | Solution |
|---|---|
| Firebase Auth (email/password) | `firebase_auth` with email + password |
| Biometric login for returning users | `biometric_signature` (hardware-backed ECDSA) + AES-256-CBC for credential encryption |
| Home dashboard | Account card, credit card widget, recent transactions, CTA to branches |
| Fetch ~10,000 branches/ATMs | `dio` HTTP client, JSON parsed in Dart `Isolate` via `compute()` |
| Show nearest 50 on map | Haversine distance computed in `Isolate`, top-50 sorted by proximity |
| Encrypted local database | `hive_ce` with `HiveAesCipher` (AES-256) |
| Hardware-backed key storage | `flutter_secure_storage` (Android Keystore / iOS Keychain) |
| Favorite branches synced to Firebase | Firestore subcollection `users/{uid}/favorites/{branchId}` |
| Per-user Firebase rules | Firestore rules enforce `request.auth.uid == userId` |
| Offline-first | Cache-first reads, optimistic writes, remote-wins sync |

---

## 2. Architecture Pattern

### Decision

Feature-based **clean architecture** with three layers per feature:

```
feature/
├── data/
│   ├── data_sources/
│   │   ├── remote_data_source/    ← Dio / Firestore calls
│   │   └── local_data_source/     ← Hive reads/writes
│   ├── models/                    ← Freezed + HiveType + JsonSerializable
│   └── repo/                      ← Coordinates local ↔ remote
└── presentation/
    ├── cubits/                    ← BLoC / Cubit + State
    ├── screens/                   ← Full-page widgets
    └── widgets/                   ← Reusable UI pieces
```

### Context

The assessment requires authentication, networking, local storage, encryption, and biometric features — all of which benefit from a clear separation of concerns.

### Rationale

- **Testability:** Each layer can be tested independently (mock data sources, test cubits without network).
- **Scalability:** Adding new features (e.g., favorites) only requires adding a new `feature/` directory following the same pattern.
- **Maintainability:** Changes to Firestore schema don't ripple into the UI; changes to the UI don't affect data persistence logic.

### Alternatives Considered

| Alternative | Why Not |
|---|---|
| MVC | Doesn't scale well for complex Flutter apps; controller becomes a god object. |
| MVVM | Viable, but BLoC/Cubit ecosystem is more mature in Flutter and aligns better with reactive streams. |
| Monolithic (all in `lib/`) | Would quickly become unmanageable with this many cross-cutting concerns. |

---

## 3. Local Storage — Hive CE

### Decision

Use **Hive CE** (Community Edition) as the primary local NoSQL database for persisting branches, user data, and favorites.

### Context

The app must persist ~10,000 branch records locally for offline access. The data is structured as flat key-value objects (no relational queries needed).

### Rationale

| Factor | Hive CE | SQLite (sqflite) | Isar | SharedPreferences |
|---|---|---|---|---|
| **Speed** | Very fast (binary, zero-copy) | Good for relational | Fast | Slow for large data |
| **Encryption** | Built-in `HiveAesCipher` | Requires SQLCipher (extra native dep) | Built-in | Not suitable |
| **Schema** | Schema-free (NoSQL) | SQL schema required | Schema-free | Key-value only |
| **Code generation** | `@HiveType` adapters via `hive_ce_generator` | Manual mapping | `@Collection` via `isar_generator` | N/A |
| **Flutter integration** | `hive_ce_flutter` (initFlutter) | Native plugin | Native plugin | Plugin |
| **Bundle size** | Minimal (pure Dart) | Includes native SQLite | Includes native binary | Minimal |

**Why Hive CE over original Hive:** Hive CE is the actively maintained community fork. The original `hive` package is no longer maintained. Hive CE provides the same API with ongoing bug fixes, Flutter 3.x compatibility, and improved code generation.

**Why not SQLite:** The data is flat (no joins, no complex queries). AES encryption with SQLite requires SQLCipher, which adds a native dependency and increases APK size. Hive's built-in `HiveAesCipher` satisfies the encryption-at-rest requirement with zero additional native code.

### Encrypted Boxes

All sensitive local data resides in encrypted Hive boxes:

| Box Name | Type | Contents |
|---|---|---|
| `USER-DATA-TABLE` | `Box<UserDataModel>` | Cached user profile (uid, email, name, deviceId) |
| `BRANCHES-TABLE` | `Box<BranchesResponseModel>` | ~10,000 cached branches/ATMs |
| `FAVORITES-TABLE` | `Box<FavoriteBranchModel>` | User's favorited branches |

Each box is opened with `HiveAesCipher(key)` where `key` is a 32-byte AES key stored in Flutter Secure Storage (see section 5).

---

## 4. Encryption at Rest — AES-256 via HiveAesCipher

### Decision

Encrypt all local Hive boxes using **AES-256** via Hive's built-in `HiveAesCipher`.

### Context

The assessment explicitly requires: *"Local data encrypted; keys/sensitive data in hardware-backed storage"*.

### Implementation

```
┌─────────────────────────────────────────────┐
│              HiveDatabaseClient              │
│                                              │
│  init()                                      │
│    ├─ Hive.initFlutter()                     │
│    ├─ Hive.registerAdapters()                │
│    └─ _ensureEncryptedBoxOpen<T>(tableName)  │
│         ├─ Read AES key from SecureStorage   │
│         ├─ If null → generate 32-byte key    │
│         │          → save to SecureStorage    │
│         └─ Hive.openBox<T>(                  │
│              tableName,                      │
│              encryptionCipher: HiveAesCipher  │
│            )                                 │
└─────────────────────────────────────────────┘
```

### Key Details

- **Algorithm:** AES-256 (256-bit key = 32 bytes).
- **Key generation:** `Hive.generateSecureKey()` produces a cryptographically random 32-byte list.
- **Key storage:** The AES key is **never** stored inside Hive. It lives in `flutter_secure_storage` which delegates to Android Keystore / iOS Keychain (see section 5).
- **Key lifecycle:** Generated on first app launch after login. Deleted on logout (`SecureStorageService.deleteHiveEncryptionKey()`), which means the encrypted boxes become unreadable — effectively a secure wipe.

### Rationale

- **Zero additional dependencies:** `HiveAesCipher` is built into Hive CE. No native plugins needed for encryption.
- **Transparent:** All CRUD operations (`put`, `get`, `delete`) work identically whether the box is encrypted or not. Encryption is applied at the box level, not per-field.
- **Standard algorithm:** AES-256 is an industry-standard symmetric cipher used in banking and government applications.

### Alternatives Considered

| Alternative | Why Not |
|---|---|
| SQLCipher (SQLite encryption) | Adds a native dependency (~3MB), requires separate build config per platform. Hive's built-in cipher is simpler. |
| Manual field-level encryption | Error-prone, must encrypt/decrypt every field manually. Box-level encryption is more robust. |
| `encrypt` package for Hive data | Unnecessary overhead; Hive already provides box-level AES. We use `encrypt` only for biometric credential encryption (different use case). |

---

## 5. Key Management — Flutter Secure Storage

### Decision

Use **`flutter_secure_storage`** for all sensitive key material (Hive encryption key, biometric AES key/IV, encrypted passwords).

### Context

The assessment requires: *"Keys/sensitive data in hardware-backed storage"*. The Hive encryption key must not reside in plaintext anywhere on disk.

### Implementation

```
┌──────────────────────────────┐
│     SecureStorageService      │
│  (flutter_secure_storage)    │
│                              │
│  Android: EncryptedSharedPref│
│    → backed by Android       │
│      Keystore (hardware TEE) │
│                              │
│  iOS: Keychain Services      │
│    → backed by Secure Enclave│
│                              │
│  Stored keys:                │
│  ├─ hive_encryption_key      │  ← 32-byte AES key for Hive boxes
│  ├─ BIOMETRIC-AES-KEY        │  ← 32-byte key for password encryption
│  ├─ BIOMETRIC-AES-IV         │  ← 16-byte IV for AES-CBC
│  ├─ BIOMETRIC-ENCRYPTED-PWD  │  ← Encrypted user password
│  ├─ BIOMETRIC-USER-EMAIL     │  ← User email (for biometric login)
│  └─ BIOMETRIC-ENROLLED       │  ← Boolean flag
└──────────────────────────────┘
```

### Rationale

- **Hardware-backed on Android:** With `AndroidOptions(encryptedSharedPreferences: true)`, the data is encrypted using Android's `EncryptedSharedPreferences`, which is backed by the hardware Keystore (TEE/StrongBox where available).
- **Keychain on iOS:** Data stored in the iOS Keychain is encrypted by the Secure Enclave and protected by the device passcode/biometric.
- **No rooted-device plaintext:** Even if the device is rooted/jailbroken, the keys are hardware-protected and cannot be extracted without the user's biometric or passcode.
- **Platform abstraction:** `flutter_secure_storage` provides a unified API across both platforms.

### What Gets Stored

| Key | Value | Purpose |
|---|---|---|
| `hive_encryption_key` | Base64-encoded 32-byte list | Decrypts all Hive boxes |
| `BIOMETRIC-AES-KEY` | Base64 32-byte key | Encrypts/decrypts the user's password for biometric login |
| `BIOMETRIC-AES-IV` | Base64 16-byte IV | Initialization vector for AES-CBC |
| `BIOMETRIC-ENCRYPTED-PASSWORD` | Base64 ciphertext | The user's password, encrypted with AES-256-CBC |
| `BIOMETRIC-USER-EMAIL` | Plaintext email | Used to auto-fill email during biometric login |
| `BIOMETRIC-ENROLLED` | `"true"` / absent | Whether the user has enrolled biometric login |

### Alternatives Considered

| Alternative | Why Not |
|---|---|
| Store key in Hive itself | Circular dependency — the key that decrypts Hive can't be stored inside Hive. |
| Hardcoded key | Trivially extractable from the APK binary. Completely insecure. |
| `shared_preferences` | Not encrypted, stored as plaintext XML on Android. |
| Custom native plugin | Unnecessary; `flutter_secure_storage` already wraps Keystore/Keychain with a well-tested API. |

---

## 6. Biometric Authentication — Hardware-Backed Keys

### Decision

Use **`biometric_signature`** for hardware-backed ECDSA key generation and **AES-256-CBC** (via the `encrypt` package) for encrypting the user's password at rest.

### Context

The assessment requires biometric login for returning users. The challenge: Firebase Auth requires an email + password. We must securely store the password so it can be retrieved after biometric verification without exposing it in plaintext.

### Implementation Flow

**Enrollment (after first login/register):**

```
1. User enters email + password → Firebase Auth succeeds
2. Prompt: "Register biometric for secure login?"
3. If yes:
   a. Generate hardware-backed ECDSA key pair (biometric_signature)
   b. Generate random AES-256 key (32 bytes) + IV (16 bytes)
   c. Encrypt(password, AES-key, IV) → ciphertext
   d. Store in flutter_secure_storage:
      - AES key, IV, ciphertext, email, enrolled=true
   e. Store public key in Firestore user doc (for future server-side verification)
4. Biometric is now enrolled for this device
```

**Biometric Login (returning user):**

```
1. User taps "Sign in with Biometric"
2. BiometricAuthService.authenticate() → OS biometric prompt
3. If biometric verified:
   a. Read email, AES key, IV, ciphertext from secure storage
   b. Decrypt(ciphertext, AES-key, IV) → password
   c. FirebaseAuth.signInWithEmailAndPassword(email, password)
4. User is logged in
```

### Rationale

- **No password in plaintext:** The password is AES-256-CBC encrypted. The AES key lives in hardware-backed secure storage.
- **Device binding:** The `DeviceIdService` captures Android `fingerprint` or iOS `identifierForVendor`. This ID is stored in Firestore so the server can verify which device is enrolled.
- **Hardware-backed biometric:** `biometric_signature` generates keys that are invalidated if biometric enrollment changes on the device (e.g., a new fingerprint is added), preventing unauthorized access.

### Alternatives Considered

| Alternative | Why Not |
|---|---|
| Store password in plaintext in SecureStorage | SecureStorage is secure, but AES encryption adds a second layer in case SecureStorage is compromised. |
| Firebase custom token via biometric challenge | Requires a backend Cloud Function to mint custom tokens. Adds infrastructure complexity for a mobile-only assessment. |
| `local_auth` (simple biometric) | Only provides a boolean gate (authenticated/not). Doesn't provide cryptographic keys. `biometric_signature` provides hardware-backed ECDSA keys for true cryptographic authentication. |

---

## 7. Network & Performance — Isolates

### Decision

Use Dart **Isolates** (`compute()`) for JSON parsing of the ~10,000-item branches dataset and for computing the nearest-50 branches via Haversine distance.

### Context

The assessment requires: *"Background work: parsing/filtering in isolate so UI stays smooth (60fps)"*. The branches JSON is ~2MB with ~10,000 items.

### Implementation

**1. JSON Parsing in Isolate:**

```dart
// In BranchesRemoteDataSource
final String raw = response.data as String;  // Plain text response
final List<BranchesResponseModel> branches = await compute(_parseBranches, raw);

// Top-level function (required for compute/isolate)
List<BranchesResponseModel> _parseBranches(String raw) {
  final List<dynamic> jsonList = jsonDecode(raw) as List<dynamic>;
  return jsonList
      .map((dynamic e) => BranchesResponseModel.fromJson(e as Map<String, dynamic>))
      .toList();
}
```

**2. Nearest-50 Filter in Isolate:**

```dart
// In BranchesCubit
final FilteredBranchesResult filtered = await compute(
  _filterBranchesInIsolate,
  _FilterPayload(branches: allBranches, userLat: lat, userLng: lng, nearestCount: 50),
);

// Top-level function
FilteredBranchesResult _filterBranchesInIsolate(_FilterPayload payload) {
  // Compute Haversine distance for each branch
  // Sort by distance
  // Return top 50 as "nearest" and the rest as "others"
}
```

### Rationale

- **UI thread stays free:** `compute()` spawns a new isolate, runs the function, and returns the result. The main thread is never blocked.
- **Simple API:** `compute()` handles isolate lifecycle (spawn, send, receive, kill) automatically. No manual isolate management needed.
- **Top-level functions:** Dart requires the function passed to `compute()` to be top-level (not a closure or instance method), which enforces a clean separation between the parsing logic and the class state.
- **Chunked caching:** After parsing, branches are saved to Hive in chunks of 5,000 with `Future.delayed(Duration.zero)` between chunks to yield to the event loop.

### Performance Impact

| Operation | Without Isolate | With Isolate |
|---|---|---|
| Parse ~10,000 items | ~300-500ms UI jank | 0ms UI jank (runs in background) |
| Haversine for ~10,000 items | ~100-200ms UI jank | 0ms UI jank |
| Total user-perceived delay | Visible stutter | Smooth loading indicator |

### Alternatives Considered

| Alternative | Why Not |
|---|---|
| `jsonDecode` on main thread | 10,000 items would cause noticeable jank (dropped frames). |
| `Isolate.spawn` (manual) | More control but more boilerplate. `compute()` is sufficient for fire-and-forget parsing. |
| Background service (`workmanager`) | Overkill for one-shot parsing. Designed for periodic background tasks. |

---

## 8. Offline-First Data Strategy

### Decision

Implement an **offline-first, remote-wins** sync strategy for both branches and favorites.

### Context

The assessment requires: *"Persist branch/ATM data; sync Favorite Branches with Firebase"*.

### Strategy

```
┌──────────────────────────────────────────────────┐
│                  READ FLOW                        │
│                                                  │
│  1. Read from local cache (instant, offline-safe)│
│  2. Emit cached data → UI renders immediately    │
│  3. Fetch from remote in background              │
│  4. If remote succeeds:                          │
│     a. Replace local cache with remote data      │
│     b. Emit fresh data → UI updates              │
│  5. If remote fails:                             │
│     a. Keep showing cached data                  │
│     b. Log error for debugging                   │
└──────────────────────────────────────────────────┘

┌──────────────────────────────────────────────────┐
│               WRITE FLOW (Favorites)              │
│                                                  │
│  1. Optimistic local write (instant UI update)   │
│  2. Fire remote write in background              │
│  3. If remote fails:                             │
│     a. Local data persists                       │
│     b. Will sync on next loadFavorites() call    │
│     c. Remote-wins on next sync                  │
└──────────────────────────────────────────────────┘
```

### Branches Sync

- **Direction:** Remote → Local (one-way). Branch data is read-only.
- **Conflict resolution:** Remote always wins. Local cache is cleared and replaced on each successful fetch.
- **Chunked writes:** 5,000 items per batch to avoid blocking the event loop.

### Favorites Sync

- **Direction:** Bidirectional (local ↔ remote).
- **Conflict resolution:** Remote wins. On `syncFavorites()`, the remote list replaces the local cache entirely.
- **Optimistic writes:** `addFavorite()` and `removeFavorite()` update local first for instant UI feedback, then write to Firestore in the background.
- **Failure handling:** If remote write fails, the local state is preserved. On the next `loadFavorites()`, remote data syncs down and reconciles.

### Rationale

- **Instant UI:** Users see data immediately from cache, even offline.
- **Simplicity:** Remote-wins avoids complex merge logic. For a single-user, single-device scenario, this is sufficient and easy to reason about.
- **Graceful degradation:** Full offline support — the app is usable without internet after the initial data fetch.

---

## 9. Firebase Security Rules

### Decision

Use **per-user Firestore security rules** with a subcollection pattern for favorites.

### Implementation

```javascript
rules_version = '2';
service cloud.firestore {
  match /databases/{database}/documents {
    match /users/{userId} {
      allow read, write: if request.auth != null && request.auth.uid == userId;

      match /favorites/{branchId} {
        allow read, write: if request.auth != null && request.auth.uid == userId;
      }
    }
  }
}
```

### Data Model

```
Firestore
├── users/
│   └── {userId}/                          ← doc ID = Firebase Auth UID
│       ├── email, name, deviceId, ...     ← user profile fields
│       └── favorites/                     ← subcollection
│           └── {branchId}/                ← doc ID = branch ID
│               ├── name, address, lat, lng, ...
```

### Rationale

- **Subcollection approach:** Favorites live under `users/{uid}/favorites/` instead of a top-level `favorites` collection. This makes the security rule simpler — the parent wildcard `{userId}` is reused for the subcollection match.
- **UID-based document IDs:** User documents use Firebase Auth UID as the document ID (`_client.collection('users').doc(uid)`). This eliminates queries and makes security rules trivial.
- **No admin access:** There are no wildcard rules that allow any authenticated user to read all data. Each user is strictly sandboxed.

---

## 10. State Management — BLoC / Cubit

### Decision

Use **Cubit** (from `flutter_bloc`) as the primary state management solution.

### Context

Each feature requires reactive state (loading, loaded, error) with async data flows (network + cache).

### Rationale

- **Predictable state:** `emit()` produces a new immutable state. `BlocBuilder` rebuilds only when state changes (via `Equatable`).
- **Testable:** Cubits can be unit-tested by verifying emitted state sequences.
- **Separation:** Business logic lives in the Cubit, not in widgets. Widgets are pure UI.
- **Cubit over BLoC:** Cubit is simpler (function calls vs. event classes). The app's use cases (fetch, toggle, login) don't benefit from the event-driven BLoC pattern's added complexity.

### State Pattern

All states follow a consistent pattern using a `GenericStateStatus` enum:

```dart
enum GenericStateStatus { initial, loading, loaded, error, changeUi, validationError }

class FeatureState extends Equatable {
  final GenericStateStatus status;
  final String? errorMsg;
  final List<Model>? data;
  // ... copyWith, props
}
```

---

## 11. Dependency Injection — GetIt + Injectable

### Decision

Use **GetIt** as the service locator with **Injectable** for compile-time code generation.

### Rationale

- **Compile-time safety:** `injectable` generates registration code at build time. Missing registrations surface as build errors, not runtime crashes.
- **Lazy singletons:** Services like `SecureStorageService`, `BaseDatabase`, and repositories are `@lazySingleton` — created once on first access and shared across the app.
- **Module registration:** Firebase services (`FirebaseAuth`, `FirebaseFirestore`) and `Dio` are registered via `@module` in `RegisterModule`, keeping third-party initialization centralized.

---

## 12. Navigation — GoRouter with Auth Guards

### Decision

Use **GoRouter** with `StatefulShellRoute` for tab-based navigation and `AuthStateNotifier` for reactive auth redirects.

### Implementation

- **Auth guard:** `redirect` callback checks `AuthStateNotifier.currentUser`. Unauthenticated users are sent to `/login`; authenticated users on `/login` are sent to `/home`.
- **Reactive refresh:** `refreshListenable: _authNotifier` triggers route re-evaluation whenever Firebase auth state changes (login, logout, token expiry).
- **Tab persistence:** `StatefulShellBranch` maintains separate navigator stacks for Home, Branches, and Favorites tabs.

### Rationale

- **Declarative:** Routes are defined as data, not imperative `Navigator.push` calls.
- **Deep linking ready:** GoRouter supports URL-based navigation for future web support.
- **Auth-aware:** The `redirect` + `refreshListenable` pattern ensures no widget tree can exist in an unauthenticated state.

---

## 13. Summary of Key Decisions

| Decision | Choice | Key Reason |
|---|---|---|
| **Local DB** | Hive CE | Built-in AES encryption, pure Dart, NoSQL fits flat branch data |
| **Encryption** | AES-256 (HiveAesCipher) | Industry-standard, zero extra dependencies, box-level encryption |
| **Key Storage** | flutter_secure_storage | Hardware-backed (Android Keystore / iOS Keychain), platform-abstracted |
| **Biometric** | biometric_signature + AES-CBC | Hardware ECDSA keys, encrypted password storage, device binding |
| **Network Parsing** | Dart Isolates (compute) | Offloads ~10K JSON parsing to background, keeps UI at 60fps |
| **State Management** | Cubit (flutter_bloc) | Predictable, testable, simpler than full BLoC for this scope |
| **Sync Strategy** | Offline-first, remote-wins | Instant UI from cache, simple conflict resolution |
| **Firebase Rules** | Per-user subcollection | UID-based access, no cross-user data leakage |
| **DI** | GetIt + Injectable | Compile-time safety, lazy singletons, modular registration |
| **Navigation** | GoRouter + AuthStateNotifier | Declarative routing, reactive auth guards, tab persistence |
| **Architecture** | Feature-based clean architecture | Separation of concerns, scalable, testable |

---

## Appendix: Security Threat Model

| Threat | Mitigation |
|---|---|
| **Data at rest on stolen device** | All Hive boxes encrypted with AES-256. Key in hardware-backed storage. Unreadable without user's biometric/passcode. |
| **Man-in-the-middle** | All network traffic over HTTPS. Firebase SDK enforces TLS. |
| **Weak passwords** | Validators enforce min 8 chars, at least one letter + one number. |
| **Cross-user data access** | Firestore rules enforce `request.auth.uid == userId`. No wildcard rules. |
| **Session hijacking** | Firebase Auth tokens are short-lived and auto-refreshed. GoRouter redirect checks auth state on every navigation. |
| **Biometric spoofing** | `biometric_signature` uses hardware-backed keys that are invalidated if device biometric enrollment changes. |
| **Key extraction from APK** | No keys are hardcoded. All secrets are in `.env` (gitignored) or generated at runtime and stored in hardware-backed storage. |
| **Logout data leakage** | Logout clears user data, branches cache, favorites cache from Hive AND deletes the Hive encryption key from secure storage, rendering old encrypted data permanently unreadable. |
