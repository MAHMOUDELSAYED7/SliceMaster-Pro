import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../core/service/cache/cache.dart';
import '../../../data/model/pizza.dart';
import '../../../data/repositories/pizzas.dart';

class PizzasRepositoryCubit extends Cubit<List<PizzaModel>> {
  PizzasRepositoryCubit() : super([]) {
    loadUserPizzas();
  }

  Future<void> loadUserPizzas() async {
    final username = await _getUsername();
    final pizzas = await PizzasRepository.instance.getUserPizzas(username);
    emit(pizzas);
  }

  Future<void> addUserPizza({
    required String name,
    required num smallPrice,
    required num mediumPrice,
    required num largePrice,
    required String image,
  }) async {
    final username = await _getUsername();
    final newPizza = PizzaModel(
      name: name,
      smallPrice: smallPrice,
      mediumPrice: mediumPrice,
      largePrice: largePrice,
      image: image,
    );
    await PizzasRepository.instance.addUserPizza(username, newPizza);
    await loadUserPizzas();
  }

  Future<void> removeUserPizza({required String pizzaName}) async {
    final username = await _getUsername();
    await PizzasRepository.instance.removeUserPizza(username, pizzaName);
    await loadUserPizzas();
  }

  Future<void> updatePizzaPrice({
    required PizzaModel pizza,
    required num newSmallPrice,
    required num newMediumPrice,
    required num newLargePrice,
  }) async {
    final username = await _getUsername();
    await PizzasRepository.instance.updatePizzaPrice(
      username,
      pizza.name,
      newSmallPrice,
      newMediumPrice,
      newLargePrice,
    );
    await loadUserPizzas();
  }

  Future<String> _getUsername() async {
    return CacheData.getData(key: 'currentUser');
  }
}
