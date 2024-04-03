import 'package:flutter/material.dart';
import 'package:flutter_form_google/src/widget/input_widget.dart';

class CreateFormPage extends StatelessWidget {
  const CreateFormPage({super.key});

  static const routeName = '/';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Create Form"),
      ),
      body: _body(context),
    );
  }

  Widget _body(BuildContext context) {
    return Container(
      child: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          _titleForm(context),
          Expanded(
            child: ListView(
              children: [_itemAddQuestion(context)],
            ),
          ),
        ],
      ),
    );
  }

  Widget _titleForm(BuildContext context) {
    return Container(
      alignment: Alignment.centerLeft,
      child: Text(
        "Untitled form",
        style: TextStyle(fontSize: 24),
        textAlign: TextAlign.left,
      ),
    );
  }

  Widget _itemAddQuestion(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _rowInputAndPickImage(context),
        ],
      ),
    );
  }

  Widget _rowInputAndPickImage(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        Expanded(
          child: TextField(
            onChanged: (value) {},
          ),
        ),
        SizedBox(
          width: 10,
        ),
        InkWell(
            onTap: () {
              // TODO show image picker
            },
            child: Padding(
              padding: const EdgeInsets.all(10),
              child: const Icon(Icons.photo),
            ))
      ],
    );
  }

  Widget _dropdownBox(BuildContext context) {
    return Container(
      child: DropdownButton(items: [
        DropdownMenuItem(
            child: Row(
          children: [
            Icon(Icons.radio_button_checked),
            Expanded(child: Text("Paragraph"))
          ],
        ))
      ], onChanged: (value) {}),
    );
  }
}
