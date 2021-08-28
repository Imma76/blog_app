import 'package:blog_app/services/crud.dart';
import 'package:flutter/material.dart';

import 'create_blog.dart';

class LandingPage extends StatefulWidget {
  @override
  _LandingPageState createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  @override
  bool done = false;
  Stream blogData;
  CrudMethods _crudMethods = CrudMethods();
  void initState() {
    // TODO: implement initState
    super.initState();
    _crudMethods.getData().then((result) {
      setState(() {
        blogData = result;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
      ),
      drawer: Drawer(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              height: MediaQuery.of(context).size.height / 4,
              // color: topDrawerColor,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    child: ClipRRect(
                      //   child: Image.asset('images/profile.jpeg'),
                      borderRadius: BorderRadius.circular(30.0),
                    ),
                    backgroundColor: Color(0xFF556080),
                    radius: 30,
                  ),
                  SizedBox(
                    height: 8,
                  ),
                  Text(
                    'Emmanuel John',
                  ),
                  SizedBox(
                    height: 8,
                  ),
                ],
              ),
            ),
            Container(
              color: Color(0xFFfafafa),
              child: Padding(
                padding: const EdgeInsets.only(right: 30, left: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 140),
                      child: Text(
                        'Primary Currency',
                        style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.w100,
                            color: Color(0xFF918d8d)),
                      ),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    ListTile(
                      onTap: () {
                        Navigator.push(context,
                            MaterialPageRoute(builder: (context) {
                          return CreateBlog();
                        }));
                      },
                      // leading: FaIcon(FontAwesomeIcons.questionCircle),
                      title: Text('Add new products'),
                    ),
                    ListTile(
                      //    leading: FaIcon(FontAwesomeIcons.infoCircle),
                      title: Text('About Miraweb'),
                    ),
                    ListTile(
                      //  leading: FaIcon(FontAwesomeIcons.signOutAlt),
                      title: Text('Sign Out'),
                    ),
                    Divider(
                      height: 50,
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
      //  backgroundColor: Colors.white30,
      body: Container(
          child: StreamBuilder(
        stream: blogData,
        builder: (context, snapshot) {
          return ListView.builder(
            itemCount: snapshot.data.docs.length,
            shrinkWrap: true,
            itemBuilder: (context, index) {
              return Items(
                productName: snapshot.data.docs[index].get('userName'),
                image: snapshot.data.docs[index].get('imgUrl'),
              );
            },
          );
        },
      )),
    );
  }
}

class Items extends StatelessWidget {
  final image;
  final productName;
  Items({this.image, this.productName});
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: 50.0,
          height: 50.0,
          child: Column(
            children: [
              Image.network(image),
              Text(productName),
            ],
          ),
        ),
      ],
    );
  }
}
