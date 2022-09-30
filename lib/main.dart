import 'dart:convert';
import 'dart:typed_data';

import 'package:country_list_pick/country_list_pick.dart';
import 'package:email_validator/email_validator.dart';
import 'package:flutter/material.dart';
import 'package:grouped_buttons/grouped_buttons.dart';
import 'package:intl/intl.dart';
import 'package:mirf/database/madical_infomation_database_helper.dart';
import 'package:mirf/model/madical_info_model.dart';
import 'package:mirf/service/network_connectivity.dart';

import 'package:signature/signature.dart';

import 'history_details_screen.dart';


void main() {
  /* WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences.getInstance().then((pref) {
    var themeColors= pref.getString("ThemeMode");
    if(themeColors=='Dark'){
      activeTheme=darkTheme;
    }else if(themeColors=='Light'){
      activeTheme=lightTheme;

    }else if(themeColors=='Green'){
      activeTheme=greenTheme;

    }else {
      activeTheme=blueTheme;

    }*/
  /* runApp(MultiProvider(providers: [
      ChangeNotifierProvider(create: (context)=>ThemeNotifer(darkTheme),
      ),
    ],child: MyApp(),));*/
  runApp(MyApp());

/*  });*/

}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme:ThemeData(primaryColor: Colors.green),
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}
enum GrenderList { Male, Female ,Other}
enum DesignationList { MD, DO,NP,PA }

class _MyHomePageState extends State<MyHomePage> {

  final TextEditingController firstController= new TextEditingController();
  final TextEditingController lastController= new TextEditingController();
  final TextEditingController designationController= new TextEditingController();
  final TextEditingController organizationController= new TextEditingController();
  final TextEditingController departmentController= new TextEditingController();
  final TextEditingController orgAddress1Controller= new TextEditingController();
  final TextEditingController orgAddress2Controller= new TextEditingController();
  final TextEditingController stateController= new TextEditingController();
  final TextEditingController cityController= new TextEditingController();
  final TextEditingController zipController= new TextEditingController();
  final TextEditingController phoneNumberController= new TextEditingController();
  final TextEditingController faxNumberController= new TextEditingController();
  final TextEditingController emailController= new TextEditingController();
  final TextEditingController reqDescriptionController= new TextEditingController();
  final TextEditingController patientNameController= new TextEditingController();
  final TextEditingController dobController= new TextEditingController();
  final TextEditingController reqDateController= new TextEditingController();
  final TextEditingController representativeNameController= new TextEditingController();
  final TextEditingController representativeTypeController= new TextEditingController();
  final TextEditingController representativeTerritoryController= new TextEditingController();
  final TextEditingController countryCodeController= new TextEditingController();
  final TextEditingController primaryTelwPhoneNumberController= new TextEditingController();

  final SignatureController signatureController=SignatureController(
      penStrokeWidth: 2,
      exportBackgroundColor: Colors.white,
      penColor: Colors.black);
  Int8List? _bytes;

  //final DateFormat formatter = DateFormat('yyyy-MM-dd');
  var _connectionChangeStream;
  List<String> _checked = []; //["A", "B"];
  List<String> _checkedProduct = []; //["A", "B"];
  final _databaseHelper = MadicalInformationDatabaseHelper.instance;
  DateTime currentDate = DateTime.now();
  DateTime dobDate = DateTime.now();
  final _formKey = GlobalKey<FormState>();
  GrenderList _site = GrenderList.Male;
  DesignationList _designationList = DesignationList.MD;
  bool valuefirst = false;
  bool valuesecond = false;
  String? selectedOne;
  String? selectedMethod;
  String? selectedProduct;
  @override
  initState() {
    print('called');
    //Create instance
    NetworkConnection connectionStatus = NetworkConnection.getInstance();
    //Initialize
    connectionStatus.initialize();
    //Listen for connection change
    _connectionChangeStream = connectionStatus.connectionChange.listen((event) {
      print(event);
    });

    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(widget.title),
      ),drawer: Drawer(
      child: ListView(
        // Important: Remove any padding from the ListView.
        padding: EdgeInsets.zero,
        children: <Widget>[
          UserAccountsDrawerHeader(
            decoration: BoxDecoration(
              color: Colors.green,
            ),
            accountName: Text("Baishakhee"),

            accountEmail: Text("shakhee95@gmail.com"),
            currentAccountPicture: CircleAvatar(
              backgroundColor: Colors.white,
              child: Text(
                "MI",
                style: TextStyle(fontSize: 40.0,color: Colors.green),
              ),
            ),

          ),
          ListTile(
            leading: Icon(Icons.home), title: Text("Home"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.history), title: Text("History"),
            onTap: () {
              Navigator.push(context,  MaterialPageRoute(
                  builder: (_) => HistoryPage()));
            },
          ), ListTile(
            leading: Icon(Icons.report), title: Text("Day End Report"),
            onTap: () {
              Navigator.pop(context);
            },
          ),
          ListTile(
            leading: Icon(Icons.settings), title: Text("Settings"),
            /*      onTap: () {
              Navigator.push(context,  MaterialPageRoute(
                  builder: (_) => SettingScreen()));            },*/
          ),
          ListTile(
            leading: Icon(Icons.contacts), title: Text("Contact Us"),
            onTap: () {
              Navigator.pop(context);
            },
          ),

        ],
      ),
    ),

