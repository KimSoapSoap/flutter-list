import 'package:blog/core/utils.dart';
import 'package:blog/data/post_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 창고(ViewModel)
// 창고를 만들면 생성자를 하나 만들어 준다.
// 물음표를 넣은 이유는 일단 null을 넣어놓고 갱신시켜줄 것이므로
class PostDetailVM extends StateNotifier<PostDetailModel?> {
  PostDetailVM(super.state);

  // async를 쓰려고 Future타입으로 리턴
  Future<void> notifyInit(int id) async {
    // 1. 통신을 해서 응답 받기
    // post_repository.dart 에서 통신으로 id검색해서 데이터를 받아 왔다.
    Map<String, dynamic> one = await PostRepository.instance.findById(id);

    // 2. 상태 갱신
    // 새로운 객체를 만들어서 상태를 바꿔야 한다. 새로운 객체를 만들지 않고 기존의 객체를 변경하면 변화 감지가 안 된다!
    // 그래서 만들어둔 생성자를 통해 받아온 데이터를 생성자에 넣고 깊은 복사를 해서 새로운 객체로 상태를 변경해준다.
    // 이렇게 새로운 객체를 만들어서 상태를 바꿔줘야 watch하는 녀석이 감지를 한다.
    state = PostDetailModel.fromMap(one);
  }
}

// 2. 창고 데이터 (State) -> 상태로 만드는 이유는 클래스기 떄문
class PostDetailModel {
  // api 문서를 보고 상태를 정한다.
  int id;
  String title;
  String content;
  String createdAt;
  String updatedAt;

  PostDetailModel.fromMap(map)
      : this.id = map['id'],
        this.title = map['title'],
        this.content = map['content'],
        this.createdAt = formatDate(map['createdAt']),
        this.updatedAt = formatDate(map['updatedAt']);
}

// 3. 창고 관리자 (Provider)
// 물음표를 넣은 이유는 일단 null을 넣어놓고 갱신시켜줄 것이므로
// family를 붙여주는 건 창고가 생성될 때 provider가 창고에 초기 파라미터값을 전달해주기 위함이다.
// 이때 제네릭에 타입을 추가해주고 ref와 더불어 해당 타입의 변수를 추가로 전달해주면 된다.(viewModel의 notifyInit()에 해당 타입매개변수 추가)
// 만약 여러 값을 전달해주고 싶으면 int 대신에 클래스를 만들어서 클래스에 넣어서 전달해주면 됨

// family 앞이나 뒤에 autoDispose를 붙여줘야 한다. 다른 페이지로 갈 때 기존 창고 관리자를 메모리에서 날려 버린다.
// 페이지에서 벗어났을 때 사용하지 않는 상태를 정리하기 위한 것이며, 다시 페이지로 돌아오면 상태가 새로 생성됩니다.
// autoDispose를 사용하지 않으면 상태가 유지되는데, 경우에 따라 이전 상태가 잘못 덧씌워질 수 있다
// 다시 페이지로 왔을 때 기존 관리자에 의해 기존 정보가 보였다가 다시 새로운 정보로 덧씌워지기 때문에 메모리에서 날려야 한다.
// 만약 언젠가 어떤 로직에서 기존의 정보가 들어 있는 화면이 필요하다면 그때는 dispose로 날리지 말아야 할 것이다.
final postDetailProvider = StateNotifierProvider.autoDispose
    .family<PostDetailVM, PostDetailModel?, int>((ref, id) {
  print('${id} : 프로바이더 만들어져?');
  return PostDetailVM(null)..notifyInit(id);
});
