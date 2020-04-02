import 'package:flutter/material.dart';
import 'package:flutter_app/screens/AppLanguage.dart';
import 'package:flutter_app/screens/app_localizations.dart';
import 'package:provider/provider.dart';

class AppLang extends StatefulWidget {
  @override
  _AppLangState createState() => _AppLangState();
}

class _AppLangState extends State<AppLang> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(AppLocalizations.of(context).translate('first_string')),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            Text(
              AppLocalizations.of(context).translate('second_string'),
              style: TextStyle(fontSize: 32),
            ),
            Padding(
              padding: EdgeInsets.only(top: 20.0, left: 10.0, right: 10),
              child: TextField(
                onChanged: (value) {
                  debugPrint('Something changed in name field');
                },
                decoration: InputDecoration(
                    labelText:
                        AppLocalizations.of(context).translate("first_string"),
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0))),
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
                    Provider.of<AppLanguage>(context, listen: false)
                        .changeLanguage(Locale("hi"));
                  },
                  child: Text('hindi'),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
