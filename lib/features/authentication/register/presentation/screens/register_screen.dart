import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_branch_app/core/di/index.dart';
import 'package:secure_branch_app/features/authentication/register/presentation/cubits/register_cubit/register_cubit.dart';
import 'package:secure_branch_app/features/authentication/register/presentation/widgets/signup_widgets/index.dart';

class RegisterScreen extends StatelessWidget {
  const RegisterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RegisterCubit>(
      create: (BuildContext context) => di<RegisterCubit>(),
      child: const Scaffold(
        body: RegisterBody(),
        bottomNavigationBar: RegisterActionButton(),
      ),
    );
  }
}
