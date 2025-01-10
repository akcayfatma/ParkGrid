import 'package:flutter/material.dart';
import 'package:parkgrid_y/features/harita/controller/harita_controller.dart';
//import 'package:flutter_svg/flutter_svg.dart';
//import 'package:parkgrid_y/temaBilesenleri/paths.dart';
import 'package:parkgrid_y/temaBilesenleri/renkler.dart';
import 'package:parkgrid_y/features/profile/views/profile.dart';
import 'package:parkgrid_y/features/gosterge/views/gosterge.dart';
import 'package:parkgrid_y/features/otopark/views/otopark.dart';
import 'package:parkgrid_y/features/harita/views/harita.dart';

class Home extends StatefulWidget{
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _simdikiIndex=0;

void onTap (int index) {
  setState(() {
      _simdikiIndex=index;
  });
}

List<Widget> list=[
  const Gosterge(), 
  const Profile(),
  HaritaScreen(controller: HaritaController()), 
  const Otopark(), 
  ];

  @override 
  Widget build(BuildContext context) {
    return Scaffold( 
         body: list[_simdikiIndex],
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(
          color: iconRenk),
          currentIndex: _simdikiIndex,
          onTap: onTap,
        items: const [
      BottomNavigationBarItem(
        icon: SizedBox.shrink(),
        //icon: SvgPicture.asset(homeSvg,),
      //activeIcon: SvgPicture.asset(homeSvg,),
        label: "Home",
        ),
      BottomNavigationBarItem(
        icon: SizedBox.shrink(),
        //icon: SvgPicture.asset(profilSvg,), 
      label: "Profil",
      ),
      BottomNavigationBarItem(
        icon: SizedBox.shrink(),
       //icon: SvgPicture.asset(homeSvg,), 
      label: "Harita",
      ),
      BottomNavigationBarItem(
        icon: SizedBox.shrink(),
       // icon: SvgPicture.asset(otoparkSvg,), 
      label: "Otopark",
      ),
      
      ],
    ),
   
    );
  }
}
