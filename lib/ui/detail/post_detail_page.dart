import 'package:blog/ui/detail/components/post_detail_body.dart';
import 'package:flutter/material.dart';

import '../components/custom_appbar.dart';

class PostDetailPage extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: CustomAppBar(title: "Post Detail Page"),
      body: PostDetailBody(),
    );
  }
}


