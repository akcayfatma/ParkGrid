import 'dart:convert';

class UserModel{
  String? uid;
  String name;
  String surname;
  String email;
  String fuelType;
  String? profilePhoto;
  UserModel({
    this.uid,
    required this.name,
    required this.surname,
    required this.email,
    required this.fuelType,
    this.profilePhoto,
  });

  UserModel copyWith({
    String? uid,
    String? name,
    String? surname,
    String? email,
    String? carModel,
    String? fuelType,
    String? profilePhoto,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      surname: surname ?? this.surname,
      email: email ?? this.email,
      fuelType: fuelType ?? this.fuelType,
      profilePhoto: profilePhoto ?? this.profilePhoto,
    );
  }

  Map<String, dynamic> toMap(){
    return <String, dynamic>{
      'uid': uid,
      'name': name,
      'surname': surname,
      'email': email,
      'fuelType': fuelType,
      'profilePhoto': profilePhoto,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      surname: map['surname'] as String,
      email: map['email'] as String,
      fuelType: map['fuelType'] as String,
      profilePhoto: map['profilePhoto'] != null ? map["profilePhoto"] as String : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory UserModel.fromJson(String source) => UserModel.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString(){
    return 'UserModel(uid: $uid, name: $name, surname: $surname, email: $email, fuelType: $fuelType, profilePhoto: $profilePhoto)';
  } 

  @override
  bool operator ==(covariant UserModel other){
    if(identical(this, other)) return true;

    return
    other.uid == uid &&
    other.name == name &&
    other.surname == surname &&
    other.email == email &&
    other.fuelType == fuelType&&
    other.profilePhoto == profilePhoto;
  }

  @override
  int get hashCode{
    return uid.hashCode ^
    name.hashCode ^
    surname.hashCode ^
    email.hashCode ^
    fuelType.hashCode ^
    profilePhoto.hashCode;
  }
}