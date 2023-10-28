import 'package:actual/common/const/data.dart';
import 'package:actual/common/dio/dio.dart';
import 'package:actual/model/restaurant_model.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/repository/restaurant_repository.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class RestaurantScreen extends StatelessWidget {
  const RestaurantScreen({super.key});

  Future<List<RestaurantModel>> paginateRestaurant() async {
    // async 로 반환을 할려면 Future를 써야한다.
    final dio = Dio();

    dio.interceptors.add(
      CustomInterceptor(storage: storge),
    );

    final resp = await RestaurantRepository(dio, baseUrl: 'http://$ip/restaurant').paginate();

    // TODO 기존 코드 위 코드가 개선한 코드.
    // final accessToken = await storge.read(key: ACCESS_TOKEN_KEY);
    //
    // final resp = await dio.get(
    //   'http://$ip/restaurant',
    //   options: Options(headers: {
    //     'authorization': 'Bearer $accessToken',
    //   }),
    // );

    return resp.data;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.0),
          child: FutureBuilder<List<RestaurantModel>>(
            future: paginateRestaurant(),
            builder: (context, AsyncSnapshot<List<RestaurantModel>> snapshot) {
              print(snapshot.error);
              print(snapshot.data);

              if (!snapshot.hasData) {
                return Center(
                  child: CircularProgressIndicator(),
                );
              }

              return ListView.separated( // ListView.Builder 형태에서 구분선이 필요할 때 사용.
                // PostMan 기준으로 화면을 가져옴 따로 서버가 있다 TS + Node 기반 .
                itemBuilder: (_, index) {
                  final pItem = snapshot.data![index]; // 각각의 번호를 item에 넣는다 약간 ? for 문으로 index 지정해주는거랑 비슷 ?


                  return GestureDetector(
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (_) => RestaurantDetailScreen(id: pItem.id, name: pItem.name),
                          ),
                        );
                      },
                      child: RestaurantCard.fromModel(model: pItem));
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
