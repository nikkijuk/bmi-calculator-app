import 'package:bloc/bloc.dart';

// this file is copy paste from documentation site
// https://pub.dev/packages/bloc
// one needs to know that bloc is subclass of cubit
// difference
// - cubit emits state objects and has state,
//    state is changed when methods of cubit are called
// - bloc emits state objects and has state,
//   state is changed when bloc receives events thru sink
class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(Cubit cubit, Change change) {
    print('${cubit.runtimeType} $change');
    super.onChange(cubit, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('${bloc.runtimeType} $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(Cubit cubit, Object error, StackTrace stackTrace) {
    print('${cubit.runtimeType} $error $stackTrace');
    super.onError(cubit, error, stackTrace);
  }
}