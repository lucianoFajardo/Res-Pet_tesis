// ignore_for_file: unused_label, non_constant_identifier_names

class data_pet {
  String id_pet;
  String name;
  bool gender;
  String location;
  String years;
  String createdAt;
  bool isFavoritePet;
  String id_User;
  String id_photo_pet;
  String nameUser;

  data_pet(
      {required this.gender,
      required this.id_pet,
      required this.years,
      required this.location,
      required this.name,
      required this.createdAt,
      this.isFavoritePet = false,
      required this.id_User,
      required this.id_photo_pet,
      required this.nameUser});

  factory data_pet.fromMap(Map<dynamic, dynamic> map) {
    return data_pet(
      id_pet: map['id_pet'],
      gender: map['gender'],
      years: map['years_pet'],
      location: map['location_pet'],
      name: map['name_pet'],
      createdAt: map['created_at'],
      isFavoritePet: map['isFavorite'],
      id_User: map['id_user_created'],
      id_photo_pet: map['photo_pet'],
      nameUser: map['user_name'],
    );
  }

  data_pet copyWith(
      {String? id_pet,
      String? name,
      bool? gender,
      String? location,
      String? years,
      String? createdAt,
      bool? isFavoritePet,
      String? id_User,
      String? id_photo_pet,
      String? nameUser}) {
    return data_pet(
        gender: gender ?? this.gender,
        id_pet: id_pet ?? this.id_pet,
        years: years ?? this.years,
        location: location ?? this.location,
        name: name ?? this.name,
        createdAt: createdAt ?? this.createdAt,
        isFavoritePet: isFavoritePet ?? this.isFavoritePet,
        id_User: id_User ?? this.id_User,
        id_photo_pet: id_photo_pet ?? this.id_photo_pet,
        nameUser: nameUser ?? this.nameUser);
  }
}
