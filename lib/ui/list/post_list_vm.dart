import 'package:blog/data/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 창고(ViewModel)
// // 창고를 만들면 생성자를 하나 만들어 준다.
// 물음표를 넣은 이유는 일단 null을 넣어놓고 갱신시켜줄 것이므로
class PostListVM extends StateNotifier<PostListModel?> {
  PostListVM(super.state);

  //Spring에서 service같은 부분이다. 여기서 비즈니스 로직을 처리해준다.
  Future<void> notifyInit() async {
    //1. 통신을 해서 응답 받기
    //한 건이면 one, 여러건이면 list  -> 우리끼리 컨벤션
    //List<dynamic> list = await PostRepository().findAll();
    List<dynamic> list = await PostRepository.instance.findAll();

    //2. 파싱
    List<_Post> posts = list.map((e) => _Post.fromMap(e)).toList();

    //3. 상태 확인
    state = PostListModel(
        posts); //깊은 복사 (기존 데이터를 건드리지 않는다. posts를 생성자에 전달하면서 새로운 객체 생성)
  }
}

// 2. 창고 데이터 (State) -> 상태로 만드는 이유는 클래스기 때문
// 상태로 데이터를 유지
class PostListModel {
  //private으로 쓸려고 언더바를 붙여서 뺐다.
  List<_Post> posts;

  PostListModel(this.posts);
}

class _Post {
  int id;
  String title;

  //dart에서는 private이어도 (앞에 언더바 붙인) 점(.)을 찍으면 해당 파일 내에서 접근 가능하다.
  //json을 map으로 받아서 우리가 일일이 값을 빼서 객체로 만드는 것이 아니라
  //요청해서 json을 받으면 map으로 받아서 만들어둔 _Post의 fromMap생성자에 전달해서 생성자에서 converting 해서 받아준다.
  _Post.fromMap(map)
      : this.id = map['id'],
        this.title = map['title'];
}

// 3. 창고 관리자 (Provider)
// 물음표를 넣은 이유는 일단 null을 넣어놓고 갱신시켜줄 것이므로
final postListProvider =
    StateNotifierProvider<PostListVM, PostListModel?>((ref) {
  //처음에 창고를 null로 전달하고 notifyInit() 함수를 호출하고 이 함수가 종료될 때 상태변화
  return PostListVM(null)..notifyInit();
});
