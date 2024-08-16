import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  UserModel({
    required this.id,
    required this.email,
    required this.image,
    required this.fullName,
    required this.contactNo,
    required this.createdDate,
    required this.gender,
    required this.bio,
    required this.address,
  });

  late String id;
  late String email;
  late String image;
  late String fullName;
  late String contactNo;
  late String createdDate;
  late String gender;
  late String bio;
  late String address;

  factory UserModel.fromDocument(DocumentSnapshot doc) {
    var json = doc.data() as Map<String, dynamic>;
    return UserModel(
      id: doc.id,
      email: json["email"] ?? "",
      image: json["image"] ?? "",
      fullName: json["fullName"] ?? "",
      contactNo: json["contactNo"] ?? "",
      createdDate: json["createdDate"] ?? "",
      gender: json["gender"] ?? "",
      bio: json["bio"] ?? "",
      address: json["address"] ?? "",
    );
  }

  Map<String, dynamic> toJson() => {
        "id": id,
        "email": email,
        "image": image,
        "fullName": fullName,
        "contactNo": contactNo,
        "createdDate": createdDate,
        "gender": gender,
        "bio": bio,
        "address": address,
      };
}
