import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import 'package:flutter_app/screens/input_form.dart';
import 'package:flutter_app/screens/viewprob.dart';
import 'package:flutter_app/screens/reasonwise.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_app/screens/awareness.dart';
import 'screens/AppLanguage.dart';
import 'screens/app_localizations.dart';
import 'package:provider/provider.dart';

//import 'form2.dart';


void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  AppLanguage appLanguage = AppLanguage();
  await appLanguage.fetchLocale();
  runApp(FirstRoute(appLanguage:appLanguage,));
}

class FirstRoute extends StatelessWidget {
  final AppLanguage appLanguage;

  FirstRoute({this.appLanguage});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AppLanguage>(
      create: (_) => appLanguage,
      child: Consumer<AppLanguage>(builder: (context, model, child) {
        return MaterialApp(
          title: 'FlutterDemo',
          
          locale: model.appLocal,
          supportedLocales: [
            Locale('en', ''),
            Locale('hi', ''),
          ],
          localizationsDelegates: [
            AppLocalizations.delegate,
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
          ],
          home: HomeScreen(),
        );
      }),
    );
  }
}


class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: AppBar(title: Text("Welcome"),),
      body: ListView(
        scrollDirection: Axis.vertical,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(16.0),
            child:new InkWell(
                onTap: () {
                Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => InputForm()),
                  );
                },
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
                          width: 250,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Center(
                              child:Text(AppLocalizations.of(context).translate("Register your problem"),
                              style: TextStyle(color: Colors.deepPurple),
                            ),
                            )
                            //child: myDetailsContainer1(),
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
            child:new InkWell(
                onTap: () {
                Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => MyApp2()),
                  );
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
                        Container(
                          width: 250,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Center(
                              child:Text(AppLocalizations.of(context).translate("View your problem"),
                              style: TextStyle(color: Colors.deepPurple),
                            ),
                            )
                            //child: myDetailsContainer1(),
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
            child:new InkWell(
                onTap: () {
                Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => MyApp3()),
                  );
                },
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
                          width: 250,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Center(
                              child:Text(AppLocalizations.of(context).translate("District Problems"),
                              style: TextStyle(color: Colors.deepPurple),
                            ),
                            )
                            //child: myDetailsContainer1(),
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
            child:new InkWell(
                onTap: () {
                Navigator.push(
                 context,
                 MaterialPageRoute(builder: (context) => Home()),
                  );
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
                        Container(
                          width: 250,
                          height: 100,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 16.0),
                            child: Center(
                              child:Text(AppLocalizations.of(context).translate("General Awareness"),
                              style: TextStyle(color: Colors.deepPurple),
                            ),
                            )
                            //child: myDetailsContainer1(),
                          ),
                          
                        ),
                      
                      ],)
                ),
              ),
            ),
          ),
          ),
          Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                RaisedButton(
                  onPressed: () {
                    Provider.of<AppLanguage>(context, listen: false)
                        .changeLanguage(Locale("en"));
                  },
                  child: Text('English'),
                ),
                RaisedButton(
                  onPressed: () {
                    debugPrint('hindi');
                    Provider.of<AppLanguage>(context, listen: false)
                        .changeLanguage(Locale("hi"));
                  },
                  child: Text('हिंदी'),
                )
              ],
            ),


        ],
      ),
    );
  }
}

