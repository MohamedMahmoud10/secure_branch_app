import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:secure_branch_app/config/app_constant_strings.dart';

class DatabaseConstants {
  const DatabaseConstants._();

  ///Start REGION OF TABLES OF CACHES DATA ON FIRESTORE DATA BASE

  static const String individualsCollection = 'individualsCollection';
  static const String institutionsCollection = 'institutionsCollection';
  static const String companiesCollection = 'companiesCollection';
  static const String uIRealTimeChangesCollection =
      'uIRealTimeChangesCollection';
  static const String allServicesCollection = 'allServicesCollection';
  static final String reviewsCollection = dotenv.get(
    AppConstantStrings.reviewsCollection,
  );

  static const String contacts = 'contactsCollection';
  static const String usersTokensCollection = 'usersTokensCollection';
  static final String usersDataCollection = dotenv.get(
    AppConstantStrings.usersDataCollection,
  );
  static const String transactionsCollection = 'transactionsCollection';
  static const String serviceDetailsSubCollection = 'details';
  static final String notificationsCollection = dotenv.get(
    AppConstantStrings.notificationsCollection,
  );

  ///END REGION OF TABLES OF CACHES DATA ON FIRESTORE DATA BASE

  ///START REGION OF TABLES OF CACHES DATA ON HIVE LOCAL DATA BASE

  static const String userDataTable = 'USER-DATA-TABLE';
  static const String userDataBoolTable = 'USER-DATA-BOOL-TABLE';
  static const String servicesDataTable = 'SERVICES-DATA-TABLE';

  ///END REGION OF TABLES OF CACHES DATA ON HIVE LOCAL DATA BASE

  ///Start REGION OF CACHE KEYS
  static const String userDataKey = 'USER-DATA-VALUE';
  static const String hasAcceptPolicyKey = 'HAS-ACCEPT-POLICY-VALUE';
  static const String themeKey = 'isDarkMode';
  static const String completeLogin = 'COMPLETE-LOGIN-VALUE';

  ///END REGION OF TABLES OF CACHES DATA ON HIVE LOCAL DATA BASE

  /// Start REGION UNUSED COLLECTIONS
  static const String chatCollection = 'chatCollection';

/// End REGION UNUSED COLLECTIONS
}
