
import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:google_fonts/google_fonts.dart';

import 'Aimbot/screens/home.dart';
import 'Regeister.dart';
import 'RegeisterTime/screens/home.dart';
import 'Videos/screens/home.dart';
import 'news/screens/home.dart';

int initScreen;
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();


  return runApp(MyApp());}




class  MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {


  @override
  Widget build(BuildContext context) {
    return    MaterialApp(
            title: '',


            debugShowCheckedModeBanner: false,
            home : HomePage(),



    );
  }
}





class HomePage extends   StatefulWidget {

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {

    return  WillPopScope(
      onWillPop: () {
        return AwesomeDialog(
          context: context,
          headerAnimationLoop: false,
          dialogType: DialogType.ERROR,
          animType: AnimType.BOTTOMSLIDE,
          body: ListTile(
            title: Padding(
              padding: const EdgeInsets.only(bottom: 15.0),
              child: Text(
                "هل تود اغلاق التطبيق",
                textAlign: TextAlign.center,
              ),
            ),
            subtitle: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                FlatButton(
                  color: Colors.green,
                  child: Text("نعم"),
                  onPressed: () {
                    SystemNavigator.pop();
                  },
                ),
                FlatButton(
                  color: Colors.red,
                  child: Text("لا"),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                )
              ],
            ),
          ),
        ).show();
      },

      child: Scaffold(
          backgroundColor:  Color(0xffCBBFD5),
          appBar: AppBar(
            backgroundColor: Color(0xff4E008A),
            title:Text("الرئيسية",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:24),),
            centerTitle: true,

            actions: [
              Image.asset("assets/logo.png",color: Colors.white,),
            ],
            leading: IconButton(
              icon: Icon(Icons.keyboard_arrow_left,color: Color(0xff4E008A),),
              onPressed: null,
            ),
          ),

          body: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeNews()));

                    },
                    child: Container(
                      height: 150,
                      width: 150,
                      child: Image.asset("assets/news.png"),
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Color(0xff4E008A),width: 8)
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeAimbot()));
                    },
                    child: Container(
                      child: Image.asset("assets/input.png"),

                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Color(0xff4E008A),width: 8)
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [

                  InkWell(
                    onTap: (){
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>HomeVideo()));

                    },
                    child: Container(
                      child: Image.asset("assets/video.png"),

                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Color(0xff4E008A),width: 8)
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => signup()));
                    },
                    child: Container(
                      child: Icon(Icons.person,color: Color(0xff4E008A),size: 80,),

                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Color(0xff4E008A),width: 8)
                      ),
                    ),
                  )
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,

                children: [


                  InkWell(
                    onTap: () {
                      Navigator.push(context, MaterialPageRoute(builder: (context) => HomeTime()));
                    },
                    child: Container(
                      child: Icon(Icons.app_registration,color: Color(0xff4E008A),size: 80,),

                      height: 150,
                      width: 150,
                      decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(100),
                          border: Border.all(color: Color(0xff4E008A),width: 8)
                      ),
                    ),
                  )
                ],
              ),

            ],
          )

      ),
    );
  }


}