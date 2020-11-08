import 'package:pubg_admin/RegeisterTime/models/post.dart';
import 'package:flutter/material.dart';
import 'add_post.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:pubg_admin/RegeisterTime/screens/viewPost.dart';
import 'package:timeago/timeago.dart' as timeago;

class HomeTime extends StatefulWidget {
  @override
  _HomeTimeState createState() => _HomeTimeState();
}

class _HomeTimeState extends State<HomeTime> {
  FirebaseDatabase _database = FirebaseDatabase.instance;
  String nodeName = "regeisterTime";
  List<Post> postsList = <Post>[];


  @override
  void initState() {
    _database.reference().child(nodeName).onChildAdded.listen(_childAdded);
    _database.reference().child(nodeName).onChildRemoved.listen(_childRemoves);
    _database.reference().child(nodeName).onChildChanged.listen(_childChanged);


  }

  @override
  Widget build(BuildContext context) {
    return  Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff4E008A),
        title:Text("المستخدمين",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,fontSize:24),),
        centerTitle: true,
        actions: [
          Image.asset("assets/logo.png",color: Colors.white,),
        ],

      ),

      body: Container(
        color: Color(0xffCBBFD5),
        child: ListView(
          children: <Widget>[
            Visibility(
              visible: postsList.isEmpty,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.only(top:300.0),
                  child: Container(
                    alignment: Alignment.center,
                    child: Text("لا مستخدمين بعد",style: TextStyle(fontSize: 20),)
                  ),
                ),
              ),
            ),

            Visibility(
              visible: postsList.isNotEmpty,
              child: Container(
                height:750,
                child: Column(
                children: [
                  Flexible(
                      child: FirebaseAnimatedList(
                          query: _database.reference().child('regeisterTime'),
                          itemBuilder: (_, DataSnapshot snap, Animation<double> animation, int index){
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: InkWell(
                                onTap: (){
                                  Navigator.push(context, MaterialPageRoute(builder: (context) => PostView(postsList[index])));

                                },
                                child: Container(
                                  height: 120,
                                  child: Card(
                                      child: Row(
                                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                        children: [
                                          Column(
                                            children: [
                                              Text("اسم المستخدم"),
                                              SizedBox(height: 20,),
                                              Text(
                                                postsList[index].title,
                                                style: TextStyle(
                                                    fontSize: 22.0, fontWeight: FontWeight.bold),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("تاريخ البدء"),
                                              SizedBox(height: 20,),

                                              Text(
                                                postsList[index].body,
                                                style: TextStyle(fontSize: 18.0),
                                              ),
                                            ],
                                          ),
                                          Column(
                                            children: [
                                              Text("تاريخ الانتهاء"),
                                              SizedBox(height: 20,),

                                              Text(postsList[index].body1, style: TextStyle(fontSize: 18.0),),

                                            ],
                                          )
                                        ],
                                      )
                                  ),
                                ),
                              ),
                            );
                          })),
                ],
              ),
            )
            )],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => AddPost()));
        },
        child: Icon(
          Icons.edit,
          color: Colors.white,
        ),
        backgroundColor: Colors.red,
        tooltip: "add a post",
      ),
    );
  }

   _childAdded(Event event) {
    setState(() {
      postsList.add(Post.fromSnapshot(event.snapshot));
    });
  }

  void _childRemoves(Event event) {
    var deletedPost = postsList.singleWhere((post){
      return post.key == event.snapshot.key;
    });

    setState(() {
      postsList.removeAt(postsList.indexOf(deletedPost));
    });
  }

  void _childChanged(Event event) {
    var changedPost = postsList.singleWhere((post){
      return post.key == event.snapshot.key;
    });

    setState(() {
      postsList[postsList.indexOf(changedPost)] = Post.fromSnapshot(event.snapshot);
    });
  }
}
