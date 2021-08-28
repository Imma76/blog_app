import 'package:flutter/material.dart';

class ReadBlog extends StatelessWidget {
  ReadBlog({this.imgUrl, this.title, this.body, this.desc, this.authorName});
  final imgUrl, title, body, authorName, desc;
  // const ReadBlog({ Key? key }) : supe//r(key: key);

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height;
    return Scaffold(
        body: Stack(
      children: [
        Container(
            height: height / 2.7,
            child: Image.network(
              imgUrl,
              width: double.infinity,
              fit: BoxFit.cover,
            )),
        Column(
          children: [
            SizedBox(
              height: height / 3,
            ),
            Expanded(
              flex: 2,
              child: Container(
                  padding: EdgeInsets.all(12.0),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: Color(0xff19151D),
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(30.0),
                        topRight: Radius.circular(30.0),
                      )),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(height: 20.0),
                        Text(title,
                            textAlign: TextAlign.left,
                            style: TextStyle(
                                fontSize: 30,
                                fontWeight: FontWeight.bold,
                                color: Colors.white)),
                        ListTile(
                            leading: CircleAvatar(child: Image.network(imgUrl)),
                            title: Text(
                              authorName,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                            subtitle: Text(
                              '4 mins read',
                              style: TextStyle(color: Colors.white),
                            )),
                        SizedBox(height: 10.0),
                        Text(
                          desc,
                          style: TextStyle(color: Colors.white),
                        ),
                      ],
                    ),
                  )),
            ),
          ],
        )
      ],
    ));
  }
}
