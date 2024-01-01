import 'package:actual/model/restaurant_model.dart';
import 'package:actual/restaurant/repository/restaurant_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final restaurantProvider = StateNotifierProvider<RestaurantStateNotifier,List<RestaurantModel>>((ref)  {
  final resository = ref.watch(restaurantRepositoryProvider);

  final notifier = RestaurantStateNotifier(repository: resository);

  return notifier;
},);

class RestaurantStateNotifier extends StateNotifier<List<RestaurantModel>>{
  final RestaurantRepository repository;

  RestaurantStateNotifier({
    required this.repository,
}): super([]){
    paginate();
  }

  paginate() async{
    final resp = await repository.paginate();

    state = resp.data;
  }

}