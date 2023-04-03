import 'package:Dutch/main.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import '../HistoricPage.dart';
import 'ForgotPasswordPage.dart';
import 'SignUpPage.dart';
import 'components/Utils.dart';
import 'components/my_button.dart';
import 'components/my_textfield.dart';
import 'components/my_textfieldMDP.dart';
import 'components/square_tile.dart';

class LoginPage extends StatefulWidget {
  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();

  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  // sign user in method
  Future signUserIn() async {
    final isValid = formKey.currentState!.validate();
    if (!isValid) return;

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text.trim(),
          password: passwordController.text.trim());
      final FirebaseAuth auth = FirebaseAuth.instance;
      final User? user = auth.currentUser;
      download(user?.uid);
    } on FirebaseAuthException catch (e) {
      //printlog(e as String);
      Utils.showSnackBar(e.message);
    }
    Navigator.of(context).pop();
  }

  final GlobalKey<ScaffoldMessengerState> loginPageMessengerKey =
      GlobalKey<ScaffoldMessengerState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: loginPageMessengerKey,
      backgroundColor: myWhite,
      body: SafeArea(
        child: Center(
          child: Form(
            key: formKey,
            child: SingleChildScrollView(
              child: SizedBox(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 20),

                    NeumorphicIcon(
                      Icons.lock,
                      size: 80,
                      style: NeumorphicStyle(
                        intensity: 1,
                        surfaceIntensity: 0.04,
                        depth: 4,
                        shape: NeumorphicShape.flat,
                        color: mygrey,
                      ),
                    ),

                    const SizedBox(height: 72),

                    // welcome back, you've been missed!
                    Text(
                      'Connectez vous à votre compte Score Dutch',
                      style: TextStyle(
                        color: mygrey,
                        fontSize: 14,
                      ),
                    ),

                    const SizedBox(height: 25),

                    // username textfield
                    MyTextField(
                      controller: emailController,
                      hintText: 'Email',
                      obscureText: false,
                    ),

                    const SizedBox(height: 12),

                    // password textfield
                    MyTextFieldMDP(
                      controller: passwordController,
                      hintText: 'Mot de passe',
                      obscureText: true,
                    ),

                    const SizedBox(height: 10),

                    // forgot password?
                    GestureDetector(
                      onTap: () => Navigator.of(context).push(MaterialPageRoute(
                          builder: (context) => ForgotPasswordPage())),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 25.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Mot de passe oublié ?',
                              style: TextStyle(color: mygrey),
                            ),
                          ],
                        ),
                      ),
                    ),

                    const SizedBox(height: 25),

                    // sign in button
                    MyButton(onTap: signUserIn, text: "Se Connecter"),

                    const SizedBox(height: 30),

                    // or continue with
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 25.0),
                      child: Row(
                        children: [
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 10.0),
                            child: Text(
                              'Enregistrez vous avec',
                              style: TextStyle(color: mygrey),
                            ),
                          ),
                          Expanded(
                            child: Divider(
                              thickness: 0.5,
                              color: Colors.grey[400],
                            ),
                          ),
                        ],
                      ),
                    ),

                    const SizedBox(height: 20),
                    const SizedBox(height: 30),

                    // google + apple sign in buttons
                    /**
                        Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: const [
                        // google button
                        SquareTile(imagePath: 'lib/Assets/google.png'),

                        SizedBox(width: 25),

                        // apple button
                        SquareTile(imagePath: 'lib/Assets/apple.png')
                        ],
                        ),
                     **/

                    const SizedBox(height: 20),

                    // not a member? register now

                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: GestureDetector(
                        onTap: () => showDialog(
                            context: context, builder: (context) => SignUpPage()),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text('Pas de compte ?  ',
                                style: TextStyle(color: mygrey)),
                            Text(
                              'Créer un compte',
                              style: TextStyle(
                                color: tan1,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
