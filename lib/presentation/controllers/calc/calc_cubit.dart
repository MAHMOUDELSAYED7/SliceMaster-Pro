
import 'package:bloc/bloc.dart';
import '../../../data/model/pizza.dart';

enum PizzaSize { s, m, l }

class CalculatorCubit extends Cubit<Map<PizzaModel, Map<PizzaSize, int>>> {
  CalculatorCubit() : super({});

  PizzaSize selectedSize = PizzaSize.s;

  void increment(PizzaModel pizza) {
    final currentSizeCount = state[pizza]?[selectedSize] ?? 0;
    final updatedState = {
      ...state,
      pizza: {
        ...?state[pizza],
        selectedSize: currentSizeCount + 1,
      }
    };
    emit(updatedState);
  }

  void decrement(PizzaModel pizza) {
    final currentSizeCount = state[pizza]?[selectedSize] ?? 0;
    if (currentSizeCount > 0) {
      final updatedState = {
        ...state,
        pizza: {
          ...?state[pizza],
          selectedSize: currentSizeCount - 1,
        }
      };
      emit(updatedState);
    }
  }

  void setSize(PizzaSize size) {
    selectedSize = size;
    emit({...state});
  }

  double getTotalPrice({num? discount}) {
    final total = state.entries.fold<double>(0, (sum, entry) {
      final pizza = entry.key;
      final sizeCounts = entry.value;
      return sum +
          sizeCounts.entries.fold<double>(0, (sizeSum, sizeEntry) {
            final size = sizeEntry.key;
            final count = sizeEntry.value;
            final price = getPizzaPrice(pizza, size);
            return sizeSum + (price * count);
          });
    });

    if (discount != null && discount > 0) {
      final discountedTotal = total * ((100 - discount) / 100);
      return discountedTotal;
    }

    return total;
  }

  num getPizzaPrice(PizzaModel pizza, PizzaSize size) {
    switch (size) {
      case PizzaSize.s:
        return pizza.smallPrice;
      case PizzaSize.m:
        return pizza.mediumPrice;
      case PizzaSize.l:
        return pizza.largePrice;
    }
  }

  void reset() => emit({});
}
