import 'package:injectable/injectable.dart';
import 'package:secure_branch_app/core/infrastructure/local_data_base/base_local_data_base.dart';
import 'package:secure_branch_app/core/utilities/constants/index.dart';
import 'package:secure_branch_app/features/branch/data/models/branches_response_model.dart';

@lazySingleton
class BranchesLocalDataSource {
  BranchesLocalDataSource(this._db);

  final BaseDatabase _db;

  Future<List<BranchesResponseModel>> getCachedBranches() async {
    return _db.getAll<BranchesResponseModel>(
          tableName: DatabaseConstants.branchesTable,
        ) ??
        <BranchesResponseModel>[];
  }

  Future<void> cacheBranches(List<BranchesResponseModel> branches) async {
    await _db.clear<BranchesResponseModel>(
      tableName: DatabaseConstants.branchesTable,
    );

    const int chunkSize = 5000;
    for (int i = 0; i < branches.length; i += chunkSize) {
      final int end = (i + chunkSize < branches.length)
          ? i + chunkSize
          : branches.length;
      final List<BranchesResponseModel> chunk = branches.sublist(i, end);

      await _db.saveAll<BranchesResponseModel>(
        tableName: DatabaseConstants.branchesTable,
        list: chunk,
        keys: chunk.map((BranchesResponseModel e) => e.id).toList(),
      );

      await Future<void>.delayed(Duration.zero);
    }
  }
}
