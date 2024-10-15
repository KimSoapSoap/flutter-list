import 'package:blog/ui/list/post_list_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostWriteBody extends ConsumerWidget {
  final TextEditingController _title = TextEditingController();
  final TextEditingController _content = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Flexible(
            child: ListView(
              shrinkWrap: true,
              children: [
                Container(
                  color: Colors.deepPurple[100],
                  height: 400,
                  width: double.infinity,
                  child: Icon(CupertinoIcons.airplane),
                ),
                SizedBox(height: 10),
                TextFormField(
                  controller: _title,
                ),
                TextFormField(
                  controller: _content,
                ),
              ],
            ),
          ),
          TextButton(
              onPressed: () {
                ref
                    .read(postListProvider.notifier)
                    .notifySave(_title.text, _content.text);
              },
              child: Text("글쓰기")),
        ],
      ),
    );
  }
}
