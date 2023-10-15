import 'package:actual/model/restaurant_detail_model.dart';
import 'package:dio/dio.dart' hide Headers;
import 'package:retrofit/retrofit.dart';

part 'restaurant_repository.g.dart';

/*
* 추상 클래스는 추상 메서드를 가지 수 있는 클래스이다.
* 필수적으로 포함해야 하는 것은 아니다.
* 일반 클래스에는 추상 메서드를 가지고 싶어도 선언할 수 없다.
* 추상 클래스는 기존 앞에 추상이랑 뜻을 가진 abstract 키워드를 붙여서 표현한다.
*/

@RestApi()
abstract class RestaurantRepository {
  // http://$ip/restaurant
  factory RestaurantRepository(Dio dio, {String baseUrl})
  = _RestaurantRepository;

  /// http://$ip/restaurant/
  // @GET('/')
  // paginate();

  /// http://$ip/restaurant/:id
  @GET('/{id}')
  @Headers({
    'authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VybmFtZSI6IjEiLCJzdWIiOiJmNTViMzJkMi00ZDY4LTRjMWUtYTNjYS1kYTlkN2QwZDkyZTUiLCJ0eXBlIjoiYWNjZXNzIiwiaWF0IjoxNjk3MzYzNDUxLCJleHAiOjE2OTczNjM3NTF9.vmnj6TJsWyT56885xsMEuqstqaaZvxzNxkg-99q7xLQ'
  })
  Future<RestarurantDetailModel> getRestaurantDetail({
    @Path() required String id,
});

}