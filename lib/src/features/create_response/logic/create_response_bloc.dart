import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_google/src/data/models/answer.dart';
import 'package:flutter_form_google/src/data/models/form.dart';
import 'package:uuid/uuid.dart';

part 'create_response_state.dart';

class CreateResponseBLoc extends Cubit<CreateResponseState> {
  CreateResponseBLoc(MFormData formData)
      : super(CreateResponseState.init(formData));

}
