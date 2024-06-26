import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_google/src/data/models/form.dart';
import 'package:flutter_form_google/src/data/models/question.dart';
import 'package:flutter_form_google/src/data/models/question_type.dart';
import 'package:flutter_form_google/src/features/response/logic/response_bloc.dart';

class ResponsePage extends StatelessWidget {
  const ResponsePage({super.key, required this.formData});
  final MFormData formData;

  static const routeName = '/response';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ResponseBloc(formData),
      child:
          BlocBuilder<ResponseBloc, ResponseState>(builder: (context, state) {
        final questions = state.formData.questions;
        return Scaffold(
          appBar: AppBar(title: const Text('Response')),
          body: ListView.separated(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            itemCount: questions.length,
            itemBuilder: (context, index) {
              final item = questions[index];
              final responses = state.responseOfQuestion(item.id);
              return _buildResponse(context, item, responses);
            },
            separatorBuilder: (_, __) => const SizedBox(height: 12),
          ),
        );
      }),
    );
  }

  Widget _buildResponse(
      BuildContext context, MQuestion item, List<MQuestion> responses) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              item.question,
              style: Theme.of(context).textTheme.titleSmall,
            ),
            Text('${responses.length} response(s)'),
            if (responses.isNotEmpty) ...[
              const SizedBox(height: 5),
              if (item.type == MQuestionType.paragraph)
                _buildParagraph(context, item, responses)
              else
                _buildMultipleChoice(context, item, responses),
            ],
          ],
        ),
      ),
    );
  }

  Widget _buildParagraph(
      BuildContext context, MQuestion item, List<MQuestion> responses) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        //
        for (int i = 0; i < responses.length; i++)
          Container(
            decoration: BoxDecoration(
                color: Colors.grey[100],
                borderRadius: BorderRadius.circular(4)),
            margin: const EdgeInsets.symmetric(vertical: 2),
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4),
            child: Text(responses[i].resultParagraph),
          )
      ],
    );
  }

  Widget _buildMultipleChoice(
      BuildContext context, MQuestion item, List<MQuestion> responses) {
    Map<int, int> chartData = {};

    for (MQuestion index in responses) {
      chartData[index.indexSelected] =
          (chartData[index.indexSelected] ?? 0) + 1;
    }

    return Column(
      children: [
        ListView.builder(
            shrinkWrap: true,
            itemCount: item.resultOption.length,
            itemBuilder: (context, index) {
              return _itemResponse(
                  item.resultOption[index], chartData[index] ?? 0);
            }),
        if (item.hasOther)
          Container(color: Colors.amber, child: Text(item.valueOther))
      ],
    );
  }

  Widget _itemResponse(String question, int quantity) {
    return Row(
      children: [Text("$question - $quantity")],
    );
  }
}
