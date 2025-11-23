import 'package:flutter/material.dart';
import 'package:projectuts/data/repository/user_repository.dart';
import 'package:projectuts/presentation/home_page.dart';
import 'package:projectuts/presentation/register_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _globalKey = GlobalKey<FormState>();
  final _emailCtr = TextEditingController();
  final _passCtr = TextEditingController();
  bool isObscure = true;

  final _userRepository = UserRepository();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: EdgeInsets.all(18.0),
          child: Form(
            key: _globalKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(height: 50),

                Image.asset(
                  'assets/presentation/Logo MediKlik.png',
                  width: 240,
                ),

                SizedBox(height: 20),

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
                  "Silahkan login untuk melanjutkan ke aplikasi MediKlik.",
                  textAlign: TextAlign.center,
                  style: TextStyle(fontSize: 14, color: Colors.black54),
                ),

                SizedBox(height: 40),

                Column(
                  children: [
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
                        hintText: "Masukkan Email",
                      ),
                    ),

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

                      obscureText: isObscure,

                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        label: Text("Password"),
                        hintText: "Masukkan Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            isObscure ? Icons.visibility_off : Icons.visibility,
                          ),
                          onPressed: () {
                            setState(() {
                              isObscure = !isObscure;
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
                        onPressed: () async {
                          if (_globalKey.currentState!.validate()) {
                            bool success = await _userRepository.login(
                              email: _emailCtr.text,
                              password: _passCtr.text,
                            );

                            if (success) {
                              String? username = await _userRepository
                                  .getUsernameByEmail(_emailCtr.text);
                              if (username != null) {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        HomePage(username: username),
                                  ),
                                );
                              } else {
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(
                                      "Terjadi Kesalahan, coba lagi.",
                                      style: TextStyle(color: Colors.white),
                                    ),
                                    backgroundColor: Colors.red,
                                  ),
                                );
                              }
                            } else {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(
                                    "Email atau Password salah!",
                                    style: TextStyle(color: Colors.white),
                                  ),
                                  backgroundColor: const Color.fromARGB(
                                    255,
                                    217,
                                    85,
                                    75,
                                  ),
                                ),
                              );
                            }
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blueAccent,
                          foregroundColor: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          elevation: 4,
                        ),
                        child: Text("SUBMIT"),
                      ),
                    ),

                    SizedBox(height: 20),

                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Apakah anda belum punya akun? "),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => RegisterPage(),
                              ),
                            );
                          },
                          child: Text(
                            "Daftar Disini!",
                            style: TextStyle(color: Colors.blueAccent),
                          ),
                        ),
                      ],
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
