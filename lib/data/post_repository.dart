import 'package:blog/core/utils.dart';

class PostRepository {
  //싱글톤 만들려면
  static PostRepository instance = PostRepository._single();

  PostRepository._single();

  // 통신 후 body 데이터를 추출해서 리턴해주는 클래스.
  // 응답의 body 부분이 Collection(List같은)이면 json array이고 이는 List<dynamic>으로 받는다.
  // 응답의 body 부분이 json이면 Map<String, dynamic>으로 받기
  // List<dynamic> or Map<String, dynamic>
  Future<List<dynamic>> findAll() async {
    // 1. 통신 -> response [ header, body ] 가 존재 -> 여기서 body만 추출해서 리턴할 것
    var response = await dio.get("/api/post");

    // 2. body 부분 리턴
    // 리스트 요청하므로 data의 body 부분은 collection이다 즉 json array이다..
    // body 부분이 json array면 List<dynamic>으로 받기
    // body 부분이 json이면 Map<String, dynamic>으로 받기
    List<dynamic> responseBody = response.data['body'];

    return responseBody;
  }

  //id로 단건 조회
  Future<Map<String, dynamic>> findById(int id) async {
    // 1. 통신 -> response [ header, body ] 가 존재 -> 여기서 body만 추출해서 리턴할 것
    var response = await dio.get("/api/post/$id");

    // 2. body 부분 리턴
    // body 부분이 단건 조회므로 json이 들어올 것이고 Map<String, dynamic>으로 받는다.
    Map<String, dynamic> responseBody = response.data['body'];

    return responseBody;
  }
}
