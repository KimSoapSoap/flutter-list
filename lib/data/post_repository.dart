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

  //id로 단건 조회
  Future<Map<String, dynamic>> save(String title, String content) async {
    // 1. 통신 -> response [ header, body ] 가 존재 -> 여기서 body만 추출해서 리턴할 것
    // post를 보낼 것이므로 dio.post로 하고
    // 두 번째 전달자에 data: 를 전달해주는데 Map타입으로 {"key":value} 를 전달하면 자동으로 Json으로 변환시켜준다.
    // 그렇기 때문에 따로 DTO를 만들 필요 없다. 알아서 Json으로 컨버팅 해주므로

    var response = await dio.post("/api/post", data: {
      "title": title,
      "content": content,
    });

    // 2. body 부분 리턴
    // body 부분이 insert이므로 넘겨준 data가 그대로 돌아올 것이고 json이 들어 오는 것을 Map<String, dynamic>으로 받는다.
    Map<String, dynamic> responseBody = response.data['body'];

    return responseBody;
  }

  //id로 단건 조회
  Future<void> deleteById(int id) async {
    //삭제의 경우 try catch 혹은 if로 200코드냐 아니냐에 따라 로직이 달라져야 한다. 삭제 됐을 때와 안 됐을 때.
    //받을 데이터가 없기에 Future<void>

    //삭제
    var response = await dio.delete("/api/post/$id");
  }
}
