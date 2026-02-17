import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_branch_app/core/di/index.dart';
import 'package:secure_branch_app/core/services/biometric_auth_service.dart';
import 'package:secure_branch_app/core/services/biometric_crypto_service.dart';
import 'package:secure_branch_app/core/services/device_id_service.dart';
import 'package:secure_branch_app/features/authentication/biometric_login/data/repo/biometric_login_repo.dart';
import 'package:secure_branch_app/features/authentication/biometric_login/presentation/cubits/biometric_login_cubit/biometric_login_cubit.dart';
import 'package:secure_branch_app/features/authentication/login/data/repo/get_user_data_repo.dart';
import 'package:secure_branch_app/features/authentication/login/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:secure_branch_app/features/authentication/login/presentation/widgets/login_widgets/index.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider<dynamic>>[
        BlocProvider<LoginCubit>(
          create: (_) => LoginCubit(
            di<GetUserDataRepo>(),
            di<FirebaseAuth>(),
            di<BiometricAuthService>(),
            di<BiometricCryptoService>(),
            di<DeviceIdService>(),
            di<BiometricLoginRepo>(),
          ),
        ),
        BlocProvider<BiometricLoginCubit>(
          create: (_) => di<BiometricLoginCubit>()..checkBiometricAvailability(),
        ),
      ],
      child: const Scaffold(
        body: LoginBody(),
        bottomNavigationBar: LoginActionButton(),
      ),
    );
  }
}
