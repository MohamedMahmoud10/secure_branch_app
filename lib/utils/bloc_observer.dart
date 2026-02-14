import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:secure_branch_app/utils/app_logger.dart';

class AppBlocObserver extends BlocObserver {
  @override
  void onCreate(BlocBase<dynamic> bloc) {
    super.onCreate(bloc);
    AppLogger().info('onCreate -- ${bloc.runtimeType}');
  }

  @override
  void onEvent(Bloc<dynamic,dynamic> bloc, Object? event) {
    super.onEvent(bloc, event);

    AppLogger().info('onEvent -- ${bloc.runtimeType}, $event');
  }

  @override
  void onChange(BlocBase<dynamic> bloc, Change<dynamic> change) {
    super.onChange(bloc, change);
    AppLogger().info('onChange -- ${bloc.runtimeType}, $change');
  }

  @override
  void onTransition(Bloc<dynamic,dynamic>  bloc, Transition<dynamic,dynamic>  transition) {
    super.onTransition(bloc, transition);
    AppLogger().info('onTransition -- ${bloc.runtimeType}, $transition');
  }

  @override
  void onError(BlocBase<dynamic> bloc, Object error, StackTrace stackTrace) {
    AppLogger().info('onError -- ${bloc.runtimeType}, $error');

    super.onError(bloc, error, stackTrace);
  }

  @override
  void onClose(BlocBase<dynamic> bloc) {
    super.onClose(bloc);
    AppLogger().info('onClose -- ${bloc.runtimeType}');
  }
}
