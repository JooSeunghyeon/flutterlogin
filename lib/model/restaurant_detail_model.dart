import 'package:actual/common/const/data.dart';
import 'package:actual/model/restaurant_model.dart';

class RestarurantDetailModel extends RestarurantModel {
  // 비슷한 데이터가 오는데 굳이 새로 생성하면 번거롭다 그럴때 상속을 받아서 기존 모델에 super로 상속받아서 사용한다.

  final String detail;
  final List<RestaurantProductModel> products;

  RestarurantDetailModel({
    required super.id,
    required super.name,
    required super.thumbUrl,
    required super.tags,
    required super.priceRange,
    required super.ratings,
    required super.ratingsCount,
    required super.deliveryTime,
    required super.deliveryFee,
    required this.detail,
    required this.products,
  });

  factory RestarurantDetailModel.fromJson({
    required Map<String, dynamic> json,
  }) {
    return RestarurantDetailModel(
      id: json['id'],
      name: json['name'],
      thumbUrl: 'http://$ip${json['thumbUrl']}',
      tags: List<String>.from(json['tags']),
      priceRange: RestaurantPriceRange.values.firstWhere(
        // enum 이라서 서버에서 가지고온 데이터 첫번째가 값이 같은걸 넣어준다는 뜻
        (e) => e.name == json['priceRange'],
      ),
      ratings: json['ratings'],
      ratingsCount: json['ratingsCount'],
      deliveryTime: json['deliveryTime'],
      deliveryFee: json['deliveryFee'],
      detail: json['detail'],
      products: json['products'].map<RestaurantProductModel>(
        (x) => RestaurantProductModel(
          id: x['id'],
          name: x['name'],
          imgUrl: x['imgUrl'],
          detail: x['detail'],
          price: x['price'],
        ),
      ).toList(),
    );
  }
}

class RestaurantProductModel {
  final String id;
  final String name;
  final String imgUrl;
  final String detail;
  final int price;

  RestaurantProductModel({
    required this.id,
    required this.name,
    required this.imgUrl,
    required this.detail,
    required this.price,
  });
}
