

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

//void main() => runApp(MyApp());

class MyApp3 extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase Storage Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: LoadFirbaseStorageImage(),
    );
  }
}

final Color yellow = Color(0xfffbc31b);
final Color orange = Color(0xfffb6900);
//final String image1 = "images/broccoli.jpg";
//final String image2 = "images/carrots.jpg";

//String image = image1;

class LoadFirbaseStorageImage extends StatefulWidget {
  @override
  _LoadFirbaseStorageImageState createState() =>
      _LoadFirbaseStorageImageState();
}

class _LoadFirbaseStorageImageState extends State<LoadFirbaseStorageImage> {

  String image = '';
  SharedPreferences prefs;
  String _phone = '';
 
  

   _getImage() async {
    
     prefs = await SharedPreferences.getInstance();
    _phone = prefs.getString('phone') ;
    final QuerySnapshot result =
        await Firestore.instance.collection('form').where('phone', isEqualTo: _phone).getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      setState(() {
        image = documents[0]['photoUrl'];
      });
     
     //fit: BoxFit.scaleDown,
  }

 Widget _decideImage(){
   if(image == ''){
     return Center(
       child: Text("No Image Selected"),
     );
     
   }else
   {
   return  Image.network(image,width:100,height:100);
   } 
 }

@override
  Widget build(BuildContext context) {
    return new Scaffold(
    appBar: new AppBar(
      title: new Text("All problems Region wise"),
      centerTitle: true,
    ),
    
    body: new StreamBuilder<QuerySnapshot>(
      stream: Firestore.instance.collection("form").orderBy('postalcode').snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (!snapshot.hasData) return const Text('Connecting...');
        final int cardLength = snapshot.data.documents.length;
        return ListView.builder(
          padding: EdgeInsets.all(10.0),
          itemBuilder: (context, index) => buildItem(context, snapshot.data.documents[index]),
          itemCount: snapshot.data.documents.length,
        ); 
      },
    ),
    );
  }

}




  Widget fullimg(BuildContext context,DocumentSnapshot document)
  {
     return new Scaffold(
       appBar: AppBar(
        centerTitle: true,
        title: Text("Your Pic of problem "),
        ),
        body: document['photoUrl'] != null
                    ? CachedNetworkImage(
                        placeholder: (context, url) => Container(
                          child: CircularProgressIndicator(
                            strokeWidth: 1.0,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.purpleAccent),
                          ),
                          height: double.infinity,
                        width: double.infinity,
                          padding: EdgeInsets.all(15.0),
                        ),
                        imageUrl: document['photoUrl'],
                        width: double.infinity,
                        height: double.infinity,
                        fit: BoxFit.cover,
                        
                        alignment: Alignment.center,
                      )
                    : Icon(
                        Icons.account_circle,
                        size: 50.0,
                        color: Colors.grey,
                      ),
      
      );
  }


Widget buildItem(BuildContext context, DocumentSnapshot document) {
      return Container(
        child: FlatButton(
          child: Row(
            children: <Widget>[
              Material(
                child: new InkWell(
                onTap: () {
                  Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => fullimg(context  ,document)),
                  );
                },
                child: document['photoUrl'] != null
                    ? CachedNetworkImage(
                        placeholder: (context, url) => Container(
                          child: CircularProgressIndicator(
                            strokeWidth: 1.0,
                            valueColor: AlwaysStoppedAnimation<Color>(Colors.purpleAccent),
                          ),
                          width: 50.0,
                          height: 50.0,
                          padding: EdgeInsets.all(15.0),
                        ),
                        imageUrl: document['photoUrl'],
                        width: 50.0,
                        height: 50.0,
                        fit: BoxFit.cover,
                      )
                    : Icon(
                        Icons.account_circle,
                        size: 50.0,
                        color: Colors.grey,
                      ),
                borderRadius: BorderRadius.all(Radius.circular(25.0)),
                ),
                clipBehavior: Clip.hardEdge,
              ),
              Flexible(
                child: Container(
                  child: Column(
                    children: <Widget>[
                      Container(
                        child: Text(
                          'Postalcode : ${document['postalcode']}',
                          style: TextStyle(color: Colors.grey),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                      Container(
                        child: Text(
                          'Name: ${document['Name']}',
                          style: TextStyle(color: Colors.grey),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                      Container(
                        child: Text(
                          'Problems: ${document['problem_text']}',
                          style: TextStyle(color: Colors.grey),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 5.0),
                      ),
                      Container(
                        child: Text(
                          'Phone no.: ${document['phone'] ?? 'Not available'}',
                          style: TextStyle(color: Colors.grey),
                        ),
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.fromLTRB(10.0, 0.0, 0.0, 0.0),
                      )
                    ],
                  ),
                  margin: EdgeInsets.only(left: 20.0),
                ),
              ),
            ],
          ),
         
          color: Colors.lightBlue,
          padding: EdgeInsets.fromLTRB(25.0, 10.0, 25.0, 10.0),
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
        ),
        margin: EdgeInsets.only(bottom: 10.0, left: 5.0, right: 5.0),
      );
    
}