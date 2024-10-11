import 'package:blog/ui/detail/components/post_detail_body.dart';
import 'package:flutter/material.dart';

import '../components/custom_appbar.dart';

class PostDetailPage extends StatelessWidget {
  int id;

  //받아서 body로 넘겨준다. 다비를 따로 빼서 만드는 건 분리시켜서 코드를 분리시키기 위해.
  //그래서 이 페이지는 깔끔하다.
  PostDetailPage(this.id);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Post Detail Page"),
      body: PostDetailBody(id),
    );
  }
}
