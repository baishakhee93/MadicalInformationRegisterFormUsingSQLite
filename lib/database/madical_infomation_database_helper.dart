import 'package:mirf/model/madical_info_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class MadicalInformationDatabaseHelper{
  static final _databaseName = "MadicalInformation.db";
  static final _databaseVersion = 1;
  static final table = 'registration_details_table';
  static final ID= "id";
  static final MI_FISRT_NAME="firstName";
  static final MI_LAST_NAME="lastName";
  static final MI_DESIGNATION="designation";
  static final MI_ORGANAIZATION="organaization";
  static final MI_DEPARTMENT="department";
  static final MI_ADDRESS1="address1";
  static final MI_ADDRESS2="address2";
  static final MI_STATE="states";
  static final MI_CITY="city";
  static final MI_ZIP="zip";
  static final MI_FAX_NUMBER="faxNumber";
  static final MI_EMAIL="email";
  static final MI_CHOOSE_PRODUCT="chooseProduct";
  static final MI_REQ_DISCRIPTION="reqDiscription";
  static final MI_CHECK_INQUIRY="checkInquiry";
  static final MI_PATIENT_NAME="patientName";
  static final MI_DOB="dob";
  static final MI_GENDER="gender";
  static final MI_REQ_DATE="reqDate";
  static final MI_METHOD_RESPONSE="methodResponse";
  static final MI_REQ_NAME="repName";
  static final MI_REQ_TYPE="repType";
  static final MI_REQ_TERRITORY_NUMBER="repTerritoryNumber";
  static final MI_CONTRY_CODE="contryCode";
  static final MI_TELE_PHONE_NUMBER="telePhoneNumber";


  // make this a singleton class
  MadicalInformationDatabaseHelper._privateConstructor();
  static final MadicalInformationDatabaseHelper instance = MadicalInformationDatabaseHelper._privateConstructor();

  // only have a single app-wide reference to the database
  static Database? _database;
  Future<Database?> get database async {
    if (_database != null)
      return _database;
    // lazily instantiate the db the first time it is accessed
    _database = await _initDatabase();
    return _database;
  }

  _initDatabase() async {
    String path = join(await getDatabasesPath(), _databaseName);
    return await openDatabase(path,
        version: _databaseVersion,
        onCreate: _onCreate);
  }

  // SQL code to create the database table
  Future _onCreate(Database db, int version) async {
    await db.execute('''
          CREATE TABLE  $table  (
            $ID  INTEGER PRIMARY KEY AUTOINCREMENT ,
            $MI_FISRT_NAME  TEXT ,
            $MI_LAST_NAME  TEXT  ,
            $MI_DESIGNATION   TEXT ,
            $MI_ORGANAIZATION  TEXT ,
            $MI_DEPARTMENT TEXT ,
            $MI_ADDRESS1 TEXT ,
            $MI_ADDRESS2 TEXT ,
            $MI_STATE TEXT ,
            $MI_CITY TEXT ,
            $MI_ZIP TEXT ,
            $MI_FAX_NUMBER TEXT ,
            $MI_EMAIL TEXT ,
            $MI_CHOOSE_PRODUCT  TEXT ,
            $MI_REQ_DISCRIPTION TEXT ,
            $MI_CHECK_INQUIRY  TEXT ,
            $MI_PATIENT_NAME  TEXT ,
            $MI_DOB  TEXT ,
            $MI_GENDER  TEXT ,
            $MI_REQ_DATE TEXT ,
            $MI_METHOD_RESPONSE  TEXT ,
            $MI_REQ_NAME  TEXT ,
            $MI_REQ_TYPE  TEXT ,
            $MI_REQ_TERRITORY_NUMBER  TEXT ,
            $MI_CONTRY_CODE  TEXT ,
            $MI_TELE_PHONE_NUMBER TEXT 
          )
          ''');
  }
  Future<int?> insert(MadicalInfoModel madicalInfoModel) async {
    Database? db = await instance.database;
    return await db?.insert(table, {
      'firstName': madicalInfoModel.firstName,
      'lastName': madicalInfoModel.lastName,
      'designation': madicalInfoModel.designation,
      'organaization': madicalInfoModel.organaization,
      'department': madicalInfoModel.department,
      'address1': madicalInfoModel.address1,
      'address2': madicalInfoModel.address2,
      'states': madicalInfoModel.state,
      'city': madicalInfoModel.city,
      'zip': madicalInfoModel.zip,
      'faxNumber': madicalInfoModel.faxNumber,
      'email': madicalInfoModel.email,
      'chooseProduct': madicalInfoModel.chooseProduct,
      'reqDiscription': madicalInfoModel.reqDiscription,
      'checkInquiry': madicalInfoModel.checkInquiry,
      'patientName': madicalInfoModel.patientName,
      'dob': madicalInfoModel.dob,
      'gender': madicalInfoModel.gender,
      'reqDate': madicalInfoModel.reqDate,
      'methodResponse': madicalInfoModel.methodResponse,
      'repName': madicalInfoModel.repName,
      'repType': madicalInfoModel.repType,
      'repTerritoryNumber': madicalInfoModel.repTerritoryNumber,
      'contryCode': madicalInfoModel.contryCode,
      'telePhoneNumber': madicalInfoModel.telePhoneNumber,
    });
  }
  Future<List<Map<String, dynamic>>?> queryAllRows() async {
    Database? db = await instance.database;
    return await db?.query(table);
  }
}