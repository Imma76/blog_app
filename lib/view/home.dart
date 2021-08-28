import 'package:blog_app/services/crud.dart';
import 'package:blog_app/view/read_blog.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'create_blog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  CrudMethods crudMethods = new CrudMethods();
  Stream blogStream;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    crudMethods.getData().then((result) {
      print(result);
      blogStream = result;
      setState(() {});
    });
  }

  Widget blogList() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        //padding: EdgeInsets.all(5.0),
        child: blogStream != null
            ? Column(
                children: [
                  StreamBuilder(
                    stream: blogStream,
                    builder: (context, snapshot) {
                      if (snapshot.hasData)
                        return ListView.builder(
                          shrinkWrap: true,
                          itemCount: snapshot.data.docs.length,
                          itemBuilder: (context, index) {
                            return BlogsTile(
                              onLongPressed: () => FirebaseFirestore.instance
                                  .collection('blogs')
                                  .doc(snapshot.data.docs[index].id)
                                  .delete(),
                              onTap: () => Navigator.push(context,
                                  MaterialPageRoute(builder: (context) {
                                return ReadBlog(
                                  imgUrl:
                                      snapshot.data.docs[index].get('imgUrl'),
                                  title: snapshot.data.docs[index].get('title'),
                                  body: snapshot.data.docs[index].get('desc'),
                                  authorName:
                                      snapshot.data.docs[index].get('author'),
                                  desc: snapshot.data.docs[index].get('desc'),
                                );
                              })),
                              authorName:
                                  snapshot.data.docs[index].get('author'),
                              description:
                                  snapshot.data.docs[index].get('desc'),
                              title: snapshot.data.docs[index].get('title'),
                              imgUrl: snapshot.data.docs[index].get('imgUrl'),
                            );
                          },
                        );
                      return Container();
                    },
                  )
                ],
              )
            : Container(
                child: Center(child: CircularProgressIndicator()),
              ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Flutter',
              style: TextStyle(
                fontSize: 22,
              ),
            ),
            Text(
              'Blog',
              style: TextStyle(fontSize: 22, color: Colors.blue),
            )
          ],
        ),
        backgroundColor: Colors.transparent,
        elevation: 0.0,
      ),
      body: blogList(),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CreateBlog()));
        },
      ),
      backgroundColor: Color(0xff19151D),
    );
  }
}

class BlogsTile extends StatelessWidget {
  BlogsTile(
      {@required this.authorName,
      @required this.description,
      this.onLongPressed,
      this.imgUrl,
      this.onTap,
      @required this.title});
  String imgUrl, title, description, authorName;
  final Function onTap, onLongPressed;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.94,
          child: GestureDetector(
            onTap: onTap,
            onLongPress: onLongPressed,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0),
              ),
              color: Colors.white12,
              elevation: 10,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Padding(
                      padding: const EdgeInsets.all(2.0),
                      child: ConstrainedBox(
                        constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.28,
                          maxHeight: MediaQuery.of(context).size.width * 0.28,
                        ),
                        child: ClipRRect(
                            borderRadius: BorderRadius.circular(10.0),
                            child: Image.network(imgUrl,
                                fit: BoxFit.cover, width: 90)),
                      )),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(10, 10, 0, 0),
                          child: Text(
                            title,
                            style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 18,
                                color: Colors.white),
                          ),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width * 0.5,
                        child: Padding(
                          padding: const EdgeInsets.fromLTRB(5, 10, 0, 0),
                          child: Text(
                            description,
                            style: TextStyle(fontSize: 12, color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                  // Column(
                  //   children: <Widget>[
                  //     Padding(
                  //       padding: const EdgeInsets.fromLTRB(5, 40, 0, 0),
                  //       child: Text(
                  //         '\$ 24.00',
                  //         style: TextStyle(
                  //           fontSize: 14,
                  //         ),
                  //       ),
                  //     ),
                  //   ],
                  // ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
