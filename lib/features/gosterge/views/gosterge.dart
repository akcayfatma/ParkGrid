import 'package:flutter/material.dart';

class Gosterge extends StatelessWidget{
  const Gosterge({super.key, superkey});

  @override
  Widget build(BuildContext context){
    return const Scaffold(
      body:Column(
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