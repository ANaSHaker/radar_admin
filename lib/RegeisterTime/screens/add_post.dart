import 'package:pubg_admin/RegeisterTime/db/PostService.dart';
import 'package:pubg_admin/RegeisterTime/models/post.dart';
import 'package:pubg_admin/RegeisterTime/screens/home.dart';
import 'package:flutter/material.dart';
import 'package:pubg_admin/RegeisterTime/models/post.dart';

class AddPost extends StatefulWidget {
  @override
  _AddPostState createState() => _AddPostState();
}

class _AddPostState extends State<AddPost> {
  final GlobalKey<FormState> formkey = new GlobalKey();
  Post post = Post(0, " ", " ","");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4E008A),
        title:Text("اضف مستخدم",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:24),),
        centerTitle: true,

        actions: [
          Image.asset("assets/logo.png",color: Colors.white,),
        ],
      ),
      body: Form(
          key: formkey,
          child: ListView(
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "اسم المستخدم او بريده الالكتروني",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (val) => post.title = val,
                  validator: (val){
                    if(val.isEmpty ){
                      return "title field cant be empty";
                    }else if(val.length > 16){
                      return "title cannot have more than 16 characters ";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "تاريخ البدء",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (val) => post.body = val,
                  validator: (val){
                    if(val.isEmpty){
                      return "body field cant be empty";
                    }
                  },
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  decoration: InputDecoration(
                      labelText: "تاريخ الانتهاء",
                      border: OutlineInputBorder()
                  ),
                  onSaved: (val) => post.body1 = val,
                  validator: (val){
                    if(val.isEmpty){
                      return "body field cant be empty";
                    }
                  },
                ),
              ),
            ],
          )),
      floatingActionButton: FloatingActionButton(onPressed: (){
        insertPost();
        Navigator.pop(context);
//        Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomePage()));
      },
        child: Icon(Icons.add, color: Colors.white,),
        backgroundColor: Colors.red,
        tooltip: "add a post",),
    );
  }

  void insertPost() {
    final FormState form = formkey.currentState;
    if(form.validate()){
      form.save();
      form.reset();
      post.date = DateTime.now().millisecondsSinceEpoch;
      PostService postService = PostService(post.toMap());
      postService.addPost();
    }
  }



}

