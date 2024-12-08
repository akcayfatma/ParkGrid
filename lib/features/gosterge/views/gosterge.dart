import 'package:flutter/material.dart';

class Gosterge extends StatelessWidget{
  const Gosterge({superkey});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      body:const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Align(alignment: Alignment.center,
          child: Text("Hoşgeldiniz!"),
          ),
        ],
    )
  );
  }

} 