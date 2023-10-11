import 'package:actual/common/const/data.dart';
import 'package:actual/common/utils/data_utils.dart';
import 'package:json_annotation/json_annotation.dart';

part 'restaurant_model.g.dart';

enum RestaurantPriceRange {
  expensive,
  medium,
  cheap,
}

@JsonSerializable()
class RestarurantModel {
  final String id;
  final String name;
  /* 모델에서 Value 값이 추가되는게 있으면 절대로 .g.dart 파일은 손대면 안된다 다시 생성되기 때문 그래서 그럴땐 함수를 하나 만들어서 안에 넣어주면 자동으로 매핑이 되서 모델안으로 다시 들어간다.
   그리고 무줘권 static 이여야 한다.
   -- flutter pub run build_runner build 를 쓰면 1회성이다.
   -- flutter pub run build_runner watch 를 쓰면 파일이 변경될때 마다 새로 빌드가 된다.
   */
  @JsonKey(
    fromJson: DataUtils.pathToUrl,
  )
  final String thumbUrl;
  final List<String> tags;
  final RestaurantPriceRange priceRange;
  final double ratings;
  final int ratingsCount;
  final int deliveryTime;
  final int deliveryFee;

  RestarurantModel({
    required this.id,
    required this.name,
    required this.thumbUrl,
    required this.tags,
    required this.priceRange,
    required this.ratings,
    required this.ratingsCount,
    required this.deliveryTime,
    required this.deliveryFee,
  });

  factory RestarurantModel.fromJson(Map<String, dynamic> json)
  => _$RestarurantModelFromJson(json);

  Map<String, dynamic> toJson() => _$RestarurantModelToJson(this);


  // 이걸 json_serializable 을 써서 같은걸 반복하니 자동화 할려고 위에처럼 쓰인다.
  // factory RestarurantModel.fromJson({
  //   required Map<String, dynamic> json,
  // }) {
  //   return RestarurantModel(
  //     id: json['id'],
  //     name: json['name'],
  //     thumbUrl: 'http://$ip${json['thumbUrl']}',
  //     tags: List<String>.from(json['tags']),
  //     priceRange: RestaurantPriceRange.values.firstWhere( // enum 이라서 서버에서 가지고온 데이터 첫번째가 값이 같은걸 넣어준다는 뜻
  //           (e) => e.name == json['priceRange'],
  //     ),
  //     ratings: json['ratings'],
  //     ratingsCount: json['ratingsCount'],
  //     deliveryTime: json['deliveryTime'],
  //     deliveryFee: json['deliveryFee'],
  //   );
  // }

}
