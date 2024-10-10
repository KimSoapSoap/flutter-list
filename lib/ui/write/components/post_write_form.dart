import 'package:flutter/material.dart';

class PostWriteForm extends StatelessWidget {
  final _title = TextEditingController();
  final _content = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            TextFormField(
              controller: _title,
            ),
            TextFormField(
              controller: _content,
            ),
            TextButton(
                onPressed: () {
                  String title = _title.text.trim();
                  String content = _content.text.trim();
                  // vm 에게 전달해야 함.
                },
                child: Text("글쓰기")
            ),
          ],
        ),
      ),
    );
  }
}
