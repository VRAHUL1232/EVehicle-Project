import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:ev_charger/screens/login.dart';
import 'package:ev_charger/screens/search_screen.dart';
import 'package:ev_charger/services/auth_service.dart';
import 'package:ev_charger/widgets/app_validator.dart';
import 'package:ev_charger/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUpView extends StatefulWidget {
  SignUpView({super.key});

  @override
  State<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends State<SignUpView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  var authService = AuthService();
  var isLoader = false;
  var isLoaderG = false;
  var isVisible = false;
  var isConfirmVisible = false;
  final FirebaseAuth auth = FirebaseAuth.instance;

  void signInWithGoogle(BuildContext context) async {
    try {
      // ignore: no_leading_underscores_for_local_identifiers
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        clientId:
            '404774671115-cav9vp3kpo56qccgbjugltm010d4n0qg.apps.googleusercontent.com',
      );
      final GoogleSignInAccount? gUser = await _googleSignIn.signIn();
      if (gUser == null) {
        // User canceled the sign-in
        return null;
      }
      final GoogleSignInAuthentication gAuth = await gUser.authentication;
      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: gAuth.accessToken,
        idToken: gAuth.idToken,
      );
      setState(() {
        isLoaderG = true;
      });
      final UserCredential authResult =
          await FirebaseAuth.instance.signInWithCredential(credential);
      final User user = authResult.user!;
      await FirebaseFirestore.instance.collection('users').doc(user.uid).set({
        'username': user.displayName,
        'email':user.email,
        'vehicle': "",
        'cable-type':"",
      });
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => SearchScreen(userCredential: authResult,)),
      );
      setState(() {
        isLoaderG = false;
      });
    } catch (err) {
      await showDialog(
        context: context,
        builder: (context) {
          return const ErrorDialog(
              errorMessage: "The selected google account failed to login.",
              errorTitle: "Authentication Failed");
        },
      );
    }
  }

  Future<void> _submitForm() async {
    if (_formKey.currentState!.validate()) {
      if (_passwordControlloer.text != _confirmPasswordController.text) {
        await showDialog(
          context: context,
          builder: (context) {
            return const ErrorDialog(
                errorMessage:
                    "The password does not match on both fields. Please check the entered password",
                errorTitle: "Authentication Failed");
          },
        );
      }
      setState(() {
        isLoader = true;
      });
      var data = {
        'username': _usernameControlloer.text,
        'email': _emailControlloer.text,
        'password': _passwordControlloer.text,
        'vehicle': "",
        'cable-type':"",
      };
      await authService.createUser(data, context);
      setState(() {
        isLoader = false;
      });
    }
  }

  var appValidator = AppValidator();

  final _usernameControlloer = TextEditingController();

  final _emailControlloer = TextEditingController();

  TextEditingController _passwordControlloer = TextEditingController();

  TextEditingController _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    super.dispose();
    _usernameControlloer.dispose();
    _emailControlloer.dispose();
    _passwordControlloer.dispose();
    _confirmPasswordController.dispose();
  }

  InputDecoration _buildInputDecoration(String value, IconData suffixIcon) {
    return InputDecoration(
      fillColor: Colors.black,
      filled: true,
      enabledBorder:
         const  OutlineInputBorder(borderSide: BorderSide(color: Colors.white30)),
      focusedBorder:
          const OutlineInputBorder(borderSide: BorderSide(color: Colors.white70)),
      labelStyle: TextStyle(color: Colors.white.withOpacity(0.55)),
      labelText: value,
      suffixIcon: Icon(suffixIcon, color: Colors.white.withOpacity(0.55)),
      border: OutlineInputBorder(
        borderSide: BorderSide(color: Colors.white.withOpacity(0.4)),
        borderRadius: BorderRadius.circular(10),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
               const Image(
                  width: double.infinity,
                  height: 270,
                  image: AssetImage("assets/images/design.jpg"),
                  fit: BoxFit.cover,
                ),
                Positioned(
                    top: 70,
                    left: MediaQuery.of(context).size.width * 0.35,
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                          fontSize: 38,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    )),
              ],
            ),
            Form(
              key: _formKey,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Column(
                  children: [
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _usernameControlloer,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(color: Colors.white),
                      decoration:
                          _buildInputDecoration("Username", Icons.person),
                      validator: appValidator.validateUsername,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _emailControlloer,
                      autovalidateMode: AutovalidateMode.onUserInteraction,
                      style: const TextStyle(color: Colors.white),
                      decoration: _buildInputDecoration("Email", Icons.email),
                      validator: appValidator.validateEmail,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _passwordControlloer,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        errorMaxLines: 2,
                        fillColor: Colors.black,
                        filled: true,
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white30)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70)),
                        labelStyle:
                            TextStyle(color: Colors.white.withOpacity(0.55)),
                        labelText: "Password",
                        suffixIcon: Padding(
                          padding:const EdgeInsets.all(10),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                isVisible = !isVisible;
                              });
                            },
                            icon: isVisible
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      obscureText: !isVisible,
                      validator: appValidator.validatePassword,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    TextFormField(
                      controller: _confirmPasswordController,
                      style: const TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                        errorMaxLines: 2,
                        fillColor: Colors.black,
                        filled: true,
                        enabledBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white30)),
                        focusedBorder: const OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white70)),
                        labelStyle:
                            TextStyle(color: Colors.white.withOpacity(0.55)),
                        labelText: "Confirm Password",
                        suffixIcon: Padding(
                          padding: const EdgeInsets.all(10),
                          child: IconButton(
                            onPressed: () {
                              setState(() {
                                isConfirmVisible = !isConfirmVisible;
                              });
                            },
                            icon: isConfirmVisible
                                ? const Icon(Icons.visibility)
                                : const Icon(Icons.visibility_off),
                          ),
                        ),
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.white.withOpacity(0.4)),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      obscureText: !isConfirmVisible,
                      validator: appValidator.validatePassword,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Container(
                      height: 50,
                      width: 250,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(48),
                          gradient:const LinearGradient(colors: [
                            Color.fromRGBO(20, 161, 161, 1),
                            Color.fromRGBO(0, 66, 66, 1)
                          ])),
                      child: ElevatedButton(
                        onPressed: () {
                          _submitForm();
                        },
                        style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            shadowColor: Colors.transparent),
                        child: (isLoader)
                            ? const CircularProgressIndicator(
                                color: Colors.white,
                              )
                            :const Text(
                                "Sign in",
                                style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white),
                              ),
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Text("Already have an account",
                            style: TextStyle(color: Colors.white)),
                        TextButton(
                          onPressed: () {
                            Navigator.of(context)
                                .pushReplacement(MaterialPageRoute(
                              builder: (context) => const LoginView(),
                            ));
                          },
                          child: const Text(
                            "Login",
                            style: TextStyle(
                                color: Color.fromRGBO(0, 168, 168, 1)),
                          ),
                        )
                      ],
                    ),
                    TextButton(
                        onPressed: () {
                          signInWithGoogle(context);
                        },
                        child: (isLoaderG) ? const CircularProgressIndicator(color: Colors.white,) : Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.network(
                                width: 25,
                                height: 25,
                                'http://pngimg.com/uploads/google/google_PNG19635.png',
                                fit: BoxFit.cover),
                            const Text(
                              "Continue with Google  ",
                              style: TextStyle(fontSize: 15),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
