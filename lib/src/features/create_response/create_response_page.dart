import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_google/src/data/models/form.dart';
import 'package:flutter_form_google/src/features/create_response/logic/create_response_bloc.dart';
import 'package:flutter_form_google/src/features/create_response/widget/question_widget.dart';

class CreateResponsePage extends StatelessWidget {
  const CreateResponsePage({super.key, required this.item});
  static const routeName = '/create-response';
  final MFormData item;
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CreateResponseBLoc(item),
      child: BlocBuilder<CreateResponseBLoc, CreateResponseState>(
          builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text(item.title),
            actions: [
              ElevatedButton(
                  onPressed: () {
                    // TODO
                  },
                  child: Text("Submit"))
            ],
          ),
          body: CustomScrollView(
            slivers: [
              _buildQuestion(context, state),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildQuestion(BuildContext context, CreateResponseState state) {
    return SliverPadding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
      sliver: SliverList.separated(
        itemCount: state.formData.questions.length,
        itemBuilder: (context, index) {
          final question = state.formData.questions[index];
          final result = state.answers.question[index];
          return Card(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Padding(
                  padding: const EdgeInsets.fromLTRB(12, 12, 12, 12),
                  child: Text(
                    question.question + (question.isRequired ? " ***" : ""),
                    style: const TextStyle(
                        color: Colors.black,
                        fontSize: 16,
                        fontWeight: FontWeight.bold),
                  ),
                ),
                QuestionWidget(
                    index: index, question: question, result: result),
              ],
            ),
          );
        },
        separatorBuilder: (_, __) {
          return const SizedBox(height: 16);
        },
      ),
    );
  }
}
