import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_google/src/data/models/form.dart';
import 'package:flutter_form_google/src/data/user_prefs.dart';
import 'package:get_it/get_it.dart';

part 'home_state.dart';

class HomeBloc extends Cubit<HomeState> {
  HomeBloc() : super(HomeState.init());

  void addNewForm(MFormData value) {
    final list = [...state.froms];
    list.add(value);
    emit(state.copyWith(froms: list));
    GetIt.I<UserPrefs>().setForms(list);
  }

  void editNewForm(MFormData value) {
    final list = [...state.froms];
    final int position = list.indexWhere((element) => element.id == value.id);
    if (position != -1) list[position] = value;
    emit(state.copyWith(froms: list));
    GetIt.I<UserPrefs>().setForms(list);
  }

  void removeForm(String id) {
    final list = [...state.froms];
    list.removeWhere((e) => e.id == id);
    emit(state.copyWith(froms: list));
    GetIt.I<UserPrefs>().setForms(list);
  }
}
