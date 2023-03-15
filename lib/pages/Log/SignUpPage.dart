import 'package:Dutch/main.dart';
import 'package:Dutch/model/Utilisateur.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../boxes.dart';
import 'components/Utils.dart';
import 'components/my_button.dart';
import 'components/my_textfield.dart';
import 'components/my_textfieldMDP.dart';
import 'components/square_tile.dart';

class SignUpPage extends StatefulWidget {

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  // text editing controllers
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confpasswordController = TextEditingController();

  void inputData(auth) {
    final User user = auth.currentUser;
    final uid = user.uid;
    Utilisateur u = Utilisateur(uid,  emailController.text, emailController.text, passwordController.text, DateTime(2023,11,14), null, 0, false);
    upLoadUser(u);
  }

  // sign user in method
  Future signUserUp() async {

    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {
      if (passwordController.text == confpasswordController.text) {

        await FirebaseAuth.instance.createUserWithEmailAndPassword(
            email: emailController.text.trim(),
            password: passwordController.text.trim());

        final FirebaseAuth auth = FirebaseAuth.instance;
        final User? user = await auth.currentUser;
        u = Utilisateur(user?.uid,  emailController.text, emailController.text, passwordController.text, DateTime(2023,11,14), Boxes.getparties(), 0, false);
        upLoadUser(u);


        Utils.showSnackBar("Création du compte réussie");
      }else{
        Utils.showSnackBar("le mot de passe de confirmation n'est pas valide !");
      }
    } on FirebaseAuthException catch (e) {
      print(e);
      Utils.showSnackBar(e.message);
    }
    Navigator.of(context).pop();
    Navigator.of(context).pop();
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left:12.0),
                    child: Container(
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.white),
                          borderRadius: BorderRadius.circular(16),
                          color: Colors.grey[200],
                        ),
                      child: IconButton(

                      icon: const Icon(Icons.arrow_back_ios_new_rounded),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },),
                    ),
                  ),
                  ),
              // logo
              const Icon(
                Icons.lock,
                size: 80,
              ),

              const SizedBox(height: 30),

              // welcome back, you've been missed!
              Text(
                'Créer un compte',
                style: TextStyle(
                  color: Colors.grey[700],
                  fontSize: 16,
                ),
              ),

              const SizedBox(height: 25),

              // username textfield
              MyTextField(
                controller: emailController,
                hintText: 'Email',
                obscureText: false,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextFieldMDP(
                controller: passwordController,
                hintText: 'Mot de passe',
                obscureText: true,
              ),

              const SizedBox(height: 10),

              // password textfield
              MyTextFieldMDP(
                controller: confpasswordController,
                hintText: 'confirmation',
                obscureText: true,
              ),

              const SizedBox(height: 40),

              // sign in button
              MyButton(onTap: signUserUp, text: "Créer Compte"),

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
                        style: TextStyle(color: Colors.grey[700]),
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
            ],
          ),
        ),
      ),
    );
  }
}
