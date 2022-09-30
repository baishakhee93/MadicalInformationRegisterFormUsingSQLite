import 'package:mirf/database/madical_infomation_database_helper.dart';

class MadicalInfoModel{
 var id;
 var firstName;
 var lastName;
 var designation;
 var organaization;
 var department;
 var address1;
 var address2;
 var state;
 var city;
 var zip;
 var faxNumber;
 var email;
 var chooseProduct;
 var reqDiscription;
 var checkInquiry;
 var patientName;
 var dob;
 var gender;
 var reqDate;
 var methodResponse;
 var repName;
 var repType;
 var repTerritoryNumber;
 var contryCode;
 var telePhoneNumber;

 MadicalInfoModel(
     this.id,
     this.firstName,
     this.lastName,
     this.designation,
     this.organaization,
     this.department,
     this.address1,
     this.address2,
     this.state,
     this.city,
     this.zip,
     this.faxNumber,
     this.email,
     this.chooseProduct,
     this.reqDiscription,
     this.checkInquiry,
     this.patientName,
     this.dob,
     this.gender,
     this.reqDate,
     this.methodResponse,
     this.repName,
     this.repType,
     this.repTerritoryNumber,
     this.contryCode,
     this.telePhoneNumber);
 MadicalInfoModel.fromMap(Map<String, dynamic> map) {
  id = map['id'];
  firstName = map['firstName'];
  lastName = map['lastName'];
  designation = map['designation'];
  organaization = map['organaization'];
  department = map['department'];
  address1 = map['address1'];
  address2 = map['address2'];
  state = map['state'];
  city = map['city'];
  zip = map['zip'];
  faxNumber = map['faxNumber'];
  email = map['email'];
  chooseProduct = map['chooseProduct'];
  reqDiscription = map['reqDiscription'];
  checkInquiry = map['checkInquiry'];
  patientName = map['patientName'];
  dob = map['dob'];
  gender = map['gender'];
  reqDate = map['reqDate'];
  methodResponse = map['methodResponse'];
  repName = map['repName'];
  repType = map['repType'];
  repTerritoryNumber = map['repTerritoryNumber'];
  contryCode = map['contryCode'];
  telePhoneNumber = map['telePhoneNumber'];
 }

 Map<String, dynamic> toMap() {

  return {
   MadicalInformationDatabaseHelper.ID: id,
   MadicalInformationDatabaseHelper.MI_FISRT_NAME: firstName,
   MadicalInformationDatabaseHelper.MI_LAST_NAME: lastName,
   MadicalInformationDatabaseHelper.MI_DESIGNATION: designation,
   MadicalInformationDatabaseHelper.MI_DEPARTMENT: department,
   MadicalInformationDatabaseHelper.MI_ADDRESS1: address1,
   MadicalInformationDatabaseHelper.MI_ADDRESS2: address2,
   MadicalInformationDatabaseHelper.MI_STATE: state,
   MadicalInformationDatabaseHelper.MI_CITY: city,
   MadicalInformationDatabaseHelper.MI_ZIP: zip,
   MadicalInformationDatabaseHelper.MI_FAX_NUMBER: faxNumber,
   MadicalInformationDatabaseHelper.MI_EMAIL: email,
   MadicalInformationDatabaseHelper.MI_CHOOSE_PRODUCT: chooseProduct,
   MadicalInformationDatabaseHelper.MI_REQ_DISCRIPTION: reqDiscription,
   MadicalInformationDatabaseHelper.MI_CHECK_INQUIRY: checkInquiry,
   MadicalInformationDatabaseHelper.MI_PATIENT_NAME: patientName,
   MadicalInformationDatabaseHelper.MI_DOB: dob,
   MadicalInformationDatabaseHelper.MI_GENDER: gender,
   MadicalInformationDatabaseHelper.MI_REQ_DATE: reqDate,
   MadicalInformationDatabaseHelper.MI_METHOD_RESPONSE: methodResponse,
   MadicalInformationDatabaseHelper.MI_REQ_NAME: repName,
   MadicalInformationDatabaseHelper.MI_REQ_TYPE: repType,
   MadicalInformationDatabaseHelper.MI_REQ_TERRITORY_NUMBER: repTerritoryNumber,
   MadicalInformationDatabaseHelper.MI_CONTRY_CODE: contryCode,
   MadicalInformationDatabaseHelper.MI_TELE_PHONE_NUMBER: telePhoneNumber,
  };

 }

}