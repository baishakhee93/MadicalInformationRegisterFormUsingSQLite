import 'package:flutter/material.dart';
import 'package:group_radio_button/group_radio_button.dart';
import 'package:mirf/colors.dart';
import 'package:mirf/theme_change.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingScreen extends StatefulWidget {


  @override
  State<SettingScreen> createState() => _SettingScreenState();
}


class _SettingScreenState extends State<SettingScreen> {

  String selectedColor="Green";
  List<String>  colors=["Dark", "Light", "Green", "Blue"];

  void onThemeChanged(String value, ThemeNotifer themeNotifer) async{

    if(value=='Dark'){
      themeNotifer=themeNotifer.setTheme(darkTheme);
    }else if(value=='Light'){
      themeNotifer=themeNotifer.setTheme(lightTheme);

    }else if(value=='Green'){
      themeNotifer=themeNotifer.setTheme(greenTheme);

    }else {
      themeNotifer=themeNotifer.setTheme(blueTheme);

    }
    final pref=await SharedPreferences.getInstance();
    pref.setString("ThemeMode", value);
  }
  @override
  Widget build(BuildContext context) {
    final themeNotifier=Provider.of<ThemeNotifer>(context);
    themeNotifier.getTheme;

    return Scaffold(
      appBar: AppBar(
        title: Text("Setting"),


      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            style:ElevatedButton.styleFrom(backgroundColor: Colors.green,textStyle: TextStyle(color: Colors.white)),
            onPressed: () {
              themeChangeDialogBox(themeNotifier);
            },
            child: Text("Theme Change"),

          ),
        ),


      ),

    );
  }

  themeChangeDialogBox(ThemeNotifer themeNotifer) {
    showDialog(
        context: context,
        builder: (_)=>
            StatefulBuilder(
                builder: (BuildContext context,
                    StateSetter setState) {
                  return AlertDialog(
                    content: Container(
                      height: 250,
                      child: Column(
                        crossAxisAlignment:CrossAxisAlignment.center ,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          RadioGroup<String>.builder(
                              groupValue: selectedColor,
                              onChanged: (value ) {
                                setState((){
                                  selectedColor=value.toString();
                                });
                                onThemeChanged(selectedColor, themeNotifer);
                              },
                              items: colors,
                              itemBuilder: (items)=>RadioButtonBuilder(items)


                          )

                        ],
                      ),

                    ),
                    actions: [
                      ElevatedButton(
                          style:ElevatedButton.styleFrom(backgroundColor: Colors.green,textStyle: TextStyle(color: Colors.white)),

                          onPressed: (){
                            Navigator.pop(context);
                          },
                          child: Text("Close"))
                    ],
                  );

                }

            )


    );

  }

}