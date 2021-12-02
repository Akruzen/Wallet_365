// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Transactions.dart';

// **************************************************************************
// TypeAdapterGenerator
// **************************************************************************

class needsTransactionAdapter extends TypeAdapter<needsTransaction> {
  @override
  final int typeId = 0;

  @override
  needsTransaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return needsTransaction()
      ..transactionDate = fields[0] as DateTime
      ..label = fields[1] as String
      ..amount = fields[2] as String
      ..subCategory = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, needsTransaction obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.transactionDate)
      ..writeByte(1)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.subCategory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is needsTransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class miscellaneousTransactionAdapter
    extends TypeAdapter<miscellaneousTransaction> {
  @override
  final int typeId = 1;

  @override
  miscellaneousTransaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return miscellaneousTransaction()
      ..transactionDate = fields[0] as DateTime
      ..label = fields[1] as String
      ..amount = fields[2] as String
      ..subCategory = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, miscellaneousTransaction obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.transactionDate)
      ..writeByte(1)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.subCategory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is miscellaneousTransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}

class healthCareTransactionAdapter extends TypeAdapter<healthCareTransaction> {
  @override
  final int typeId = 2;

  @override
  healthCareTransaction read(BinaryReader reader) {
    final numOfFields = reader.readByte();
    final fields = <int, dynamic>{
      for (int i = 0; i < numOfFields; i++) reader.readByte(): reader.read(),
    };
    return healthCareTransaction()
      ..transactionDate = fields[0] as DateTime
      ..label = fields[1] as String
      ..amount = fields[2] as String
      ..subCategory = fields[3] as String;
  }

  @override
  void write(BinaryWriter writer, healthCareTransaction obj) {
    writer
      ..writeByte(4)
      ..writeByte(0)
      ..write(obj.transactionDate)
      ..writeByte(1)
      ..write(obj.label)
      ..writeByte(2)
      ..write(obj.amount)
      ..writeByte(3)
      ..write(obj.subCategory);
  }

  @override
  int get hashCode => typeId.hashCode;

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is healthCareTransactionAdapter &&
          runtimeType == other.runtimeType &&
          typeId == other.typeId;
}
