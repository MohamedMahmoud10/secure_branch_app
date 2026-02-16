import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:secure_branch_app/config/app_constant_strings.dart';

class DatabaseConstants {
  const DatabaseConstants._();

  ///Start REGION OF TABLES OF CACHES DATA ON FIRESTORE DATA BASE
  static final String usersDataCollection = dotenv.get(
    AppConstantStrings.usersDataCollection,
  );
  static final String userTransactionCollection = dotenv.get(
    AppConstantStrings.transactionCollection,
  );

  ///END REGION OF TABLES OF CACHES DATA ON FIRESTORE DATA BASE

  ///START REGION OF TABLES OF CACHES DATA ON HIVE LOCAL DATA BASE

  static const String userDataTable = 'USER-DATA-TABLE';
  static const String branchesTable = 'BRANCHES-TABLE';

  ///END REGION OF TABLES OF CACHES DATA ON HIVE LOCAL DATA BASE

  ///Start REGION OF CACHE KEYS
  static const String userDataKey = 'USER-DATA-VALUE';

  ///END REGION OF TABLES OF CACHES DATA ON HIVE LOCAL DATA BASE

}
