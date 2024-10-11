import 'package:blog/ui/detail/post_detail_vm.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//model 데이터를 받아서 쓰려면 ConsumerWideg으로 변경. build에 WidgetRef ref 를 받아준다.
class PostDetailBody extends ConsumerWidget {
  int id;

  PostDetailBody(this.id);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //창고를 생성하고 ref로 watch 해준다. 창고는 싱글톤이므로
    //이때 창고가 생성돼있으면 기존에 존재하던 창고를 호출

    //프로바이더가 창고를 생성할 때 초기 파라미터를 전달하는 방법.
    PostDetailModel? model = ref.watch(postDetailProvider(id));

    if (model == null) {
      return CircularProgressIndicator();
    } else {
      return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: ElevatedButton(
                child: Icon(CupertinoIcons.trash_fill),
                onPressed: () {},
              ),
            ),
            SizedBox(height: 10),
            Text("id : ${model.id}", style: TextStyle(fontSize: 20)),
            Text("title : ${model.title}."),
            Text("content : ${model.content}"),
            Text("createdAt : ${model.createdAt}"),
            Text("updatedAt : ${model.updatedAt}"),
          ],
        ),
      );
    }
  }
}
