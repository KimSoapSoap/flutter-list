import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PostDetailBody extends StatelessWidget {


  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Align(
            alignment: Alignment.centerRight,
            child: ElevatedButton(
              child: Icon(CupertinoIcons.trash_fill),
              onPressed: (){},
            ),
          ),
          SizedBox(height: 10),
          Text("id : 1", style: TextStyle(fontSize: 20)),
          Text("title : 제목입니다."),
          Text("content : 내용입니다."),
          Text("createdAt : 2024-08-01"),
        ],
      ),
    );
  }
}
