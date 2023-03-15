import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'components/Utils.dart';
import 'components/my_button.dart';
import 'components/my_textfield.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final formKey = GlobalKey<FormState>();

  // text editing controllers
  final emailController = TextEditingController();

  // sign user in method
  Future ResetMdp() async {
    showDialog(
        context: context,
        barrierDismissible: false,
        builder: (context) => const Center(child: CircularProgressIndicator()));

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(
          email: emailController.text.trim());
      Utils.showSnackBar("Une demande de changement de mot de passe a été envoyé");
    }on FirebaseAuthException catch (e){
      Utils.showSnackBar(e.message);
    }
    Navigator.of(context).pop();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[300],
      body: SafeArea(
        child: Center(
          child: Form(
            key: formKey,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 12.0),
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
                        },
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 100),

                // logo
                const Icon(
                  Icons.lock_reset_outlined,
                  size: 80,
                ),

                const SizedBox(height: 50),

                // welcome back, you've been missed!
                Text(
                  'Entrez votre Email pour redéfinir un mot de passe',
                  style: TextStyle(
                    color: Colors.grey[700],
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

                const SizedBox(height: 25),

                // sign in button
                MyButton(onTap: ResetMdp, text: "Changer Mot de Passe"),

                const SizedBox(height: 170),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
