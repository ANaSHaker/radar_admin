
import 'package:flutter/material.dart';
import 'package:pubg_admin/news/models/post.dart';
import '../db/PostService.dart';
import 'package:timeago/timeago.dart' as timeago;

import 'edit_post.dart';

class PostView extends StatefulWidget {
  final Post post;

  PostView(this.post);

  @override
  _PostViewState createState() => _PostViewState();
}

class _PostViewState extends State<PostView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.post.title),
        backgroundColor: Color(0xff4E008A),
        centerTitle: true,

        actions: [

        ],

      ),
      body: Column(
        children: <Widget>[
         Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[

              IconButton(icon: Icon(Icons.delete),
              onPressed: (){
                PostService postService = PostService(widget.post.toMap());
                postService.deletePost();
                Navigator.pop(context);

              },),
              IconButton(icon: Icon(Icons.edit),
                onPressed: (){
                  Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => EditPost(widget.post)));
                },),
            ],
          ),
          Divider(),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              height: 80,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                  color:  Color(0xff4E008A),
                  borderRadius: BorderRadius.circular(20)
              ),
              child:  Text(
                widget.post.body,
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 14.0, fontWeight: FontWeight.bold),
                textAlign: TextAlign.center,),
            ),
          ),

        ],
      ),
    );
  }
}
