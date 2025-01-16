import 'package:hive/hive.dart';
import '../../data/model/invoice.dart';
import '../../data/model/pizza.dart';

import '../source/database/hive.dart';

class PizzasRepository {
  PizzasRepository._privateConstructor();
  static final PizzasRepository instance =
      PizzasRepository._privateConstructor();

  static List<PizzaModel> pizzaList = [
    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
    //! IF YOU WANT TO ADD NEW PIZZAS, ADD THEM HERE !!
    //!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!
  ];

  Future<List<PizzaModel>> getUserPizzas(String username) async {
    final pizzasBox = Hive.box<Pizza>('pizzas');
    final userPizzas =
        pizzasBox.values.where((pizza) => pizza.username == username).toList();

    List<PizzaModel> mergedList = [...pizzaList];
    mergedList.addAll(userPizzas.map((e) => PizzaModel(
          name: e.name,
          smallPrice: e.smallPrice,
          mediumPrice: e.mediumPrice,
          largePrice: e.largePrice,
          image: e.image,
        )));

    return mergedList;
  }

  Future<void> addUserPizza(String username, PizzaModel pizza) async {
    final pizzasBox = Hive.box<Pizza>('pizzas');
    final newPizza = Pizza()
      ..name = pizza.name
      ..smallPrice = pizza.smallPrice
      ..mediumPrice = pizza.mediumPrice
      ..largePrice = pizza.largePrice
      ..image = pizza.image!
      ..username = username;
    await pizzasBox.add(newPizza);
  }

  Future<void> removeUserPizza(String username, String pizzaName) async {
    final pizzasBox = Hive.box<Pizza>('pizzas');
    final pizzaToRemove = pizzasBox.values.firstWhere(
        (pizza) => pizza.username == username && pizza.name == pizzaName,
        orElse: () => Pizza());
    await pizzaToRemove.delete();
  }

  Future<void> updatePizzaPrice(String username, String pizzaName,
      num newSmallPrice, num newMediumPrice, num newLargePrice) async {
    final pizzasBox = Hive.box<Pizza>('pizzas');
    final pizzaToUpdate = pizzasBox.values.firstWhere(
        (pizza) => pizza.username == username && pizza.name == pizzaName,
        orElse: () => Pizza());
    pizzaToUpdate.smallPrice = newSmallPrice;
    pizzaToUpdate.mediumPrice = newMediumPrice;
    pizzaToUpdate.largePrice = newLargePrice;
    await pizzaToUpdate.save();
  }

  Future<List<InvoiceModel>?> getInvoices(String username) async {
    final invoicesBox = Hive.box<Invoice>('invoices');
    final userInvoices = invoicesBox.values
        .where((invoice) => invoice.username == username)
        .toList();

    return userInvoices
        .map((invoice) => InvoiceModel(
              invoiceNumber: invoice.invoiceNumber,
              customerName: invoice.customerName,
              date: invoice.date,
              time: invoice.time,
              totalAmount: invoice.totalAmount,
              discount: invoice.discount,
              items: invoice.items,
              username: invoice.username,
            ))
        .toList();
  }

  Future<void> saveInvoice({
    required int invoiceNumber,
    required String customerName,
    required String formattedDate,
    required String formattedTime,
    required double totalAmount,
    required num discount,
    required String items,
    required String userName,
  }) async {
    final invoicesBox = Hive.box<Invoice>('invoices');
    final newInvoice = Invoice()
      ..invoiceNumber = invoiceNumber
      ..customerName = customerName
      ..date = formattedDate
      ..time = formattedTime
      ..totalAmount = totalAmount
      ..discount = discount
      ..items = items
      ..username = userName;
    await invoicesBox.add(newInvoice);
  }
}
