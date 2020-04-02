import 'dart:io';
import 'package:chewie/chewie.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'dart:async';
import 'package:fluttertoast/fluttertoast.dart';
import 'app_localizations.dart';


class LandingScreen extends StatefulWidget 
{
@override
_LandingScreenState createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>{

  File imageFile;
  File videoFile;
  SharedPreferences prefs;
  TextEditingController controllerNickname;
  TextEditingController _problem = TextEditingController();
  bool isLoading = false;

  _record(BuildContext context)async{
    Navigator.of(context).pop();
    File theVid = await ImagePicker.pickVideo(
      source: ImageSource.camera
    );

    if(theVid !=null){
      setState((){
        videoFile = theVid;
      });
    }
  }

    _playVideo(BuildContext context) async{
      Navigator.of(context).pop();
    File theVid = await ImagePicker.pickVideo(
      source: ImageSource.gallery
     );

     if(theVid !=null){
       setState((){
         videoFile = theVid;
       });
     }
  }



  _openGallery(BuildContext context)async{
    var image = await ImagePicker.pickImage(source: ImageSource.gallery);
    this.setState(() {
      imageFile = image;
      print('Image Path $imageFile');
      //isLoading = true;
    });
    Navigator.of(context).pop();
  }
  
  _openCamera(BuildContext context)async{
    var picture = await ImagePicker.pickImage(source: ImageSource.camera);
    this.setState(() {
      imageFile = picture;
      //isLoading = true;
    });
    Navigator.of(context).pop();
  }

  Future<void> _showChoiceDialog(BuildContext context){
    return showDialog(context: context,builder: (BuildContext context){
        return AlertDialog(
          title: Text(AppLocalizations.of(context).translate("make a choice")),
          content: SingleChildScrollView(
            child: ListBody(children: <Widget>[
              GestureDetector(
                child: Text(AppLocalizations.of(context).translate("gallery")),
                onTap: (){
                  _openGallery(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0),),

              GestureDetector(
                child: Text(AppLocalizations.of(context).translate("camera")),
                onTap: (){
                  _openCamera(context);
                },
              )
            ],),
          )
        ) ;   
    });
  }

  Future<void> _showChoiceDialogVideo(BuildContext context){
    return showDialog(context: context,builder: (BuildContext context){
        return AlertDialog(
          title: Text(AppLocalizations.of(context).translate("make a choice")),
          content: SingleChildScrollView(
            child: ListBody(children: <Widget>[
              GestureDetector(
                child: Text(AppLocalizations.of(context).translate("gallery")),
                onTap: (){
                  _playVideo(context);
                },
              ),
              Padding(padding: EdgeInsets.all(8.0),),

              GestureDetector(
                child: Text(AppLocalizations.of(context).translate("camera")),
                onTap: (){
                  _record(context);
                },
              )
            ],),
          )
        ) ;   
    });
  }

Widget _decideImage(BuildContext context){
  if(imageFile == null){
    return Center(
      child: Text(AppLocalizations.of(context).translate("No image selected")),
    );
    
  }else
{
  return  Image.file(imageFile,width:100,height:100);
  } 
}

  

  uploadPic(BuildContext context) async {
    print("inside upload");
    String fileName = basename(imageFile.path);
    print("1..");
    String filename1 = basename(videoFile.path);
    print("2..");
    StorageReference reference = FirebaseStorage.instance.ref().child(fileName);
    print("3.. $reference");
    StorageReference ref = FirebaseStorage.instance.ref().child(filename1);
    print("4...$ref");
    StorageUploadTask uploadTask = reference.putFile(imageFile);
    print("5...$uploadTask");
    StorageUploadTask uploadTask1 = ref.putFile(videoFile, StorageMetadata(contentType: 'video/mp4'));
    print("6...$uploadTask1");
    StorageTaskSnapshot downloadUrl = (await uploadTask.onComplete);
    print("7...$downloadUrl");
    String url = (await downloadUrl.ref.getDownloadURL());
    print("8...$url");

    StorageTaskSnapshot downloadUrl1 = (await uploadTask1.onComplete);
    print("9...$downloadUrl1");
    String url1 = (await downloadUrl1.ref.getDownloadURL());

    prefs = await SharedPreferences.getInstance();
    String _phone = prefs.getString('phone') ;
    print(_phone);
    print(prefs.getString('postalcode'));
    final QuerySnapshot result =
        await Firestore.instance.collection('form').where('phone', isEqualTo: _phone).getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
    if (documents.length!=0){
    Firestore.instance.collection('form').document(_phone).updateData({
          'Name': prefs.getString('name'),
          'FatherName' : prefs.getString('fathername'),
          'AdharNumber' : prefs.getString('adharnumber'),
          'postalcode' : prefs.getString('postalcode'),
          'photoUrl': url,
          'videoUrl': url1,
          'problemText': _problem.text,
          'createdAt': DateTime.now().toString(),
        });
    }
    else 
    {
      Firestore.instance.runTransaction((transaction) async {
          await transaction.set(Firestore.instance.collection("form").document(_phone), {
            'Name': prefs.getString('name'),
            'FatherName' : prefs.getString('fathername'),
            'AdharNumber' : prefs.getString('adharnumber'),
            'postalcode' : prefs.getString('postalcode'),
            'photourl': url,
            'problemText': _problem.text,
            'videourl': url1,
            'createdAt': DateTime.now().toString(),
          });
        });
    }
    
          print(url);
          //print(url1);
          print(_phone);
          print("Profile Picture uploaded");
          print("Profile video uploaded");
          Fluttertoast.showToast(msg: AppLocalizations.of(context).translate("Upload successful"));
          //Scaffold.of(context).showSnackBar(SnackBar(content: Text('Profile Picture Uploaded')));
      

}

loading() 
{
  if (isLoading ){
                  Center(
                    child: CircularProgressIndicator(),
                  );
  }
}
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate("Form data")),
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
                            videoPlayerController: VideoPlayerController.file(videoFile),
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
                   child: RaisedButton(onPressed: (){
                      _showChoiceDialogVideo(context);
                    },child: Text(AppLocalizations.of(context).translate("Capture Video")),
                    color: Colors.blue,
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
                        Builder(
                        builder: (context) =>  Container(
                          width: 250,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child:  _decideImage(context),
                          ),
                        ),
                        ),  
                      ],)
                ),
              ),
            ),
          ),
        
          Padding(
            padding: const EdgeInsets.all(16.0),
                   child: RaisedButton(onPressed: (){
                      _showChoiceDialog(context);
                    },child: Text(AppLocalizations.of(context).translate("Select Image")),
                    color: Colors.blue,
                    ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
                   child:
                    RaisedButton(onPressed: (){
                      //loading();
                      setState(() {
                        isLoading = true;
                      });
                      uploadPic(context);
                      setState(() {
                        isLoading =false;
                      });
                      //Fluttertoast.showToast(msg: "Upload success");
                      //Navigator.pop(context);
                    },child: Text(AppLocalizations.of(context).translate("Upload")),
                    color: Colors.blue,
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
                            //child: myDetailsContainer1(),
                          ),
                        ),

                      
                      ],)
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:  new TextField(
                    controller: _problem ,
                    keyboardType: TextInputType.multiline,
                    maxLines: null,
                    decoration: const InputDecoration(
                      icon: const Icon(Icons.message),
                      hintText: "Enter your problem",
                      labelText: "Problem",
                    ),
                  ),
            ),
          
        ],
      ),
    );
}
}