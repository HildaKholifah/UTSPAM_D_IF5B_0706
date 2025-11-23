class User {
  int? id;
  String nama;
  String email;
  String alamat;
  String telepon;
  String username;
  String password;
  String gender;

  User({
    this.id,
    required this.nama,
    required this.email,
    required this.alamat,
    required this.telepon,
    required this.username,
    required this.password,
    required this.gender,
  });

  Map<String, dynamic> toMap() {
    var map = <String, dynamic>{
      'nama': nama,
      'email': email,
      'alamat': alamat,
      'telepon': telepon,
      'username': username,
      'password': password,
      'gender': gender,
    };
    if (id != null) map['id'] = id;
    return map;
  }

  factory User.fromMap(Map<String, dynamic> map) {
    return User(
      id: map['id'],
      nama: map['nama'],
      email: map['email'],
      alamat: map['alamat'],
      telepon: map['telepon'],
      username: map['username'],
      password: map['password'],
      gender: map['gender'],
    );
  }
}
