import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

/// Notifies GoRouter when auth state changes so redirect can run.
class AuthStateNotifier extends ChangeNotifier {
  AuthStateNotifier(this._auth) {
    _subscription = _auth.authStateChanges().listen(_onAuthStateChanged);
  }

  final FirebaseAuth _auth;
  StreamSubscription<User?>? _subscription;

  User? _user;
  User? get currentUser => _user;

  void _onAuthStateChanged(User? user) {
    if (_user?.uid != user?.uid) {
      _user = user;
      notifyListeners();
    }
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }
}