      body: ListView(
        key: _formKey,
        children: <Widget>[
          Container(
            margin: EdgeInsets.all(10),
            alignment: Alignment.centerLeft,

            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                // mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Container(
                    alignment: Alignment.center,
                    child: Text("Medical Information Request Form",

                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 20,
                          decoration: TextDecoration.underline,
                          decorationStyle:TextDecorationStyle.double
                      ),
                      textAlign: TextAlign.center,),

                  ),

                  Text(""),
                  Text("A. Healthcare Professional Contact Information:",
                    style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 18),
                    textAlign: TextAlign.start,),
                  Text(""),

                  Divider(
                    color: Colors.black,height: 1,
                  ),
                  Text(""),
                  Text("Requestor's First Name*",
                    style: TextStyle(color: Colors.black,fontSize: 18),
                    textAlign: TextAlign.start,),
                  TextFormField(
                    controller: firstController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Requestor's First Name",
                        focusedBorder: OutlineInputBorder(
                    borderSide: BorderSide(
                    color: Colors.green,
                        width: 2),
                  ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(
            color: Colors.red,
            width: 2),
      ),
                    ),
                    textAlign: TextAlign.start,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Requestor's First Name";
                      }
                      return value;
                    },

                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                  ),

                  Text(""),

                  Text("Requestor's Last Name*",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),
                  TextFormField(
                    controller: lastController,
                    textAlign: TextAlign.start,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return "Please enter Requestor's Last Name";
                      }
                      return value;
                    },
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Requestor's Last Name",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green,
                            width: 2),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 2),
                      ),

                    ),

                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                  ),

                  Text(""),

                  Text("Designation:*",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),
                  Container(
                    child: Column(
                      children:<Widget> [
                        ListTile(
                          title: const Text('MD'),
                          leading: Radio(
                            value:DesignationList.MD,
                            groupValue: _designationList,
                            onChanged:(DesignationList? value) {
                              setState(() {
                                _designationList = value!;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('DO'),
                          leading: Radio(
                            value: DesignationList.DO,
                            groupValue: _designationList,
                            onChanged:(DesignationList? value) {
                              setState(() {
                                _designationList = value!;
                              });
                            },
                          ),
                        ),ListTile(
                          title: const Text('NP'),
                          leading: Radio(
                            value: DesignationList.NP,
                            groupValue: _designationList,
                            onChanged:(DesignationList? value) {
                              setState(() {
                                _designationList = value!;
                              });
                            },
                          ),
                        ),ListTile(
                          title: const Text('PA'),
                          leading: Radio(
                            value: DesignationList.PA,
                            groupValue: _designationList,
                            onChanged:(DesignationList? value) {
                              setState(() {
                                _designationList = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),

                  ),

                  Text(""),

                  Text("Institution/Office*",
                    style: TextStyle(color: Colors.black,fontSize: 18),
                    textAlign: TextAlign.start,),
                  TextFormField(
                    controller: organizationController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Institution/Office",
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.green,
                          width: 2),
                    ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 2),
                      ),
                    ),
                    textAlign: TextAlign.start,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Institution/Office';
                      }
                      return value;
                    },
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                  ),

                  Text(""),

                  Text("Department*",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),
                  TextFormField(
                    controller: departmentController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Department",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green,
                            width: 2),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 2),
                      ),
                    ),
                    textAlign: TextAlign.start,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Department';
                      }
                      return value;
                    },
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                  ),

                  Text(""),

                  Text("Institution/Office Address Line 1 ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),
                  TextFormField(
                    controller: orgAddress1Controller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Institution/Office Address Line 1",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green,
                            width: 2),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 2),
                      ),
                    ),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                  ),

                  Text(""),

                  Text("Institution/Office Address Line 2 ",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),
                  TextFormField(
                    controller: orgAddress2Controller,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Institution/Office Address Line 2 ",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green,
                            width: 2),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 2),
                      ),
                    ),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                  ),
                  Text(""),

                  Text("State*",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),

                  TextFormField(
                    controller: stateController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "State",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green,
                            width: 2),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 2),
                      ),
                    ),
                    textAlign: TextAlign.start,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter State';
                      }
                      return value;
                    },
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                  ),
                  Text(""),

                  Text("City*",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),

                  TextFormField(
                    controller: cityController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "City",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green,
                            width: 2),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 2),
                      ),
                    ),
                    textAlign: TextAlign.start,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter City';
                      }
                      return value;
                    },
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                  ),

                  Text(""),

                  Text("Zip*",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),

                  TextFormField(
                    controller: zipController,

                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Zip",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green,
                            width: 2),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 2),
                      ),
                    ),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    keyboardType: TextInputType.number,
                    maxLength: 6,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Zip';
                      }
                      return value;
                    },
                  ),

                  Text(""),

                  Text("Phone Number",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),
                  TextFormField(
                    controller: phoneNumberController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Phone Number",   focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.green,
                          width: 2),
                    ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 2),
                      ),
                    ),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                  ),

                  Text(""),

                  Text("Fax Number",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),

                  TextFormField(
                    controller: faxNumberController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Fax Number",   focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.green,
                          width: 2),
                    ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 2),
                      ),
                    ),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                  ),
                  Text(""),


                  Text("Email",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),
                  TextFormField(
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    validator: (value) => EmailValidator.validate(value!) ? null : "Please enter a valid email",
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Email",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green,
                            width: 2),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 2),
                      ),
                    ),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                  ),
                  Text(""),
                  Text("B. Unsolicited Information Request:",
                    style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold,fontSize: 18),
                    textAlign: TextAlign.start,),
                  Text(""),
                  Divider(color: Colors.black,height: 1,),
                  Text(""),

                  Text("Choose Products*:",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),

                  CheckboxGroup(
                      labels: <String>[
                        "10 MG - Roszet",
                        "20 MG - Roszet",
                      ],
                      checked: _checkedProduct,
                      onChange: (bool isChecked, String label, int index){
                        print("isChecked: $isChecked   label: $label  index: $index");
                        selectedProduct=label.toString();
                      },
                      onSelected: (List selected) {
                        setState(() {
                          if (selected.length > 1) {
                            selected.removeAt(0);
                            print('selected length  ${selected.length}');
                          } else {
                            print("only one");
                          }
                          _checkedProduct = selected.toList().cast<String>();;
                        });
                      }
                  ),
                  // RadioListTile(value: value, groupValue: groupValue, onChanged: onChanged)
                  Text(""),

                  Text("Request Description:",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),

                  TextFormField(
                    controller: reqDescriptionController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Request Description:"
                    ),
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                  ),
                  Text(""),

                  Text("Please Check One:",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),
                  RadioButtonGroup(

                    labels: [
                      "This inquiry does not represent an \n adverse event experienced by a patient",
                      "This inquiry represent an adverse \n event experienced by a patient",
                    ],

                    labelStyle: TextStyle(fontSize: 15),

                    // disabled: ["Option 1"],
                    onChange: (String label, int index){
                      selectedOne=label.toString();
                      print("label: $label index: $index");

                    },
                    onSelected: (String label) => print(label),
                  ),

                  Text(""),

                  Text("Patient Name*",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),

                  TextFormField(
                    controller: patientNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Patient Name",   focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.green,
                          width: 2),
                    ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 2),
                      ),
                    ),
                    textAlign: TextAlign.start,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Patient Name';
                      }
                      return value;
                    },
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                  ),
                  Text(""),

                  Text("DOB*",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),
                  TextFormField(
                    controller: dobController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "dd/mm/yyyy",
                      focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(
                          color: Colors.green,
                          width: 2),
                    ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 2),
                      ),

                    ),
                    textAlign: TextAlign.start,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter DOB';
                      }
                      return value;
                    },
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    onTap: (){
                      _selectDOBDate(context);
                    },

                  ),
                  Text(""),

                  Text("Gender*",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),
                  Container(
                    child: Column(
                      children:<Widget> [
                        ListTile(
                          title: const Text('Male'),
                          leading: Radio(
                            value: GrenderList.Male,
                            groupValue: _site,
                            onChanged:(GrenderList? value) {
                              setState(() {
                                _site = value!;
                              });
                            },
                          ),
                        ),
                        ListTile(
                          title: const Text('Female'),
                          leading: Radio(
                            value: GrenderList.Female,
                            groupValue: _site,
                            onChanged: (GrenderList? value) {
                              setState(() {
                                _site = value!;
                              });
                            },
                          ),
                        ),   ListTile(
                          title: const Text('Other'),
                          leading: Radio(
                            value: GrenderList.Other,
                            groupValue: _site,
                            onChanged: (GrenderList? value) {
                              setState(() {
                                _site = value!;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                  ),
                  Text(""),
                  Text("Date of Request:*",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,
                  ),

                  TextFormField(
                    controller: reqDateController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "dd/mm/yyyy",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green,
                            width: 2),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 2),
                      ),
                    ),
                    textAlign: TextAlign.start,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Date of Request';
                      }
                      return value;
                    },
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    onTap: (){
                      _selectDate(context);
                    },
                  ),
                  Text(""),

                  Text("Preferred Method of Response:",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),
                  CheckboxGroup(
                      labels: <String>[
                        "Fax",
                        "Mail",
                        "Email",
                        "Phone",

                      ],
                      checked: _checked,
                      onChange: (bool isChecked, String label, int index){
                        print("isChecked: $isChecked   label: $label  index: $index");
                        selectedMethod=label.toString();
                      },
                      onSelected: (List selected) {
                        setState(() {
                          if (selected.length > 1) {
                            selected.removeAt(0);
                            print('selected length  ${selected.length}');
                          } else {
                            print("only one");
                          }
                          _checked = selected.toList().cast<String>();;
                        });
                      }
                  ),
                  Text(""),

                  Text("Health Care professional's Signature:*",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),

                  Container(
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.black,strokeAlign: StrokeAlign.outside),


                    ),
                    child: Signature(
                      height: 200,
                      backgroundColor: Colors.white,
                      controller: signatureController,

                    ),
                  ),
                  Container(
                    alignment: Alignment.centerRight,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),

                      onPressed: (){
                        setState(() {
                          signatureController.clear();
                        });
                      }, child:Text("Clear",style: TextStyle(color: Colors.white),),
                    ),
                  ),
                  Text(""),
                  Text("C. Representative Contact Information: (To Be Completed By Representative)",
                    style: TextStyle(color: Colors.black,
                        fontWeight: FontWeight.bold,fontSize: 18),
                    textAlign: TextAlign.start,),
                  Text(""),
                  Divider(color: Colors.black,height: 1,),
                  Text(""),

                  Text("By Submitting this form, I certify that is request for information was initiated by Health Care Professional stated above, and was not solicited by me in anymanner.",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),

                  Text(""),
                  Divider(color: Colors.black,height: 1,),
                  Text(""),
                  Text("Representative Name*",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),

                  TextFormField(
                    controller: representativeNameController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Representative Name",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green,
                            width: 2),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 2),
                      ),
                    ),
                    textAlign: TextAlign.start,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Representative Name';
                      }
                      return value;
                    },
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                  ),
                  Text(""),

                  Text("Representative Type*",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),

                  TextFormField(
                    controller: representativeTypeController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Representative Type",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green,
                            width: 2),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 2),
                      ),
                    ),
                    textAlign: TextAlign.start,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Representative Type';
                      }
                      return value;
                    },
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                  ),
                  Text(""),

                  Text("Representative Territory Number*",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),

                  TextFormField(
                    controller: representativeTerritoryController,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Representative Territory Number",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green,
                            width: 2),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 2),
                      ),
                    ),
                    textAlign: TextAlign.start,
                    keyboardType: TextInputType.number,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Representative Territory Number';
                      }
                      return value;
                    },
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                  ),
                  Text(""),

                  Text("Country Code",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),
                  Container(
                    width:MediaQuery.of(context).size.width ,
                    alignment: Alignment.centerLeft,
                    height: 50,
                    child: CountryListPick(
                      initialSelection: '+91',
                      // to get feedback data from picker
                      onChanged: (code) {
                        if(code!=null){
                          countryCodeController.text=code.toString();
                          print(code.name);
                          // code of country
                          print(code.code);
                          // code phone of country
                          print(code.dialCode);
                          // path flag of country
                          print(code.flagUri);
                        }
                        // name of country

                      },
                    ),
                    decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey,strokeAlign: StrokeAlign.outside),
                        borderRadius: BorderRadius.circular(2)


                    ),
                  ),

                  Text(""),
                  Text("Primary TelePhone Number",
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),
                    textAlign: TextAlign.start,),
                  TextFormField(
                    controller: primaryTelwPhoneNumberController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Primary TelePhone Number",
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.green,
                            width: 2),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                            color: Colors.red,
                            width: 2),
                      ),
                    ),
                    textAlign: TextAlign.start,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Please enter Primary TelePhone Number';
                      }
                      return value;
                    },
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18),

                  ),
                  Container(
                      alignment: Alignment.center,
                      child: ElevatedButton(
                          style: ElevatedButton.styleFrom(backgroundColor: Colors.green),
                          onPressed: () async {
                            final base64;
                            if(signatureController.isNotEmpty) {
                              final Uint8List? data = await signatureController.toPngBytes();
                              if (data != null) {
                                base64 = base64Encode(data);
                                final Uint8List bytes=base64Decode(base64);
                                _bytes=bytes.buffer.asInt8List();
                               /* final isvalid=_formKey.currentState!.validate();
                                if(isvalid){
                                  _formKey.currentState!.save();*/
                             /*  if (_formKey.currentState!.validate()) {
                                  print("sOrder.............if");*/

                                  // If the form is valid, display a snackbar. In the real world,
                                  // you'd often call a server or save the information in a database.
                                /*  ScaffoldMessenger.of(context).showSnackBar(
                                    const SnackBar(content: Text('Processing Data')),
                                  );*/
                                  String title="";
                                  String message="Are You Sure ! Want To Confirm";
                                  String btn="Yes";

                                  showAlertDialog(context,title,message,btn);

                                }
                              }

                              //  clearData();
                           /* }else{
                              print("sOrder.............else");
                              String title="";
                              String message="Please Enter Data";
                              String btn="OK";

                              showAlertDialog(context,title,message,btn);
                              *//* ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(content: Text('Please Enter Data',style: TextStyle(backgroundColor: Colors.red,color: Colors.white),)),
                              );*//*
                            }*/
                          },
                          child: Text("Submit",
                            style: TextStyle(color: Colors.white),))
                  )
                ]
            ),
          )

        ],
      ),

      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
  void clearData() {
    firstController.clear();
    lastController.clear();
    designationController.clear();
    organizationController.clear();
    departmentController.clear();
    orgAddress1Controller.clear();
    orgAddress2Controller.clear();
    stateController.clear();
    cityController.clear();
    zipController.clear();
    phoneNumberController.clear();
    faxNumberController.clear();
    emailController.clear();
    reqDescriptionController.clear();
    patientNameController.clear();
    dobController.clear();
    reqDateController.clear();
    representativeNameController.clear();
    representativeTypeController.clear();
    representativeTerritoryController.clear();
    countryCodeController.clear();
    primaryTelwPhoneNumberController.clear();
    signatureController.clear();
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1500),
        lastDate: DateTime(2200));
    if(pickedDate != null ){
      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate1 = DateFormat('dd/MM/yyyy').format(pickedDate);
      print(formattedDate1); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        reqDateController.text = formattedDate1; //set output date to TextField value.
      });
    }else{
      print("Date is not selected");
    }
    /* if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });*/
  }



  Future<void> _selectDOBDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
        context: context,
        initialDate: dobDate,
        firstDate: DateTime(1500),
        lastDate: DateTime(2200));
    if(pickedDate != null ){
      print(pickedDate);  //pickedDate output format => 2021-03-10 00:00:00.000
      String formattedDate = DateFormat('dd/MM/yyyy').format(pickedDate);
      print(formattedDate); //formatted date output using intl package =>  2021-03-16
      //you can implement different kind of Date Format here according to your requirement

      setState(() {
        dobController.text = formattedDate; //set output date to TextField value.
      });
    }else{
      print("Date is not "
          "selected");
    }
    /*if (pickedDate != null && pickedDate != dobDate)
      setState(() {
        dobDate = pickedDate;
      });*/
  }

  void saveData(String firstName, String lastName, String designation, String organaization, String department,
      String address1, String address2, String state, String city, String zip, String faxNumber, String email,
      String chooseProduct, String reqDiscription, String checkInquiry, String patientName, String dob, String gender,
      String reqDate, String methodResponse, String repName, String repType,String repTerritoryNumber,
      String contryCode,String telePhoneNumber, data,) async{

    // row to insert
    Map<String, dynamic> row = {
      MadicalInformationDatabaseHelper.MI_FISRT_NAME: firstName.toString(),
      MadicalInformationDatabaseHelper.MI_LAST_NAME: lastName.toString(),
      MadicalInformationDatabaseHelper.MI_DESIGNATION: designation.toString(),
      MadicalInformationDatabaseHelper.MI_DEPARTMENT: department.toString(),
      MadicalInformationDatabaseHelper.MI_ADDRESS1: address1.toString(),
      MadicalInformationDatabaseHelper.MI_ADDRESS2: address2.toString(),
      MadicalInformationDatabaseHelper.MI_STATE: state.toString(),
      MadicalInformationDatabaseHelper.MI_CITY: city.toString(),
      MadicalInformationDatabaseHelper.MI_ZIP: zip.toString(),
      MadicalInformationDatabaseHelper.MI_FAX_NUMBER: faxNumber.toString(),
      MadicalInformationDatabaseHelper.MI_EMAIL: email.toString(),
      MadicalInformationDatabaseHelper.MI_CHOOSE_PRODUCT: chooseProduct.toString(),
      MadicalInformationDatabaseHelper.MI_REQ_DISCRIPTION: reqDiscription.toString(),
      MadicalInformationDatabaseHelper.MI_CHECK_INQUIRY: checkInquiry.toString(),
      MadicalInformationDatabaseHelper.MI_PATIENT_NAME: patientName.toString(),
      MadicalInformationDatabaseHelper.MI_DOB: dob.toString(),
      MadicalInformationDatabaseHelper.MI_GENDER: gender.toString(),
      MadicalInformationDatabaseHelper.MI_REQ_DATE: reqDate.toString(),
      MadicalInformationDatabaseHelper.MI_METHOD_RESPONSE: methodResponse.toString(),
      MadicalInformationDatabaseHelper.MI_REQ_NAME: repName.toString(),
      MadicalInformationDatabaseHelper.MI_REQ_TYPE: repType.toString(),
      MadicalInformationDatabaseHelper.MI_REQ_TERRITORY_NUMBER: repTerritoryNumber.toString(),
      MadicalInformationDatabaseHelper.MI_CONTRY_CODE: contryCode.toString(),
      MadicalInformationDatabaseHelper.MI_TELE_PHONE_NUMBER: telePhoneNumber.toString(),
    };
    MadicalInfoModel madicalInfoModel = MadicalInfoModel.fromMap(row);
    var id= _databaseHelper.insert(madicalInfoModel);
    if(id!=null){
      String title="";
      String message="Successfully Added";
      String btn="OK";

      showAlertDialog(context,title,message,btn);
    }
    /* const snackBar = SnackBar(
      content: Text('Data Inserted Successfully'),
    );*/
//     clearData();
  }

  showAlertDialog(BuildContext context,title, message,btn) {
    print("sOrder.............$message");

    // set up the buttons
    Widget cancelButton = TextButton(
      child: Text("Cancel"),
      onPressed:  () {},
    );
    Widget continueButton = TextButton(
      child: Text(btn),
      onPressed:  () {
        if(btn=="OK"){
          clearData();
          Navigator.pop(context);
        }else if(btn == "Yes"){
          Navigator.pop(context);
          saveData(
              firstController.text.toString(),
              lastController.text.toString(),
              _designationList.name.toString(),
              organizationController.text.toString(),
              departmentController.text.toString(),
              orgAddress1Controller.text.toString(),
              orgAddress2Controller.text.toString(),
              stateController.text.toString(),
              cityController.text.toString(),
              zipController.text.toString(),
              phoneNumberController.text.toString(),
              faxNumberController.text.toString(),
              emailController.text.toString(),
              selectedProduct.toString(),
              reqDescriptionController.text.toString(),
              patientNameController.text.toString(),
              dobController.text.toString(),
              _site.name.toString(),
              reqDateController.text.toString(),
              selectedMethod.toString(),
              representativeNameController.text.toString(),
              representativeTypeController.text.toString(),
              representativeTerritoryController.text.toString(),
              countryCodeController.text.toString(),
              primaryTelwPhoneNumberController.text.toString(),
              _bytes);

        }

      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: [
        cancelButton,
        continueButton,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
