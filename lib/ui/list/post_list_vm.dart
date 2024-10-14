import 'package:blog/core/utils.dart';
import 'package:blog/data/post_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 창고(ViewModel)
// // 창고를 만들면 생성자를 하나 만들어 준다.
// 물음표를 넣은 이유는 일단 null을 넣어놓고 갱신시켜줄 것이므로
class PostListVM extends StateNotifier<PostListModel?> {
  //이를 이용해서 context 전달없이 현재 떠 있는 화면을 추적용으로 사용할 것이다. 현재 상태라는 화면은 절대 null일 수 없기 때문에 currentState에 ! 를 붙였다.
  //이 navigatorKey는 utils.dart의 final navigatorKey = GlobalKey<NavigatorState>(); 를 사용하는 것이다.
  // 이는 navigatorKey는 main에 등록해놔도 상관없다. 이를 이용해서 현재 상태의 무언가를 추적할 수 있다.
  // 이 mContext는 현재 화면의 context를 추적해서 가져오는 것이고 notifySave() 로직의 맨 끝에서 mContext가 사용되는데
  // notifySave()를 사용하는 순간의 화면은 글쓰기 화면이다. 즉 notifySave() 내부에서의 mContext는 글쓰기 화면을 의미하고 이때  Navigator.pop(mContext); 으로 뒤로가기 하면
  // list로 가게 되고 list로 가면서 상태가 갱신되고 썼던 글이 보이게 된다.
  final mContext = navigatorKey.currentState!.context;

  PostListVM(super.state);

  //Spring에서 service같은 부분이다. 여기서 비즈니스 로직을 처리해준다.
  Future<void> notifyDelete(int id) async {
    await PostRepository.instance.deleteById(id);
    PostListModel model = state!;

    //삭제는 where로 순회 돌리면서 특정하려는 녀석만 제외하고 새로운 리스트에 넣으면 특정 원소를 제외했으니 삭제와 같다.
    List<_Post> newPosts = model.posts.where((e) => e.id != id).toList();

    //상태 변경
    //PostListModel을 새로 만들면서 새 리스트를 넣어줬기 때문에
    state = PostListModel(newPosts);

    //뒤로가기
    Navigator.pop(mContext);
  }

