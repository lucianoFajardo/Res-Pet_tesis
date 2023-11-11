// ignore_for_file: camel_case_types

class userMetaData {
  String name;
  String lastName;
  String celphoneNumber;
  String idUser;
  String locationUser;

  userMetaData(
      {required this.name,
      required this.lastName,
      required this.celphoneNumber,
      required this.idUser,
      required this.locationUser});

  factory userMetaData.fromMap(Map<dynamic, dynamic> map) {
    return userMetaData(
        name: map['name_user'],
        lastName: map['last_name'],
        celphoneNumber: map['celphone_number'],
        idUser: map['id_user'],
        locationUser: map['location_user']);
  }

  userMetaData copyWith({
    String? name,
    String? lastName,
    String? celphoneNumber,
    String? idUser,
    String? locationUser,
  }) {
    return userMetaData(
        name: name ?? this.name,
        lastName: lastName ?? this.lastName,
        celphoneNumber: celphoneNumber ?? this.celphoneNumber,
        idUser: idUser ?? this.idUser,
        locationUser: locationUser ?? this.locationUser);
  }
}
