// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:cloud_firestore/cloud_firestore.dart' as _i974;
import 'package:dio/dio.dart' as _i361;
import 'package:firebase_auth/firebase_auth.dart' as _i59;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../features/authentication/biometric_login/data/remote_data_source/biometric_remote_data_source.dart'
    as _i435;
import '../../features/authentication/biometric_login/data/repo/biometric_login_repo.dart'
    as _i10;
import '../../features/authentication/biometric_login/presentation/cubits/biometric_login_cubit/biometric_login_cubit.dart'
    as _i549;
import '../../features/authentication/login/data/remote_data_source/get_user_data_remote_data_source.dart'
    as _i480;
import '../../features/authentication/login/data/repo/get_user_data_repo.dart'
    as _i1058;
import '../../features/authentication/logout/data/auth_logout_service.dart'
    as _i22;
import '../../features/authentication/register/presentation/cubits/register_cubit/register_cubit.dart'
    as _i78;
import '../../features/authentication/store_user_data/data/data_sources/local_data_source/save_user_data_local_data_source.dart'
    as _i458;
import '../../features/authentication/store_user_data/data/data_sources/remote_data_source/store_user_data_remote_data_source.dart'
    as _i897;
import '../../features/authentication/store_user_data/data/repo/store_user_data_repo.dart'
    as _i73;
import '../../features/branch/data/data_sources/local_data_source/branches_local_data_source.dart'
    as _i1034;
import '../../features/branch/data/data_sources/remote_data_source/branches_remote_data_source.dart'
    as _i707;
import '../../features/branch/data/repo/branches_repo.dart' as _i590;
import '../../features/favorites/data/data_sources/local_data_source/favorites_local_data_source.dart'
    as _i128;
import '../../features/favorites/data/data_sources/remote_data_source/favorites_remote_data_source.dart'
    as _i430;
import '../../features/favorites/data/repo/favorites_repo.dart' as _i742;
import '../../features/transactions/data/remote_data_source/add_transaction_remote_data_source.dart'
    as _i640;
import '../../features/transactions/data/remote_data_source/user_transactions_remote_data_source.dart'
    as _i804;
import '../../features/transactions/data/repo/add_transaction_repo.dart'
    as _i704;
import '../../features/transactions/data/repo/user_transactions_repo.dart'
    as _i330;
