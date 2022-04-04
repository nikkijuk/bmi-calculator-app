import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';

// Responsible for handling the current [Locale]
//
// Consumes [Locale]s as events and emits them as state.
// Think of the [LocalizationBloc] as a middleman that hold the
// current [Locale] and notifies its listeners once the [Locale]
// changes.
class LocalizationBloc extends Bloc<Locale, Locale> {

  // call super with default locale to give initial value
  LocalizationBloc() : super(defaultLocale) {

    // register listening of locale select events
    on<Locale>((event, emit) {

      // emit event to listeners
      emit(event);
    });
  }

  // hardcoded default locale
  static const Locale defaultLocale = Locale('en');

}
