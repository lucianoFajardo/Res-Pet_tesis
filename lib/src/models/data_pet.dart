
// ignore_for_file: camel_case_types, non_constant_identifier_names

class data_pet {
  String id_pet;
  String id_photo_pet;
  String description_pet;
  String name_pet;
  String fur_color;
  int age_pet;
  int weight_pet;
  String gender_pet;
  bool is_sterilization;
  int size_pet;
  String location;
  String specific_care;
  String vaccines_pet;
  String createdAt;
  String id_User;

  data_pet(
      {
      required this.id_pet,
      required this.id_photo_pet,
      required this.description_pet,
      required this.name_pet,
      required this.fur_color,
      required this.weight_pet,
      required this.age_pet,
      required this.is_sterilization,
      required this.gender_pet,
      required this.location,
      required this.size_pet,
      required this.specific_care,
      required this.vaccines_pet,
      required this.createdAt,
      required this.id_User,});

  factory data_pet.fromMap(Map<dynamic, dynamic> map) {
    return data_pet(
      id_pet: map['id_pet_adoption'],
      id_photo_pet: map['photo_pet'],
      description_pet: map['description_pet'],
      fur_color: map['fur_color'],
      weight_pet: map['weight_pet'],
      age_pet: map['age_pet'],
      gender_pet: map['gender_pet'],
      location: map['location'],
      is_sterilization: map['is_sterilization'],
      id_User: map['id_user_created'],
      createdAt: map['created_at'],
      size_pet: map['size_pet'],
      specific_care: map['specific_care'],
      name_pet: map['name_pet'],
      vaccines_pet: map['vaccines_pet'],
    );
  }
  
}

