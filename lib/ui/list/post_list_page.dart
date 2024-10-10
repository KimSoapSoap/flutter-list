import 'package:blog/ui/components/custom_appbar.dart';
import 'package:blog/ui/list/components/post_list_body.dart';
import 'package:flutter/material.dart';

class PostListPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Post List Page"),
      body: PostListBody(),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context, "/write");
        },
        child: Icon(Icons.add),
      ),
    );
  }
}

