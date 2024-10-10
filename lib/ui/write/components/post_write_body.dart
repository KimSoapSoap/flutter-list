import 'package:blog/ui/write/components/post_write_form.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostWriteBody extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Container(
            color: Colors.deepPurple[100],
            height: 100,
            width: double.infinity,
            child: Icon(CupertinoIcons.airplane),
          ),
          SizedBox(height: 10),
          Expanded(child: PostWriteForm()),
        ],
      ),
    );
  }
}
