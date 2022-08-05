import 'package:floor/floor.dart';

@entity
class Person {
  @primaryKey
  final int id;
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? age;
  final String? address;
  final String? district;
  final String? subDistrict;
  final String? province;
  final String? country;
  final String? phoneNumber;
  final String? zipCode;

  Person(
    this.id, {
    this.firstName,
    this.lastName,
    this.email,
    this.age,
    this.address,
    this.district,
    this.subDistrict,
    this.province,
    this.country,
    this.phoneNumber,
    this.zipCode,
  });
}