import '../infrastructure/local_data_base/base_local_data_base.dart' as _i405;
import '../infrastructure/local_data_base/hive_local_data_base.dart' as _i393;
import '../infrastructure/network/api_consumer.dart' as _i865;
import '../infrastructure/network/app_interceptor.dart' as _i356;
import '../infrastructure/network/dio_consumer.dart' as _i774;
import '../infrastructure/secure_storage/secure_storage_service.dart' as _i973;
import '../services/biometric_auth_service.dart' as _i919;
import '../services/biometric_crypto_service.dart' as _i134;
import '../services/device_id_service.dart' as _i148;
import 'register_module.dart' as _i291;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    gh.lazySingleton<_i59.FirebaseAuth>(() => registerModule.firebaseAuth);
    gh.lazySingleton<_i974.FirebaseFirestore>(() => registerModule.fireStore);
    gh.lazySingleton<_i361.Dio>(() => registerModule.dio);
    gh.lazySingleton<_i356.AppInterceptors>(() => _i356.AppInterceptors());
    gh.lazySingleton<_i973.SecureStorageService>(
      () => _i973.SecureStorageService(),
    );
    gh.lazySingleton<_i919.BiometricAuthService>(
      () => _i919.BiometricAuthService(),
    );
    gh.lazySingleton<_i148.DeviceIdService>(() => _i148.DeviceIdService());
    gh.lazySingleton<_i134.BiometricCryptoService>(
      () => _i134.BiometricCryptoService(gh<_i973.SecureStorageService>()),
    );
    gh.lazySingleton<_i405.BaseDatabase>(
      () => _i393.HiveDatabaseClient(gh<_i973.SecureStorageService>()),
    );
    gh.lazySingleton<_i435.BiometricRemoteDataSource>(
      () => _i435.BiometricRemoteDataSource(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i480.GetUserDataRemoteDataSource>(
      () => _i480.GetUserDataRemoteDataSource(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i897.StoreUserDataRemoteDataSource>(
      () => _i897.StoreUserDataRemoteDataSource(gh<_i974.FirebaseFirestore>()),
    );
    gh.lazySingleton<_i458.SaveUserDataLocalDataSource>(
      () => _i458.SaveUserDataLocalDataSource(gh<_i405.BaseDatabase>()),
    );
    gh.lazySingleton<_i73.StoreUserDataRepo>(
      () => _i73.StoreUserDataRepo(
        gh<_i897.StoreUserDataRemoteDataSource>(),
        gh<_i458.SaveUserDataLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i22.AuthLogoutService>(
      () => _i22.AuthLogoutService(
        gh<_i59.FirebaseAuth>(),
        gh<_i405.BaseDatabase>(),
        gh<_i973.SecureStorageService>(),
      ),
    );
    gh.lazySingleton<_i865.ApiConsumer>(
      () => _i774.DioConsumer(client: gh<_i361.Dio>()),
    );
    gh.lazySingleton<_i430.FavoritesRemoteDataSource>(
      () => _i430.FavoritesRemoteDataSource(
        gh<_i974.FirebaseFirestore>(),
        gh<_i405.BaseDatabase>(),
      ),
    );
    gh.lazySingleton<_i640.AddTransactionRemoteDataSource>(
      () => _i640.AddTransactionRemoteDataSource(
        gh<_i974.FirebaseFirestore>(),
        gh<_i405.BaseDatabase>(),
      ),
    );
    gh.lazySingleton<_i804.UserTransactionsRemoteDataSource>(
      () => _i804.UserTransactionsRemoteDataSource(
        gh<_i974.FirebaseFirestore>(),
        gh<_i405.BaseDatabase>(),
      ),
    );
    gh.lazySingleton<_i1034.BranchesLocalDataSource>(
      () => _i1034.BranchesLocalDataSource(gh<_i405.BaseDatabase>()),
    );
    gh.lazySingleton<_i128.FavoritesLocalDataSource>(
      () => _i128.FavoritesLocalDataSource(gh<_i405.BaseDatabase>()),
    );
    gh.lazySingleton<_i742.FavoritesRepo>(
      () => _i742.FavoritesRepo(
        gh<_i430.FavoritesRemoteDataSource>(),
        gh<_i128.FavoritesLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i10.BiometricLoginRepo>(
      () => _i10.BiometricLoginRepo(
        gh<_i435.BiometricRemoteDataSource>(),
        gh<_i458.SaveUserDataLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i1058.GetUserDataRepo>(
      () => _i1058.GetUserDataRepo(
        gh<_i480.GetUserDataRemoteDataSource>(),
        gh<_i458.SaveUserDataLocalDataSource>(),
      ),
    );
    gh.lazySingleton<_i330.UserTransactionsRepo>(
      () => _i330.UserTransactionsRepo(
        gh<_i804.UserTransactionsRemoteDataSource>(),
      ),
    );
    gh.lazySingleton<_i707.BranchesRemoteDataSource>(
      () => _i707.BranchesRemoteDataSource(gh<_i865.ApiConsumer>()),
    );
    gh.lazySingleton<_i704.AddTransactionRepo>(
      () =>
          _i704.AddTransactionRepo(gh<_i640.AddTransactionRemoteDataSource>()),
    );
    gh.lazySingleton<_i590.BranchesRepo>(
      () => _i590.BranchesRepo(
        gh<_i707.BranchesRemoteDataSource>(),
        gh<_i1034.BranchesLocalDataSource>(),
      ),
    );
    gh.factory<_i549.BiometricLoginCubit>(
      () => _i549.BiometricLoginCubit(
        gh<_i919.BiometricAuthService>(),
        gh<_i134.BiometricCryptoService>(),
        gh<_i148.DeviceIdService>(),
        gh<_i1058.GetUserDataRepo>(),
        gh<_i59.FirebaseAuth>(),
      ),
    );
    gh.factory<_i78.RegisterCubit>(
      () => _i78.RegisterCubit(
        gh<_i73.StoreUserDataRepo>(),
        gh<_i59.FirebaseAuth>(),
        gh<_i148.DeviceIdService>(),
        gh<_i919.BiometricAuthService>(),
        gh<_i134.BiometricCryptoService>(),
        gh<_i10.BiometricLoginRepo>(),
      ),
    );
    return this;
  }
}

class _$RegisterModule extends _i291.RegisterModule {}
