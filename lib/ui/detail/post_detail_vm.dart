import 'package:flutter_riverpod/flutter_riverpod.dart';

// 1. 창고(ViewModel)
// 창고를 만들면 생성자를 하나 만들어 준다.
// 물음표를 넣은 이유는 일단 null을 넣어놓고 갱신시켜줄 것이므로
class PostDetailVM extends StateNotifier<PostDetailModel?> {
  PostDetailVM(super.state);

  // async를 쓰려고 Future타입으로 리턴
  Future<void> notifyInti() async {
    // 1. 통신을 해서 응답 받기

    // 2. 상태 갱신
    
  }
}

// 2. 창고 데이터 (State) -> 상태로 만드는 이유는 클래스기 떄문
class PostDetailModel {
  // api 문서를 보고 상태를 정한다.

}

// 3. 창고 관리자 (Provider)
// 물음표를 넣은 이유는 일단 null을 넣어놓고 갱신시켜줄 것이므로
final postDetailProvider = StateNotifierProvider<PostDetailVM, PostDetailModel?>((ref) {
  return PostDetailVM(null);
});
