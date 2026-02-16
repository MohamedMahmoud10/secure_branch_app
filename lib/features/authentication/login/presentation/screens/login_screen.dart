import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_branch_app/core/di/index.dart';
import 'package:secure_branch_app/features/authentication/login/data/repo/get_user_data_repo.dart';
import 'package:secure_branch_app/features/authentication/login/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:secure_branch_app/features/authentication/login/presentation/widgets/login_widgets/index.dart';

class LoginScreen extends StatelessWidget {
  const LoginScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<LoginCubit>(
      create: (BuildContext context) =>
          LoginCubit(di<GetUserDataRepo>(), di<FirebaseAuth>()),
      child: const Scaffold(body: LoginBody(),bottomNavigationBar: LoginActionButton(),),
    );
  }
}
