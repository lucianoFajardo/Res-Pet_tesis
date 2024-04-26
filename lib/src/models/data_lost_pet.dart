// ignore_for_file: camel_case_types, non_constant_identifier_names

class data_Lost_Pet {
  String id_pet_adoption;
  String photo_pet;
  String description_pet;
  String fur_color;
  int weight_pet;
  int age_pet;
  String gender_pet;
  String location;
  int size_pet;
  String created_at;
  String name_pet;
  String nameUser;
  String celphoneUser;
  String id_user_created;
  String modificated_at;

  data_Lost_Pet(
      {required this.id_pet_adoption,
      required this.photo_pet,
      required this.description_pet,
      required this.fur_color,
      required this.weight_pet,
      required this.age_pet,
      required this.gender_pet,
      required this.location,
      required this.size_pet,
      required this.created_at,
      required this.name_pet,
      required this.id_user_created,
      required this.nameUser,
      required this.celphoneUser,
      required this.modificated_at});

  factory data_Lost_Pet.fromMap(Map<dynamic, dynamic> map) {
    return data_Lost_Pet(
        id_pet_adoption: map['id_pet_adoption'],
        photo_pet: map['photo_pet'],
        description_pet: map['description_pet'],
        fur_color: map['fur_color'],
        weight_pet: map['weight_pet'],
        age_pet: map['age_pet'],
        gender_pet: map['gender_pet'],
        location: map['location'],
        size_pet: map['size_pet'],
        created_at: map['created_at'],
        name_pet: map['name_pet'],
        nameUser: map['user_metadata']['name_user'],
        celphoneUser: map['user_metadata']['celphone_number'],
        id_user_created: map['id_user_created'],
        modificated_at: map['modificated_at']);
  }
}
