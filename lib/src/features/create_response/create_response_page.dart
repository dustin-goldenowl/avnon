import 'package:flutter/material.dart';
import 'package:flutter_form_google/src/data/models/form.dart';
import 'package:flutter_form_google/src/data/models/question.dart';

class CreateRepsonsePage extends StatelessWidget {
  const CreateRepsonsePage({super.key, required this.editFormData});
  final MFormData editFormData;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Answer Question"),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return ListView.builder(
        itemCount: editFormData.questions.length,
        itemBuilder: (context, position) {
          return _itemQuestion(context,
              mQuestion: editFormData.questions[position]);
        });
  }

  Widget _itemQuestion(BuildContext context, {required MQuestion mQuestion}) {
    return Card(
      elevation: 2,
      child: Column(
        children: [Text(mQuestion.question)],
      ),
    );
  }
}
