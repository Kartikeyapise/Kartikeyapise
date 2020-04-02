import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'app_localizations.dart';



import 'package:flutter_app/screens/app_localizations.dart';
class reagonwise extends StatefulWidget 
{
@override
reagionwiseState createState() => reagionwiseState();
}
Map<String,List<DocumentSnapshot>> documents_map = new Map<String,List<DocumentSnapshot>>();
List<String> postal_code = ['dump'];

Future<String> getDocuments() async{
  postal_code = ['dump'];  
  documents_map['dump']=[];
  print("1...getdoc");
  
  final QuerySnapshot result =
        await Firestore.instance.collection('form').getDocuments();
      final List<DocumentSnapshot> documents = result.documents;
  //var p = documents.length;
  print("2... length ");
  
  for (var i= 0;i<documents.length;i++)
  {
    print(documents[i]['postalcode']);
    print(postal_code);
    bool fg = true;
    //documents_map[documents[i]['postalcode']].add(documents[i]);
    print("axcha");
    if(postal_code!=null){
      for(var i =0 ;i<postal_code.length;i++)
      {
        if(postal_code[i]==documents[i]['postalcode'])
          fg = false;
      }
    }
    if (fg) postal_code.add(documents[i]['postalcode']);
  }
  for(var i= 0;i<postal_code.length;i++)
  {
    documents_map[postal_code[i]] =[];  
  }
  print("3...");
  return "done";

}

class reagionwiseState extends State<reagonwise>{
  final x = getDocuments();
  var item_count  = 0;
  
    
  
  @override
  Widget build(BuildContext context) {

    // TODO: implement build
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(AppLocalizations.of(context).translate("District Problems")),
        ),
      body: new ListView.builder(
        
        itemCount : postal_code.length-1,
        itemBuilder: (context,index){
          return Row(
            children: <Widget>[
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text(postal_code[index+1]),
                ],

              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  Text("View problems"),
                ],

              ),


            ],
          );
        },

      ),
    );
  }
  

}
