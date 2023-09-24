import 'package:actual/common/const/data.dart';
import 'package:actual/model/restaurant_model.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List> paginateRestaurant() async {
    // async 로 반환을 할려면 Future를 써야한다.
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

              return ListView.separated(
                // PostMan 기준으로 화면을 가져옴 따로 서버가 있다 TS + Node 기반 .
                itemBuilder: (_, index) {
                  final item = snapshot.data![index]; // 각각의 번호를 item에 넣는다 약간 ? for 문으로 index 지정해주는거랑 비슷 ?

                  // 이런식으로 해두면 중복으로 사용하기도 좋고 , 유집보수 하기도 좋다 모델에서 하나만 바꾸면 다 바뀌기 때문이고 코드도 한눈에 보기가 좋다 .
                  final pItem = RestarurantModel.fromJson(json: item);

                  return RestaurantCard.fromModel(model: pItem);

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
