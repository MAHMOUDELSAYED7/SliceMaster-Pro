import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import 'hive.dart';

class HiveDb {
  static final HiveDb _instance = HiveDb._internal();

  factory HiveDb() {
    return _instance;
  }

  HiveDb._internal();

  Future<void> initializeDatabase() async {
    final directory = await getApplicationSupportDirectory();
    Hive.init(directory.path);

    Hive.registerAdapter(UserAdapter());
    Hive.registerAdapter(PizzaAdapter());
    Hive.registerAdapter(InvoiceAdapter());

    await Hive.openBox<User>('users');
    await Hive.openBox<Pizza>('pizzas');
    await Hive.openBox<Invoice>('invoices');
  }

  Future<void> deleteAndRecreateDatabase() async {
    await Hive.close();
    await Hive.deleteBoxFromDisk('users');
    await Hive.deleteBoxFromDisk('pizzas');
    await Hive.deleteBoxFromDisk('invoices');
    await initializeDatabase();
  }

  Future<int> insertUser(String username, String password) async {
    final usersBox = Hive.box<User>('users');
    if (usersBox.containsKey(username)) {
      return 0;
    }
    final newUser = User(username: username, password: password);
    await usersBox.put(username, newUser);
    return 1;
  }

  Future<User?> getUser(String username, String password) async {
    final usersBox = Hive.box<User>('users');
    final user = usersBox.get(username);
    if (user != null && user.password == password) {
      return user;
    }
    return null;
  }

  Future<void> saveInvoice(Map<String, dynamic> invoiceData) async {
    final invoicesBox = Hive.box<Invoice>('invoices');
    final invoice = Invoice()
      ..invoiceNumber = invoiceData['invoice_number']
      ..customerName = invoiceData['customer_name']
      ..date = invoiceData['date']
      ..time = invoiceData['time']
      ..totalAmount = invoiceData['total_amount']
      ..discount = invoiceData['discount'] ?? 0
      ..items = invoiceData['items']
      ..username = invoiceData['username'];
    await invoicesBox.add(invoice);
  }

  Future<List<Map<String, dynamic>>> readData() async {
    final invoicesBox = Hive.box<Invoice>('invoices');
    return invoicesBox.values
        .map((invoice) => {
              'invoice_number': invoice.invoiceNumber,
              'customer_name': invoice.customerName,
              'date': invoice.date,
              'time': invoice.time,
              'total_amount': invoice.totalAmount,
              'discount': invoice.discount,
              'items': invoice.items,
              'username': invoice.username,
            })
        .toList();
  }

  Future<void> updateUserStatus(String username, bool status) async {
    final usersBox = Hive.box<User>('users');
    final user = usersBox.get(username);
    if (user != null) {
      user.loginStatus = status;
      await user.save();
    }
  }

  Future<void> deleteUser(String username) async {
    final usersBox = Hive.box<User>('users');
    await usersBox.delete(username);
  }

  Future<int?> getNextInvoiceNumber(String username) async {
    final usersBox = Hive.box<User>('users');
    final user = usersBox.get(username);
    if (user != null) {
      user.invoiceNumber++;
      await user.save();
      return user.invoiceNumber;
    }
    return null;
  }
}
