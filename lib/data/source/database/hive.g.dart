// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'hive.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class UserAdapter extends TypeAdapter<User> {
  @override
  final int typeId = 0;

  @override
  User read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return User(
      username: fields[0] as String,
      password: fields[1] as String,
      loginStatus: fields[2] as bool,
      invoiceNumber: fields[3] as int,
    );
  }

  @override
  void write(BinaryWriter writer, User obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.username)
      ..writeByte(1)
      ..write(obj.password)
      ..writeByte(2)
      ..write(obj.loginStatus)
      ..writeByte(3)
      ..write(obj.invoiceNumber);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is UserAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class PizzaAdapter extends TypeAdapter<Pizza> {
  @override
  final int typeId = 1;

  @override
  Pizza read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Pizza()
      ..name = fields[0] as String
      ..smallPrice = fields[1] as num
      ..mediumPrice = fields[2] as num
      ..largePrice = fields[3] as num
      ..image = fields[4] as String
      ..username = fields[5] as String;
  }

  @override
  void write(BinaryWriter writer, Pizza obj) {
    writer
      ..writeByte(6)
      ..writeByte(0)
      ..write(obj.name)
      ..writeByte(1)
      ..write(obj.smallPrice)
      ..writeByte(2)
      ..write(obj.mediumPrice)
      ..writeByte(3)
      ..write(obj.largePrice)
      ..writeByte(4)
      ..write(obj.image)
      ..writeByte(5)
      ..write(obj.username);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is PizzaAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class InvoiceAdapter extends TypeAdapter<Invoice> {
  @override
  final int typeId = 2;

  @override
  Invoice read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return Invoice()
      ..invoiceNumber = fields[0] as int
      ..customerName = fields[1] as String
      ..date = fields[2] as String
      ..time = fields[3] as String
      ..totalAmount = fields[4] as double
      ..discount = fields[5] as num
      ..items = fields[6] as String
      ..username = fields[7] as String;
  }

  @override
  void write(BinaryWriter writer, Invoice obj) {
    writer
      ..writeByte(8)
      ..writeByte(0)
      ..write(obj.invoiceNumber)
      ..writeByte(1)
      ..write(obj.customerName)
      ..writeByte(2)
      ..write(obj.date)
      ..writeByte(3)
      ..write(obj.time)
      ..writeByte(4)
      ..write(obj.totalAmount)
      ..writeByte(5)
      ..write(obj.discount)
      ..writeByte(6)
      ..write(obj.items)
      ..writeByte(7)
      ..write(obj.username);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is InvoiceAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
