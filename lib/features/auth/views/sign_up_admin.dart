import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:parkgrid_y/features/auth/controller/auth_controller.dart';
import 'package:parkgrid_y/temaBilesenleri/renkler.dart';

class SignUpAdmin extends StatefulWidget {
  const SignUpAdmin({super.key});

  @override
  State<SignUpAdmin> createState() => _SignUpAdminState();
}

class _SignUpAdminState extends State<SignUpAdmin> {
 final TextEditingController _emailController=TextEditingController();
 final TextEditingController _passwordController=TextEditingController();
 final _formKey=GlobalKey<FormState>();

  
  @override
  void dispose(){
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: const Color(0xff212544),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Form(
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    key: _formKey,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children:[
                          const Text("Hoşgeldiniz!",  style: TextStyle(fontSize: 30,color: Colors.white, fontWeight: FontWeight.bold),
                          
                          ),
                          customSizedBox(),
                          TextFormField(
                            controller: _emailController,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Email is required";
                              }
                              return null;
                            },
                            decoration: customInputDecoration("E-mail"),
                            style: const TextStyle(color: Colors.white), 
                          ), 
                          customSizedBox(),
                          TextFormField(
                            controller: _passwordController,
                            validator: (value){
                              if(value!.isEmpty){
                                return "Password is required";
                              }
                              return null;
                            },
                            obscureText: true,
                            decoration: customInputDecoration("Sifre"),
                            style: const TextStyle(color: Colors.white),
                          ),
                          customSizedBox(),
                          Center(
                            child: TextButton(
                              onPressed: () {}, child: Text("Sifremi Unuttum", style:TextStyle(color: Colors.pink[200]),
                              ),
                            ),
                          ),
                          customSizedBox(),
                          Consumer( 
                            builder: (context,ref,child){
                              return Center(
                                child: TextButton(
                                  onPressed: () {
                                    if(_formKey.currentState!.validate()) {
                                      ref
                                      .read(authControllerProvider)
                                      .signInWithEmailAndPassword(
                                        email: _emailController.text, 
                                        password: _passwordController.text,
                                      ); 
                                    }
                      
                                  }, 
                                  child:Container(
                                    height:50,
                                    width:150,
                                    margin:const EdgeInsets.symmetric(horizontal:60),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(50),
                                      color:const Color(0xff31274F)
                                    ),
                                    child: const Center(
                                      child: Text(
                                        "Giris Yap", style:TextStyle(color: butonYazi),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            },
                          ),
                      
                          customSizedBox(),
                          Center(
                            child: TextButton(
                              onPressed: () {}, child: Text("Hesap Olustur", style:TextStyle(color:pembis),
                              ),
                            ),
                          ),
                          
                        ],
                      ),
                    ),
                  ),
                  )  
              ],    
            ),
          ),
      ),
      );
    
  }
  Widget customSizedBox() => const SizedBox(height:20,);
  InputDecoration customInputDecoration(String hintText){
    return InputDecoration(
      hintText: hintText,
      hintStyle: const TextStyle(color: Colors.grey),
      enabledBorder:const UnderlineInputBorder(
        borderSide: BorderSide(
          color: Colors.grey,
          ), 
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(
          color: Colors.grey,
        ),
      ),
    );
  } 
}

