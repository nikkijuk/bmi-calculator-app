import 'package:bloc/bloc.dart';

// this file is copy paste from documentation site
// "BlocObserver can be used to observe all cubits"
// https://pub.dev/packages/bloc

// one needs to know that bloc is subclass of cubit
// difference
// - cubit emits state objects and has state,
//    state is changed when methods of cubit are called
// - bloc emits state objects and has state,
//   state is changed when bloc receives events thru sink
class SimpleBlocObserver extends BlocObserver {
  @override
  void onChange(BlocBase bloc, Change change) {
    print('${bloc.runtimeType} $change');
    super.onChange(bloc, change);
  }

  @override
  void onTransition(Bloc bloc, Transition transition) {
    print('${bloc.runtimeType} $transition');
    super.onTransition(bloc, transition);
  }

  @override
  void onError(BlocBase bloc, Object error, StackTrace stackTrace) {
    print('${bloc.runtimeType} $error $stackTrace');
    super.onError(bloc, error, stackTrace);
  }
}