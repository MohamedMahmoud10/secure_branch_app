import 'package:get_it/get_it.dart';
import 'package:injectable/injectable.dart';
import 'package:secure_branch_app/core/di/di.config.dart';

final GetIt di = GetIt.instance;

@InjectableInit(
  preferRelativeImports: true,
)
void configureDependencies() => di.init();
