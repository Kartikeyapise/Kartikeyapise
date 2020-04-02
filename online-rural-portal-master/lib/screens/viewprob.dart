
import 'package:flutter/material.dart';

import 'package:chewie/chewie.dart';

import 'package:video_player/video_player.dart';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';



class MyApp2 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Form Demo',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Flutter Form Demo'),
    );
  }
}

String image = '';
String videoFile ='';
String problem = '';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => new _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
 


  final _phone = TextEditingController();

  SharedPreferences prefs;
  
  
  onsubmit() async {
   
    
    print(_phone.text);
    final QuerySnapshot result =
        await Firestore.instance.collection('form').where('phone', isEqualTo: _phone.text).getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
      setState(() {
        
        image = documents[0]['photourl'];
        print(image);
        videoFile = documents[0]['videourl'];
        print(videoFile);
        problem = documents[0]['problemText'];
        print('Hello');
        print(problem);
        print(image);

      });  
   print('AMAN');   
   print(image);
}


  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: new SafeArea(
          top: false,
          bottom: false,
          child: new Form(
              key: _formKey,
              autovalidate: true,
              child: new ListView(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                children: <Widget>[
                  
                
                  new TextFormField(
                    controller: _phone ,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.phone),
                      hintText: 'Enter your phone number',
                      labelText: 'Phone',
                    ),
                    /*onChanged: (value) {
                          //phone1 = value ;
                          //phone = phone1.toString();
                          //phone = value;
                        },*/
                  ),
            
                  new Container(
                      padding: const EdgeInsets.only(left: 40.0, top: 20.0),
                      child: new RaisedButton(
                        child: const Text('Submit'),
                         onPressed: (){
                           onsubmit();
                           Navigator.push(
                                context,
                                MaterialPageRoute(builder: (context) => LoadFirbaseStorageImage ()),
                            );
                         }
                      )),
                ],
              ))),
    );
  }

}


class Mgs extends StatefulWidget {
  @override
  _MgsState createState() =>
      _MgsState();
}

class _MgsState extends State<Mgs> {
  @override
  Widget build(BuildContext context)
  {
     return new Scaffold(
       appBar: AppBar(
        centerTitle: true,
        title: Text("Your Pic"),
        ),
        body: new Image.network(
          image,
          //"https://cdn.pixabay.com/photo/2017/02/21/21/13/unicorn-2087450_1280.png",
          fit: BoxFit.cover,
          height: double.infinity,
          width: double.infinity,
          alignment: Alignment.center,
        ),
      );
  }
}

class LoadFirbaseStorageImage extends StatefulWidget {
  @override
  _LoadFirbaseStorageImageState createState() =>
      _LoadFirbaseStorageImageState();
}

class _LoadFirbaseStorageImageState extends State<LoadFirbaseStorageImage> {

  //String image = '';
  SharedPreferences prefs;
  String _phone = '';
  VideoPlayerController _controller;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    _controller = VideoPlayerController.network(
      videoFile,
      //'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    );
    _initializeVideoPlayerFuture = _controller.initialize();

    _controller.setLooping(true);

    super.initState();
  }

  @override
  void dispose() {
    _controller.dispose();

    super.dispose();
  }


 Widget _decideImage(){
  
   print(image);
   if(image == ''){
     return Center(
       child: Text("No Image Selected"),
     );
     
   }else
   {
     print(image);
   return  Image.network(image,width:100,height:100);
   } 
 }

   @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Your Problems"),
        ),
      body :ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
            Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: new FittedBox(
                child: Material(
                    color: Colors.blueGrey,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(24.0),
                    shadowColor: Colors.blue,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                       Container(
                      color: Colors.brown,
                      height: MediaQuery.of(context).size.height*(30/100),
                      width: MediaQuery.of(context).size.width*(100/100),
                      child: videoFile == null?Center(
                        child: Icon(Icons.videocam,color: Colors.blue,size: 50.0,),
                      ):FittedBox(
                        fit: BoxFit.contain,
                        child: mounted?Chewie(
                          controller: ChewieController(
                            videoPlayerController: _controller,
                            aspectRatio: 3/2,
                            autoPlay: true,
                            //looping:true,
                  ),
                ):Container(),
              )
             ),
                      ],)
                ),
              ),
            ),
               
          ),

          Padding(
            padding: const EdgeInsets.all(16.0),
            child: new InkWell(
                onTap: () {
                  Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => Mgs()),
                  );
                   /*Image.network(
                      image,
                      fit: BoxFit.cover,
                      height: double.infinity,
                      width: double.infinity,
                      alignment: Alignment.center,
                    );*/
                },
            child: Container(
              child: new FittedBox(
                child: Material(
                    color: Colors.white,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(24.0),
                    shadowColor: Color(0x802196F3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Builder(
                        builder: (context) =>  Container(
                          width: 250,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child:  _decideImage(),
                          ),
                        ),
                        ),  
                      ],)
                ),
              ),
            ),
            ),
          ),
          
         
                  
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Container(
              child: new FittedBox(
                child: Material(
                    color: Colors.white,
                    elevation: 14.0,
                    borderRadius: BorderRadius.circular(24.0),
                    shadowColor: Color(0x802196F3),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Container(
                          width: 250,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Text(problem,
                            style: TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)
                            ),
                          ),
                        ),

                      
                      ],)
                ),
              ),
            ),
          )

        ],
      ),
    );
}

}
