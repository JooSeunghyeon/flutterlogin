import 'package:actual/common/const/data.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List> paginateRestaurant() async { // async 로 반환을 할려면 Future를 써야한다.
    final dio = Dio();

    final accessToken = await storge.read(key: ACCESS_TOKEN_KEY);

    final resp = await dio.get(
      'http://$ip/restaurant',
      options: Options(headers: {
        'authorization': 'Bearer $accessToken',
      }),
    );

    return resp.data['data'];
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<List>(
            future: paginateRestaurant(),
            builder: (context, AsyncSnapshot<List> snapshot) {
              print(snapshot.error);
              print(snapshot.data);

              if (!snapshot.hasData) {
                return Container();
              }

              return ListView.separated( // PostMan 기준으로 화면을 가져옴 따로 서버가 있다 TS + Node 기반 .
                itemBuilder: (_, index) {
                  final item = snapshot.data![index]; // 각각의 번호를 item에 넣는다 약간 ? for 문으로 index 지정해주는거랑 비슷 ?

                  return RestaurantCard(
                    image: Image.network(
                      'http://$ip${item['thumbUrl']}',
                      fit: BoxFit.cover,
                    ),
                    // image: Image.asset(
                    //   'asset/img/food.jpg',
                    //   fit: BoxFit.cover,
                    // ),
                    name: item['name'],
                    tags: List<String>.from(item['tags']), // List<dynamic> 으로 들어와야하는데 List<String> 으로 들어와서 형변환 필요
                    ratingsCount: item['ratingsCount'],
                    deliveryTime: item['deliveryTime'],
                    ratings: item['ratings'],
                    deliveryFee: item['deliveryFee'],
                  );
                },
                separatorBuilder: (_, index) {
                  return SizedBox(
                    height: 16.0,
                  );
                },
                itemCount: snapshot.data!.length,
              );
            },
          ),
        ),
      ),
    );
  }
}
