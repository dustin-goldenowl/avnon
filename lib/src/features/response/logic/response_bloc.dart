import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_google/src/data/models/form.dart';
import 'package:flutter_form_google/src/data/models/question.dart';
import 'package:flutter_form_google/src/data/user_prefs.dart';
import 'package:get_it/get_it.dart';

part 'response_state.dart';

class ResponseBloc extends Cubit<ResponseState> {
  ResponseBloc(MFormData formData) : super(ResponseState.ds(formData));
}
