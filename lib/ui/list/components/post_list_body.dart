import 'package:blog/ui/detail/post_detail_page.dart';
import 'package:blog/ui/list/post_list_vm.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class PostListBody extends ConsumerWidget {

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    //1. viewModel이 만들어져야 하고 watch로 보기 (view에 들어올 때)
    //   viewModel은 항상 page파일 옆에 만들어 두면 된다.
    //   view는 무조건 viewModel만 본다.

    //창고가 관리하면 상태 타입이 PostListModel이기 때문에. 처음에 null로 만들기 때문에 ? 처리
    // ref~ 쪽 우변이 실행되면 post_list_vm.dart에서
    // 창고관리자가 생성되면서 창고가 null로 전달된다. 나중에 익숙해지면 그냥 var로 받아도 된다.
    PostListModel? model = ref.watch(postListProvider);

    if(model == null) {
      return CircularProgressIndicator();
    } else {

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      //separated는 separatorBuilder라는 것으로 list에서 중간 item마다 줄을 그어주는 것이다.
      child: ListView.separated(
          itemBuilder: (context, index) {
            return ListTile(
              //받아온 정보인 model에서 값을 뿌려준다.
              leading: Text("${model.posts[index].id}"),
              title: Text("${model.posts[index].title}"),
              trailing: IconButton(
                icon: Icon(Icons.arrow_forward_ios),
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => PostDetailPage(),));
                },
              ),
            );
          },
          separatorBuilder: (context, index) => Divider(),
          //itemCount는 이제 들어오는 정보의 길이로 해줘야 한다.
          //model은 null처리하고 왔으므로 null이 오지 않는다.
          itemCount: model.posts.length),
    );
    }
  }
}
