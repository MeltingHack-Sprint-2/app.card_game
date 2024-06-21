
class UserInMemoryStorage {
  UserModel? model;
  UserInMemoryStorage({required this.model});
}


/// TODO
class UserModel {
    UserModel({
        required this.id,
        required this.email,
        required this.phone,
        required this.firstName,
        required this.lastName,
        required this.pinId,
    });

    final int? id;
    final String? email;
    final String? phone;
    final String? firstName;
    final String? lastName;
    final String? pinId;

    factory UserModel.fromJson(Map<String, dynamic> json){ 
        return UserModel(
            id: json["id"],
            email: json["email"],
            phone: json["phone"],
            firstName: json["first_name"],
            lastName: json["last_name"],
            pinId: json["pin_id"],
        );
    }

}
