import 'package:actual/common/const/data.dart';
import 'package:actual/common/dio/dio.dart';
import 'package:actual/common/model/cusor_pagination_model.dart';
import 'package:actual/model/restaurant_model.dart';
import 'package:actual/restaurant/component/restaurant_card.dart';
import 'package:actual/restaurant/repository/restaurant_provider.dart';
import 'package:actual/restaurant/repository/restaurant_repository.dart';
import 'package:actual/restaurant/view/restaurant_detail_screen.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class RestaurantScreen extends ConsumerWidget {
  const RestaurantScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final data = ref.watch(restaurantProvider);

    if (data.length == 0) {
      return Center(
        child: CircularProgressIndicator(),
      );
    }

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.0),
      child: ListView.separated(
        // ListView.Builder 형태에서 구분선이 필요할 때 사용.
        // PostMan 기준으로 화면을 가져옴 따로 서버가 있다 TS + Node 기반 .
        itemCount: data.length,
        itemBuilder: (_, index) {
          final pItem =
              data[index]; // 각각의 번호를 item에 넣는다 약간 ? for 문으로 index 지정해주는거랑 비슷 ?

          return GestureDetector(
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (_) =>
                        RestaurantDetailScreen(id: pItem.id, name: pItem.name),
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
      ),
    );
  }
}
