import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:flutter_app/screens/AppLanguage.dart';
import 'package:flutter_app/screens/form2.dart';

class InputForm extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return InputFormState();
  }
}

class InputFormState extends State<InputForm> {
  Geolocator geolocator = Geolocator();
  Position userLocation;
  String postalcode ;
  TextEditingController nameController = TextEditingController(text: 'xyz');
  TextEditingController pincodeController= TextEditingController();
  TextEditingController numberController =
      TextEditingController(text: '8264959487');
  TextEditingController fathernameController =
      TextEditingController(text: 'xyz');
  TextEditingController adharnumberController =
      TextEditingController(text: '33xxx');
  bool validate_name = false;
  bool validate_fatherName = false;
  bool validate_number = false;
  bool validate_adharnumber = false;
  bool validate_pc = true;
  Locale locale;
  SharedPreferences prefs;
 /*  addStringToSF(phone) async {
  print(phone);
  prefs = await SharedPreferences.getInstance();
  prefs.setString('stringValue', phone);
  } */
  Future<String> _getLocation() async {
    print("1..Inside location fn");
    Position currentLocation;
    try {
      currentLocation = await geolocator.getCurrentPosition(
          desiredAccuracy: LocationAccuracy.best);
    } catch (e) {
      print(e);
      print("error");
      currentLocation = null;
    }
    print("2...$currentLocation");
    List<Placemark> placemark = await Geolocator().placemarkFromPosition(currentLocation);
    print(placemark);
    print(placemark[0].postalCode);
    return placemark[0].postalCode.toString();
  }
  storeData(BuildContext context) async{
    print("inside data");
    prefs = await SharedPreferences.getInstance();
    validate_number ? print("no nmb") :prefs.setString('phone', numberController.text);
    validate_name ? print("no name") : prefs.setString('name', nameController.text);
    validate_fatherName ? print("no nmb"):prefs.setString('fathername', fathernameController.text);
    validate_adharnumber ? print("no adnb"): prefs.setString('adharnumber', adharnumberController.text);
    print(pincodeController.text);
    prefs.setString('postalcode', pincodeController.text);
  }
  @override
  Widget build(BuildContext context) {
    TextStyle textStyle = Theme.of(context).textTheme.title;

    return Scaffold(
      appBar: AppBar(title: Text('Form')),
      body: Padding(
        padding: EdgeInsets.only(top: 15.0, left: 10.0, right: 10.0),
        child: ListView(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10),
              child: TextField(
                controller: nameController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Something changed in name field');
                  setState(() {
                    nameController.text.isEmpty
                        ? validate_name = true
                        : validate_name = false;
                  });
                  
                },
                decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context).translate("name"),
                    labelStyle: textStyle,
                    errorText: validate_name ? 'Value can\'nt be empty' : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10),
              child: TextField(
                controller: fathernameController,
                style: textStyle,
                onChanged: (value) {
                  debugPrint('Something changed in number field');
                  setState(() {
                    fathernameController.text.isEmpty
                        ? validate_fatherName = true
                        : validate_fatherName = false;
                  });
                },
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).translate("father's name"),
                    labelStyle: textStyle,
                    errorText:
                        validate_fatherName ? 'Value can\'nt be empty' : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10),
              child: TextField(
                controller: numberController,
                style: textStyle,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  debugPrint('Something changed in number field');
                  setState(() {
                    numberController.text.isEmpty
                        ? validate_number = true
                        : validate_number = false;
                  });
                /* if (numberController.text.isNotEmpty) {
                  
                  addStringToSF(numberController.text);
                } */
                },
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).translate("Mobile Number"),
                    labelStyle: textStyle,
                    errorText:
                        validate_number ? 'Value can\'nt be empty' : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10),
              child: TextField(
                controller: numberController,
                style: textStyle,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  debugPrint('Something changed in number field');
                },
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).translate("Mobile Number2"),
                    labelStyle: textStyle,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10),
              child: TextField(
                controller: adharnumberController,
                style: textStyle,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  debugPrint('Something changed in discription field');
                  setState(() {
                    adharnumberController.text.isEmpty
                        ? validate_adharnumber = true
                        : validate_adharnumber = false;
                  });
                },
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).translate("Adhar Number"),
                    labelStyle: textStyle,
                    errorText:
                        validate_adharnumber ? 'Value can\'nt be empty' : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10),
              child: TextField(
                controller: pincodeController,
                style: textStyle,
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  debugPrint('Something changed in pincode');
                  setState(() {
                      pincodeController.text.isEmpty
                        ? validate_pc = true
                        : validate_pc = false;
                  });
                },
                decoration: InputDecoration(
                    labelText: AppLocalizations.of(context).translate("Pincode"),
                    labelStyle: textStyle,
                    
                    errorText:
                        validate_pc ? 'Value can\'nt be empty' : null,
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
              ),
            ),
            Padding(
              padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Submit',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        _getLocation().then((value) {
                          print("##$value");
                        setState(() {
                          postalcode = value;
                        });
                        });
                        storeData(context);
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => LandingScreen()),
                        );
                        
                      },
                    ),
                  ),
                  Container(width: 5.0),
                  Expanded(
                    child: RaisedButton(
                      color: Theme.of(context).primaryColorDark,
                      textColor: Theme.of(context).primaryColorLight,
                      child: Text(
                        'Back',
                        textScaleFactor: 1.5,
                      ),
                      onPressed: () {
                        setState(() {
                          debugPrint("Back button pressed");
                        });
                      },
                    ),
                  ),
                ],
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
      ),
    );
  }
}
