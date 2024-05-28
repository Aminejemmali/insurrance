import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String uid;
  String firstName;
  String lastName;
  String emailAddress;
  String? address;
  String? phoneNumber;
  String? postalCode;
  bool isActive;
  Timestamp createdAt;
  Timestamp updatedAt;

  UserModel({
    required this.uid,
    required this.firstName,
    required this.lastName,
    required this.emailAddress,
    required this.isActive,
    required this.createdAt,
    required this.updatedAt,
    this.phoneNumber,
    this.address,
    this.postalCode,
  });

  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return UserModel(
      uid: doc.id,
      firstName: data['firstName'] ?? '',
      lastName: data['lastName'] ?? '',
      emailAddress: data['emailAddress'] ?? '',
      isActive: data['isActive'] ?? false,
      createdAt: data['createdAt'] ?? Timestamp.now(),
      updatedAt: data['updatedAt'] ?? Timestamp.now(),
      phoneNumber: data['phoneNumber'],
      address: data['address'],
      postalCode: data['postalCode'],
    );
  }

  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      uid: json['id'],
      firstName: json['prenom'],
      lastName: json['nom'],
      emailAddress: json['email'],
      isActive: true,
      createdAt: Timestamp.fromDate(DateTime.parse(json['created_at'])),
      updatedAt: Timestamp.fromDate(DateTime.parse(json['updated_at'])),
      phoneNumber: json['num_tel'],
      address: json['adresse'],
      postalCode: json['code_postale'],
    );
  }
}