  //post_write_page.dart의 vm으로 쓰기 위함
  //아래 창고 데이터가 List<_Post> posts; 이고 글쓰기 하고 이 값을 변경한 후 상태를 갱신해주면 된다.
  //트랜잭션. 하나의 비즈니스 로직이다.
  //게시글에서 제목과 내용을 전달받을 것이기 때문에 매개변수 설정.
  Future<void> notifySave(String title, String content) async {
    //Repository에서 save 통신 요청
    //나는 싱글톤으로 만들어 뒀으므로 PostRepository.instance.save()로 호출
    //post_repository.dart에 save() 함수를 만들어야 한다. 이때 필요한 title과 content를 전달
    //이 코드를 통해서 데이터를 받아 와야지만 이 viewModel에서의 비즈니스 모델이 제대로 마무리 되는 것이고
    //이후는 파싱해서 갱신된 데이터를 넣어서 전달하고 변경감지 시켜서 상태를 변경한 뒤 화면을 바꿔주면 되느 ㄴ것이다.
    Map<String, dynamic> one =
        await PostRepository.instance.save(title, content);

    //통신해서 받아와서 만든 새로운 게시글 정보.
    _Post newPost = _Post.fromMap(one);

    //상태가 절대 null일 수 있다. 이미 다 그려져서 글쓰기 버튼을 눌러서 글쓰기 하는 것이므로
    PostListModel model = state!;

    //깊은 복사
    List<_Post> newPosts = [newPost, ...model.posts];

    //상태 변경
    state = PostListModel(newPosts);

    // 깊은 복사를 하지 않고 PostListModel을 새로 만들면서 데이터를 전달해도 상태 변경 감지가 가능하다. PostListModel 객체를 새로 생성하면 참조값이 바뀌기 때문에 변경 감지가 된다.
    // 이런 원리로 깊은 복사를 하지 않고 그냥 기존의 상태인 model의 posts에(아래에  List<_Post> posts; ) 새로운 게시글을 add해서 추가만 해주고 PostListModel을 새로 만들면서 전달해주면 된다.
    // 즉 깊은 복사를 안 하고 하려면 아래처럼 기존 모델에 새로운 게시글을 add 해주고 그 아래처럼 새로운 객체 만들면서 참조값을 바꿔서 newPost를 전달하면 변경감지가 된다. 즉, 변경된 정보로 리스트 갱신이 된다.
    // 핵심은 PostListModel이라는 객체를 새로 만들면서 데이터를 전달하는 것이다. 그럼 그 데이터는 무엇이든 상관없이? 객체의 참조값이 변했기 때문에 변경 감지
    // 만약 전달하는 데이터는 그대로고 PostListModel만 그대로라면? 객체를 새로 생성하면서 전달했으므로 변경감지가 되고 갱신이 되지만 데이터가 그대로기 때문에 변경이 없다고 느낄 것이다.

    //model.posts.add(newPost);
    //state = PostListModel(model.posts);

    //마지막에 뒤로가기 로직까지
    Navigator.pop(mContext);
  }

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

/*

이제 통신 함수도 만들었으니 요청 후 데이터를 받아올 것이고

post_list_vm.dart에서 notifySave()에서 통신 후 데이터 받아와서 상태변경까지

잘 해줄 것이다.

하지만 우리는 글쓰기 하고 나서 list화면으로 가야 한다.

글쓰기 화면으로 가야 우리가 쓴 글을 확인할 수 있기 때문이다.

글쓰고 나서 뒤로가기를 해야 list로 가서 갱신이 되는데

view에서 뒤로가기를 하면 안 된다. 통신은 비동기라서 시간이 걸리는데

기다리지 않고 뒤로가기를 해버린다.

즉 비즈니스 로직을 처리하는 viewModel인  post_list_vm에서 로직 끝에 뒤로가기를 해준다.

만약 view에서 순차적 처리를 하고 싶다면? ref 앞에 await를 붙이고 해당 함수에 async를 붙여주면 되는데 이렇게 하는 것보다는 delegation? 을 위해서 그냥 하나의 비즈니스 로직에서(viewModel에서) 모든 것을 처리하도록 한다.

즉 save() 에서 글쓰기 로직에서 뒤로가기까지 마무리 해주는 것이 좋다.

### context 전달

화면 뒤로가기를 하려면 context가 필요하다.

현재 화면이 어디인지를 알아야 하기 때문이다.

context가 필요한 곳은  post_list_vm.dart에서 뒤로가기 할 때 필요한 것이고

이때 뒤로가기 하는 화면은 post_write_body.dart가 돼야 하기 때문에

post_write_body.dart의 context를 글쓰기 버튼 클릭시 post_list_vm.dart의
notifySave에 전달해야 하는 것이다.

이렇게 되면 BuilderContext 를 context로 받아야 되고 전달해야 되고 복잡하다.

이럴 때 사용하기에 유용한 것이  유틸에 선언해둔 GlobalKey 이다.

이는 main에 선언해둬도 상관없다.
`final navigatorKey = GlobalKey<NavigatorState>();`

이를 이용해서

post_list_vm.dart에
`final mContext = navigatorKey.currentState!.context;`

이렇게 선언하면 현재 화면을 추적해서 mContext를 현재 화면의 context로 사용 가능.

즉

post_write_body.dart의 글쓰기 화면에서 글쓰기 누르는 순간 notifySave()를 호출하기

때문에 notifySave()의 마지막에 실행하는 Navigator.pop(mContext); 는

 post_list_vm.dart에 존재하는 코드이지만 post_write_body.dart의

PostWriteBody() 의 context를 가지고 있는 것이다.
 */
