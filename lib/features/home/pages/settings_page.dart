import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:films_viewer/app/other/data.dart';

class SettingsArguments {
  const SettingsArguments(this.name);
  final String name;
}

// ignore: must_be_immutable
class SettingsPage extends StatefulWidget {
  SettingsPage({required this.arguments, Key? key}) : super(key: key);
  late SettingsArguments arguments;
  static const String routeName = '/settings';
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  late bool isChecked;
  late Language? _language;
  @override
  void initState() {
    isChecked = false;
    _language = Language.english;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
      ),
      body: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
        ListView.builder(
          shrinkWrap: true,
          itemCount: Language.values.length,
          itemBuilder: (context, index) => ListTile(
            title: Text(Language.values[index].toPrettyString()),
            leading: Radio<Language>(
              value: Language.values[index],
              groupValue: _language,
              onChanged: (Language? value) {
                setState(() {
                  _language = value;
                });
              },
            ),
          ),
        ),
        CheckboxListTile(
          checkColor: Colors.white,
          title: const Text('Рейтинг > 7'),
          value: isChecked,
          onChanged: (bool? value) {
            setState(() {
              isChecked = value!;
            });
          },
        ),
        ElevatedButton(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: const <Widget>[
              Icon(Icons.exit_to_app),
              Text('Exit'),
            ],
          ),
          onPressed: () {
            SystemChannels.platform.invokeListMethod('SystemNavigator.pop');
          },
        ),
        ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: const <Widget>[
                Icon(Icons.arrow_back),
                Text('Back'),
              ],
            ))
      ]),
    );
  }
}
