import 'package:flutter/material.dart';
import 'package:projectuts/presentation/login_page.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _namaLengkapCtr = TextEditingController();
  final _emailCtr = TextEditingController();
  final _alamatCtr = TextEditingController();
  final _telpCtr = TextEditingController();
  final _usernameCtr = TextEditingController();
  final _passCtr = TextEditingController();
  final _confirmCtr = TextEditingController();

  String? _gender;
  bool _isObscure1 = true;
  bool _isObscure2 = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(18.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 10),
                Text(
                  "Selamat Datang di Aplikasi MediKlik!",
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                    color: Colors.blue,
                  ),
                ),

                SizedBox(height: 8),

                Text(
                  "Silahkan registrasi untuk melanjutkan ke aplikasi MediKlik.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),

                SizedBox(height: 20),

                TextFormField(
                  controller: _namaLengkapCtr,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Nama tidak boleh kosong";
                    }
                    if (value == RegExp(r'^[a-z]+$').toString()) {
                      return 'Nama hanya boleh berisi huruf';
                    }
                    return null;
                  },

                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    label: Text("Nama Lengkap"),
                    hintText: "Masukkan nama anda",
                  ),
                ),

                SizedBox(height: 10),

                TextFormField(
                  controller: _emailCtr,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your email";
                    } else if (!value.contains("@")) {
                      return "Please enter a valid email address";
                    } else if (!value.contains("@gmail.com")) {
                      return "Email harus berakhiran @gmail.com";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,

                  decoration: InputDecoration(
                    label: Text("Email"),
                    hintText: "Masukkan email",
                  ),
                ),

                SizedBox(height: 10),

                TextFormField(
                  controller: _telpCtr,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your phone number";
                    } else if (!value.contains("08")) {
                      return "Please enter a valid phone number";
                    } else if (value.length < 10) {
                      return "Please enter a valid phone number";
                    }
                    return null;
                  },
                  keyboardType: TextInputType.emailAddress,

                  decoration: InputDecoration(
                    label: Text("No. Telepon"),
                    hintText: "Masukkan no. telepon anda",
                  ),
                ),

                SizedBox(height: 10),

                TextFormField(
                  controller: _alamatCtr,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Alamat tidak boleh kosong";
                    }
                    if (value == RegExp(r'^[a-z]+$').toString()) {
                      return 'Nama hanya boleh berisi huruf';
                    }
                    return null;
                  },

                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    label: Text("Alamat"),
                    hintText: "Masukkan alamat anda",
                  ),
                ),

                SizedBox(height: 10),

                Align(
                  alignment: Alignment.centerLeft,
                  child: Text("Jenis Kelamin"),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: RadioListTile(
                        title: Text("Laki-laki"),
                        value: "Laki-laki",
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() => _gender = value);
                        },
                      ),
                    ),
                    Expanded(
                      child: RadioListTile(
                        title: Text("Perempuan"),
                        value: "Perempuan",
                        groupValue: _gender,
                        onChanged: (value) {
                          setState(() => _gender = value);
                        },
                      ),
                    ),
                  ],
                ),

                TextFormField(
                  controller: _usernameCtr,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Username tidak boleh kosong";
                    }
                    return null;
                  },

                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    label: Text("Username"),
                    hintText: "Masukkan Username anda",
                  ),
                ),

                SizedBox(height: 10),

                TextFormField(
                  controller: _passCtr,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    }
                    if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    }
                    return null;
                  },

                  obscureText: _isObscure1,

                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    label: Text("Password"),
                    hintText: "Masukkan password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure1 ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure1 = !_isObscure1;
                        });
                      },
                    ),
                  ),
                ),

                SizedBox(height: 10),

                TextFormField(
                  controller: _confirmCtr,
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  validator: (value) {
                    if (value!.isEmpty) {
                      return "Please enter your password";
                    } else if (value.length < 8) {
                      return 'Password must be at least 8 characters long';
                    } else if (value != _passCtr.text) {
                      return "Password tidak sama!";
                    }
                    return null;
                  },

                  obscureText: _isObscure2,

                  keyboardType: TextInputType.name,
                  decoration: InputDecoration(
                    label: Text("Confirm Password"),
                    hintText: "Masukkan password",
                    suffixIcon: IconButton(
                      icon: Icon(
                        _isObscure2 ? Icons.visibility_off : Icons.visibility,
                      ),
                      onPressed: () {
                        setState(() {
                          _isObscure2 = !_isObscure2;
                        });
                      },
                    ),
                  ),
                ),

                SizedBox(height: 20),

                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => RegisterPage(),
                          ),
                        );
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.lightBlue,
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 4,
                    ),
                    child: Text("DAFTAR"),
                  ),
                ),

                SizedBox(height: 20),

                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("Apakah sudah punya akun? "),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LoginPage()),
                        );
                      },
                      child: Text(
                        "Masuk Disini!",
                        style: TextStyle(color: Colors.blueAccent),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
