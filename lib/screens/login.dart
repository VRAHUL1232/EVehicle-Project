import 'package:ev_charger/screens/home_screen.dart';
import 'package:ev_charger/screens/sign_up.dart';
import 'package:ev_charger/services/auth_service.dart';
import 'package:ev_charger/widgets/app_validator.dart';
import 'package:ev_charger/widgets/error_dialog.dart';
import 'package:flutter/material.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter/widgets.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  var isLoader = false;
  var isLoaderG = false;
  var isVisible = false;
  final _emailControlloer = TextEditingController();
  final _passwordControlloer = TextEditingController();
  final authService = AuthService();
  final FirebaseAuth auth = FirebaseAuth.instance;
  String? errorMessage = null;

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
      await FirebaseAuth.instance.signInWithCredential(credential);

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => const HomeScreen()),
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

  @override
  Widget build(BuildContext context) {
    Future<void> submitForm() async {
      try {
        if (_formKey.currentState!.validate()) {
          setState(() {
            isLoader = true;
          });

          var data = {
            'email': _emailControlloer.text,
            'password': _passwordControlloer.text
          };

          await authService.login(data, context);
          setState(() {
            isLoader = false;
          });
        }
      } on FirebaseAuthException catch (error) {
        switch (error.code) {
          case "ERROR_INVALID_EMAIL":
            errorMessage = "Your email address appears to be malformed.";
            break;
          case "ERROR_WRONG_PASSWORD":
            errorMessage = "Your password is wrong.";
            break;
          case "ERROR_USER_NOT_FOUND":
            errorMessage = "User with this email doesn't exist.";
            break;
          case "ERROR_USER_DISABLED":
            errorMessage = "User with this email has been disabled.";
            break;
          case "ERROR_TOO_MANY_REQUESTS":
            errorMessage = "Too many requests. Try again later.";
            break;
          case "ERROR_OPERATION_NOT_ALLOWED":
            errorMessage = "Signing in with Email and Password is not enabled.";
            break;
          default:
            errorMessage = "An undefined Error happened.";
        }
        if (errorMessage != null) {
          await showDialog(
            context: context,
            builder: (context) {
              return ErrorDialog(
                  errorMessage: errorMessage!,
                  errorTitle: "Authentication Failed");
            },
          );
        }
      }
    }

    var appValidator = AppValidator();

    void dispose() {
      super.dispose();
      _emailControlloer.dispose();
      _passwordControlloer.dispose();
    }

    InputDecoration _buildInputDecoration(String value, IconData? suffixIcon) {
      return InputDecoration(
        fillColor: Colors.black,
        filled: true,
        enabledBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white60)),
        focusedBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.white)),
        labelStyle: TextStyle(color: Colors.white.withOpacity(0.55)),
        labelText: value,
        suffixIcon: (suffixIcon == null)
            ? null
            : Icon(suffixIcon, color: Colors.white.withOpacity(0.55)),
        border: OutlineInputBorder(
          borderSide: BorderSide(color: Colors.white.withOpacity(0.70)),
          borderRadius: BorderRadius.circular(10),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: Padding(
        padding: const EdgeInsets.all(0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  const Image(
                    width: double.infinity,
                    height: 300,
                    image: AssetImage("assets/images/design.jpg"),
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                      top: 70,
                      left: MediaQuery.of(context).size.width * 0.38,
                      child: const Text(
                        "Login",
                        style: TextStyle(
                            fontSize: 38,
                            fontWeight: FontWeight.w600,
                            color: Colors.white),
                      )),
                ],
              ),
              const SizedBox(
                height: 50,
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: Column(
                    children: [
                      TextFormField(
                        controller: _emailControlloer,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        style: const TextStyle(color: Colors.white),
                        decoration: _buildInputDecoration("Email", Icons.email),
                        validator: appValidator.validateEmail,
                      ),
                      const SizedBox(
                        height: 25,
                      ),
                      TextFormField(
                        controller: _passwordControlloer,
                        style: const TextStyle(color: Colors.white),
                        decoration: InputDecoration(
                          fillColor: Colors.black,
                          filled: true,
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white60)),
                          focusedBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white)),
                          labelStyle:
                              TextStyle(color: Colors.white.withOpacity(0.70)),
                          labelText: "Password",
                          suffixIcon: Padding(
                            padding: const EdgeInsets.all(10),
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
                            borderSide: BorderSide(
                                color: Colors.white.withOpacity(0.70)),
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                        obscureText: !isVisible,
                        validator: (value) {
                          if (value == null || value.isEmpty)
                            return "Please enter a password";
                        },
                      ),
                      const SizedBox(
                        height: 30,
                      ),
                      Container(
                        height: 50,
                        width: 250,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(48),
                            gradient: const LinearGradient(colors: [
                              Color.fromRGBO(20, 161, 161, 1),
                              Color.fromRGBO(0, 66, 66, 1)
                            ])),
                        child: ElevatedButton(
                          onPressed: () {
                            submitForm();
                          },
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.transparent,
                              shadowColor: Colors.transparent),
                          child: (isLoader)
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : const Text(
                                  "Sign in",
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.white),
                                ),
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("Don't have an account",
                              style: TextStyle(color: Colors.white)),
                          TextButton(
                            onPressed: () {
                              Navigator.of(context)
                                  .pushReplacement(MaterialPageRoute(
                                builder: (context) => SignUpView(),
                              ));
                            },
                            child: const Text(
                              "Sign up",
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
                          child: (isLoaderG)
                              ? const CircularProgressIndicator(
                                  color: Colors.white,
                                )
                              : Row(
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
