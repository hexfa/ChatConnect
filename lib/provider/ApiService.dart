import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:ressengaer_app/Model/pet.dart';
import 'package:ressengaer_app/Model/user.dart';
import 'package:ressengaer_app/Model/vet.dart';
import '../constants.dart';
import '../main.dart';

enum LoginStatus { error, login, isLogin, waiting, passwordWrong, emailWrong }
enum UploadData { error , upload , waiting }
enum UploadRecord { vaccine , visit  , medicalExam }

class ApiService extends ChangeNotifier {

  FirebaseFirestore fs = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;

  // [Data] --------------------------------------------//

  bool checkRegister1 = false;
  bool checkRegister2 = false;
  bool vet = false;

  String selectedPet = '';
  String petId = '';
  String petType = 'Dog';
  String breed = 'Raza';
  String petSize='';
  String sex = 'Male';
  String day = '0';
  String month = '0';
  String year = '0';
  String vetCity = '';
  String vetCityShop = '';
  String workAs = '';
  String expert = '';
  String services = '';
  String imagePath = '';
  String recordPath = '';
  String vacDay = '';
  String vacMonth = '';
  String vacYear = '';
  String desDay = '';
  String desMonth = '';
  String desYear = '';
  String desInter = '';
  String desDay2 = '';
  String desMonth2 = '';
  String desYear2 = '';
  String desExtern = '';
  String othersName='';

  bool loadingAuth = false;

  late ApiStatusLogin apiStatus;
  late UploadStatus uploadStatus;

  // [TextEditingController] -----------------pet---------------------------//
  TextEditingController emailNameController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController numberController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController petNameController = TextEditingController();
  // [TextEditingController] -----------------vet---------------------------//
  TextEditingController vetNumberController = TextEditingController();
  TextEditingController vetProfessionalCard = TextEditingController();
  TextEditingController vetNameController = TextEditingController();
  TextEditingController vetPassword1Controller = TextEditingController();
  TextEditingController vetPassword2Controller = TextEditingController();
  TextEditingController vetDirectionController = TextEditingController();
  TextEditingController vetNitController = TextEditingController();
  TextEditingController vetEmailController = TextEditingController();
  TextEditingController vetPropertyController = TextEditingController();

  TextEditingController recordTextController = TextEditingController();


  // GET

  bool get isAuthLoading => loadingAuth;
  bool get isVet => vet;

  ApiStatusLogin get getApiStatus => apiStatus;
  UploadStatus get getUploadStatus => uploadStatus;

  String get myUser => auth.currentUser!.uid;
  String get getSelectedPet => selectedPet;
  String get getPetType => petType;
  String get getBreed => breed;
  String get getSex => sex;
  String get getPetSize=>petSize;

  TextEditingController get getUserNameController => emailNameController;
  TextEditingController get getPassword1Controller => password1Controller;
  TextEditingController get getPassword2Controller => password2Controller;
  TextEditingController get getFullNameController => fullNameController;
  TextEditingController get getNumberController => numberController;
  TextEditingController get getEmailController => emailController;
  TextEditingController get getPetNameController => petNameController;

  TextEditingController searchController = TextEditingController();
  TextEditingController othersNameTextController = TextEditingController();
//----------------------------vet-----------------------------------------------
  TextEditingController get getVetNumberController =>vetNumberController;
  TextEditingController get getVetProfessionalCard => vetProfessionalCard;
  TextEditingController get getVetNameController => vetNameController;
  TextEditingController get getVetPassword1Controller => vetPassword1Controller;
  TextEditingController get getVetPassword2Controller => vetPassword2Controller;
  TextEditingController get getVetDirectionController => vetDirectionController;
  TextEditingController get getVetNitController => vetNitController;
  TextEditingController get getVetEmailController => vetEmailController;
  TextEditingController get getVetPropertyController => vetPropertyController;

  TextEditingController get getRecordTextController => recordTextController;

  TextEditingController get getSearchController => othersNameTextController;
  TextEditingController get getOthersNameController => searchController;


  // SET
  setPetType(String val) => petType = val;
  setBreed(String val) => breed = val;
  setSize(String val) => petSize = val;
  setSex(String val) => sex = val;
  setCheckRegister1(bool val) => checkRegister1 = val;
  setCheckRegister2(bool val) => checkRegister2 = val;
  setDay(String val) => day = val;
  setMonth(String val) => month = val;
  setYear(String val) => year = val;
  setVetCity(String val) => vetCity = val;
  setVetCityShop(String val) => vetCityShop = val;
  setWorkAs(String val) => workAs = val;
  setExpert(String val) => expert = val;
  setServices(String val) => services = val ;
  setPetId(String val) => petId = val;
  setImagePath(String val) {
    imagePath = val;
    notifyListeners();
  }
  setSelectedPetDef(String val){
    selectedPet = val;
  }
  setSelectedPet(String val){
    selectedPet = val;
    notifyListeners();
  }
  setVacDay(String val) => vacDay = val;
  setVacMonth(String val) => vacMonth = val;
  setVacYear(String val) => vacYear = val;
  setVacDate(String day,month,year){
    vacDay = day;
    vacMonth = month;
    vacYear = year;
  }
  setDesDate(String day,month,year,inter){
    desDay = day;
    desMonth = month;
    desYear = year;
    desInter = inter;
  }
  setDesEDate(String day,month,year,extern){
    desDay2 = day;
    desMonth2 = month;
    desYear2 = year;
    desExtern = extern;
  }
  setOthers(String name){

    othersName=name;
  }
  setVet(bool b)=> vet = b;

  setRecordPath(String val)=> recordPath = val;

  clearInputPet(){
    petNameController.text = '';
    petSize='';
    petType = 'Dog';
    breed = 'Raza';
    sex = 'Male';
    day = '';
    month = '';
    year = '';
    notifyListeners();
  }

  clearInputRegister(){
    emailNameController.text = '';
    password1Controller.text = '';
    password2Controller.text = '';
    fullNameController.text = '';
    numberController.text = '';
    emailController.text = '';
    day = '';
    month = '';
    year = '';
    notifyListeners();
  }

  clearInputRegisterVet(){
    vetDirectionController.text = '';
    vetEmailController.text = '';
    vetNameController.text = '';
    vetNitController.text = '';
    vetNumberController.text = '';
    vetPassword1Controller.text = '';
    vetProfessionalCard.text = '';
    vetPropertyController.text = '';
    notifyListeners();
  }

  apiListener(ApiStatusLogin apiStatus) {
    this.apiStatus = apiStatus;
  }
  apiListenerUpload(UploadStatus uploadStatus) {
    this.uploadStatus = uploadStatus;
  }

  setLoading(bool b) {
    loadingAuth = b;
    notifyListeners();
  }

  initHive() async {
    if (!Hive.isBoxOpen('login')) {
      await Hive.openBox('login');
    }
  }

  bool checkLogin(){
    if(auth.currentUser == null){
      return false;
    }else{
      return true;
    }
  }


  getDefPet() {
    fs.collection('pets').doc(myUser).collection('pet').get().then((value){
      setSelectedPetDef(value.docs.first.id.toString());
    }).onError((error, stackTrace){

    });
  }

  Stream<QuerySnapshot> getAllPets(){
    return fs.collection('pets').doc(myUser).collection('pet').snapshots();

  }
  Stream<QuerySnapshot> getAllHistory(petId , mode){
    return fs.collection('pets').doc(myUser).collection('pet').doc(petId).collection(mode).snapshots();

  }
  Stream<QuerySnapshot> getCountry(){
    return fs.collection('country').snapshots();

  }
  Stream<QuerySnapshot> getAllEvents(){
    return fs.collection('tips').snapshots();

  }
  Stream<QuerySnapshot> getAllProducts(){
    return fs.collection('products').snapshots();

  }


  Stream<QuerySnapshot> getAllAdaptions(){
    return fs.collection('adaptions').snapshots();

  }
  Stream<QuerySnapshot> getAllNews(){
    return fs.collection('vet_news').snapshots();

  }
  Stream<QuerySnapshot> getAllNews2(){
    return fs.collection('vet_news').doc('1VO49JA02f37cDeyPGTc').collection('category').snapshots();

  }
  Stream<QuerySnapshot> getProduct2(){
    return fs.collection('products').doc('Zl6gYmn3Z08AaH6AK6Xg').collection('category').snapshots();

  }
  Stream<QuerySnapshot> getProduct3(x){
    return fs.collection('products').doc('Zl6gYmn3Z08AaH6AK6Xg').collection('category').doc('$x').collection('product').snapshots();

  }
  Stream<QuerySnapshot> getAllNews3(x){
    return fs.collection('vet_news').doc('1VO49JA02f37cDeyPGTc').collection('category').doc('$x').collection('news').snapshots();

  }
  Stream<QuerySnapshot> getAllVetEvents(){
    return fs.collection('vet_events').snapshots();

  }
  Stream<QuerySnapshot> getBanner(){
    return fs.collection('banner').snapshots();

  }
  Stream<QuerySnapshot> getAllVet(){
    return fs.collection('vet').snapshots();

  }
  Stream<QuerySnapshot> getcityVet(String city){
    return fs.collection('vet').where('city',isEqualTo: city).snapshots();

  }



  Future<String> getImageProfileLink(petId) async {
    DocumentSnapshot documentSnapshot = await fs.collection('pets').doc(myUser).collection('pet').doc(petId).get();
    return documentSnapshot.get('image');
  }

  updateProfileImage(String path) async {
    String filename = '${auth.currentUser!.uid}.${path.substring(path.length-3)}';
    File file = File(path);
    TaskSnapshot snapshot = await storage.ref().child('$myUser/profile/$filename').putFile(file);
    snapshot.ref.getDownloadURL().then((value){
      Map<String,dynamic> map = {};
      map['image'] = value;
      fs.collection('users').doc(auth.currentUser!.uid).update(map).whenComplete((){
        uploadStatus.uploaded();
        print('--------------------------------------------------');
        print(snapshot.ref.getDownloadURL());
      }).onError((error, stackTrace){
        uploadStatus.error();
      });
    });
  }

  resetUpdate(){
    recordTextController.text = '';
    imagePath = '-1';
    recordPath = '';
    setVacDate('', '', '');
  }

  uploadRecordFile(String petId , Map<String,dynamic> map ,UploadRecord uploadRecord) async {
    String filename = '${petId}_record_${DateTime.now()}.${recordPath.substring(recordPath.length-3)}';
    String saveAddress = '';
    switch(uploadRecord){
      case UploadRecord.vaccine:
        saveAddress = 'vaccine';
        break;
      case UploadRecord.visit:
        saveAddress = 'visit';
        break;
      case UploadRecord.medicalExam:
        saveAddress = 'medicalExam';
        break;
    }
    File file = File(recordPath);
    TaskSnapshot snapshot = await storage.ref().child('$myUser/pets/$petId/records/$filename').putFile(file);
    snapshot.ref.getDownloadURL().then((value){
      map['record'] = value;
      fs.collection('pets').doc(myUser).collection('pet').doc(petId).collection(saveAddress).doc().set(map).whenComplete((){
        if(UploadRecord.medicalExam != uploadRecord){
          // setCalendarItem(saveAddress , map['year']  ,map['month'] ,map['day']);
        }
        uploadStatus.uploaded();
        resetUpdate();
        setLoading(false);
      }).onError((error, stackTrace){
        print(error);
        uploadStatus.error();
        resetUpdate();
        setLoading(false);
      });
    });
  }

  updateProfilePetImage(String path , String petId) async {
    String filename = '$petId.${path.substring(path.length-3)}';
    File file = File(path);
    TaskSnapshot snapshot = await storage.ref().child('$myUser/pets/$petId/$filename').putFile(file);
    snapshot.ref.getDownloadURL().then((value){
      Map<String,dynamic> map = {};
      map['image'] = value;
      fs.collection('pets').doc(myUser).collection('pet').doc(petId).update(map).whenComplete((){
        uploadStatus.uploaded();
        print('done');
      }).onError((error, stackTrace){
        uploadStatus.error();
      });
    });
  }



  // updateProfilePetImage(String path , String petId) async {
  //   String filename = '$petId.${path.substring(path.length-3)}';
  //   File file = File(path);
  //   TaskSnapshot snapshot = await storage.ref().child('$myUser/pets/$petId/$filename').putFile(file);
  //   snapshot.ref.getDownloadURL().then((value){
  //     Map<String,dynamic> map = {};
  //     map['image'] = value;
  //     firebaseFirestore.collection('users').doc(auth.currentUser!.uid).collection('pets').doc(petId).update(map).whenComplete((){
  //       uploadStatus.uploaded();
  //     }).onError((error, stackTrace){
  //       uploadStatus.error();
  //     });
  //   });
  // }

  Stream<QuerySnapshot> getPetsImagesVaccine(String petId){
    return fs.collection('users').doc(myUser).collection('pets').doc(petId).collection('vaccine').snapshots();
  }



  updateDesparasitacionImage(String petId) async {
    setLoading(true);
    uploadStatus.uploading();
    Map<String,dynamic> map = {};
    map['internos'] = desInter;
    map['externnos'] = desExtern;
    map['year1'] = desYear;
    map['month1'] = desMonth;
    map['day'] = desDay;
    map['year2'] = desYear2;
    map['month2'] = desMonth2;
    map['day2'] = desDay2;
    map['complete'] = false;
    map['time'] = DateTime.now();
    fs.collection('pets').doc(myUser).collection('pet').doc(petId).collection('desparasitacion').doc().set(map).whenComplete((){
      uploadStatus.uploaded();
      resetUpdate();
      setLoading(false);
    }).onError((error, stackTrace){
      uploadStatus.error();
      resetUpdate();
      setLoading(false);
    });
  }

  updateMedicalExamImage(String petId) async {
    setLoading(true);
    uploadStatus.uploading();
    String comment = '';
    if(recordTextController.text.isNotEmpty){
      comment = recordTextController.text;
    }
    else{
      comment='no comment';
    }
    if(imagePath!='-1'){
      String filename = '${petId}_MedicalExam_${DateTime.now()} .${imagePath.substring(imagePath.length-3)}';
      File file = File(imagePath);
      TaskSnapshot snapshot = await storage.ref().child('$myUser/pets/$petId/medicalExam/$filename').putFile(file);
      snapshot.ref.getDownloadURL().then((value){
        Map<String,dynamic> map = {};
        map['address'] = value;
        map['complete'] = false;
        map['comment'] = comment;
        map['time'] = DateTime.now();
        if(recordPath.isNotEmpty){
          uploadRecordFile(petId , map ,UploadRecord.medicalExam);
        }else{
          if(recordPath.length==0){
            map['record'] = '-1';
            recordPath='-1';
          }
          fs.collection('pets').doc(myUser).collection('pet').doc(petId).collection('medicalExam').doc().set(map).whenComplete((){
            uploadStatus.uploaded();
            resetUpdate();
            setLoading(false);
          }).onError((error, stackTrace){
            uploadStatus.error();
            resetUpdate();
            setLoading(false);
          });
        }
      }).onError((error, stackTrace){
        uploadStatus.error();
        resetUpdate();
        setLoading(false);
      });
    }
    else{
      Map<String,dynamic> map = {};
      map['address'] = '-1';
      map['complete'] = false;
      map['comment'] = comment;
      map['time'] = DateTime.now();
      if(recordPath.isNotEmpty){
        uploadRecordFile(petId , map ,UploadRecord.medicalExam);
      }else{
        if(recordPath.length==0){
          map['record'] = '-1';
          recordPath='-1';
        }
        fs.collection('pets').doc(myUser).collection('pet').doc(petId).collection('medicalExam').doc().set(map).whenComplete((){
          uploadStatus.uploaded();
          resetUpdate();
          setLoading(false);
        }).onError((error, stackTrace){
          uploadStatus.error();
          resetUpdate();
          setLoading(false);
        });
      }
    }
  }


  updateFotosImage(String petId) async {
    setLoading(true);
    uploadStatus.uploading();
    if(imagePath!='-1'){
      String filename = '${petId}_Fotos_${DateTime.now()} .${imagePath.substring(imagePath.length-3)}';
      File file = File(imagePath);
      TaskSnapshot snapshot = await storage.ref().child('$myUser/pets/$petId/fotos/$filename').putFile(file);
      snapshot.ref.getDownloadURL().then((value){
        Map<String,dynamic> map = {};
        map['address'] = value;
        map['time'] = DateTime.now();
        {
          fs.collection('pets').doc(myUser).collection('pet').doc(petId).collection('Fotos').doc().set(map).whenComplete((){
            print('done');
            uploadStatus.uploaded();
            resetUpdate();
            setLoading(false);
          }).onError((error, stackTrace){
            uploadStatus.error();
            resetUpdate();
            setLoading(false);
          });
        }
      }).onError((error, stackTrace){
        uploadStatus.error();
        resetUpdate();
        setLoading(false);
      });

    }}
  updateVaccineImage(String petId) async {
    setLoading(true);
    uploadStatus.uploading();
    String comment = '';
    if(recordTextController.text.isNotEmpty){
      comment = recordTextController.text;
    }
    else{
      comment='no comments';
    }
    if(imagePath!='-1'){
      String filename = '${petId}_Vaccine_${DateTime.now()} .${imagePath.substring(imagePath.length-3)}';
      File file = File(imagePath);
      TaskSnapshot snapshot = await storage.ref().child('$myUser/pets/$petId/vaccine/$filename').putFile(file);
      snapshot.ref.getDownloadURL().then((value){
        Map<String,dynamic> map = {};
        map['address'] = value;
        map['year'] = vacYear;
        map['month'] = vacMonth;
        map['day'] = vacDay;
        map['complete'] = false;
        map['comment'] = comment;
        map['time'] = DateTime.now();
        if(recordPath.isNotEmpty){
          uploadRecordFile(petId , map ,UploadRecord.vaccine);
        }else{
          print(recordPath.length);
          if(recordPath.length==0){
            map['record'] = '-1';
            recordPath='-1';
          }
          // return fs.collection('pets').doc(myUser).collection('pet').doc(petId).collection(mode).snapshots();
          fs.collection('pets').doc(myUser).collection('pet').doc(petId).collection('vaccine').doc().set(map).whenComplete((){
            if(vacYear.length>1){
              var Ryear=int.parse(vacYear);
              var Rmonth=int.parse(vacMonth);
              var Rday=int.parse(vacDay);
              setCalendarItem('vaccine', Ryear , Rmonth , Rday);
            }
            uploadStatus.uploaded();
            resetUpdate();
            setLoading(false);
          }).onError((error, stackTrace){
            print(error);
            uploadStatus.error();
            resetUpdate();
            setLoading(false);
          });
        }
      }).onError((error, stackTrace){
        uploadStatus.error();
        resetUpdate();
        setLoading(false);
      });

    }
    else{
      Map<String,dynamic> map = {};
      map['address'] = '-1';
      map['year'] = vacYear;
      map['month'] = vacMonth;
      map['day'] = vacDay;
      map['complete'] = false;
      map['comment'] = comment;
      map['time'] = DateTime.now();
      if(recordPath.isNotEmpty){
        uploadRecordFile(petId , map ,UploadRecord.vaccine);
      }else{
        print(recordPath.length);
        if(recordPath.length==0){
          map['record'] = '-1';
          recordPath='-1';
        }
        // return fs.collection('pets').doc(myUser).collection('pet').doc(petId).collection(mode).snapshots();
        fs.collection('pets').doc(myUser).collection('pet').doc(petId).collection('vaccine').doc().set(map).whenComplete((){

          if(vacYear.length>1){
            print(vacYear.length);
            var Ryear=int.parse(vacYear);
            var Rmonth=int.parse(vacMonth);
            var Rday=int.parse(vacDay);
            setCalendarItem('vaccine', Ryear , Rmonth , Rday);
          }
          uploadStatus.uploaded();
          resetUpdate();
          setLoading(false);
        }).onError((error, stackTrace){
          print(error.toString()+'2..');
          uploadStatus.error();
          resetUpdate();
          setLoading(false);
        });
      }
    }
  }
  updateVisitImage(String petId) async {
    String comment = '';
    if(recordTextController.text.isNotEmpty){
      comment = recordTextController.text;
    }
    else{
      comment='no comment';
    }
    setLoading(true);
    uploadStatus.uploading();
    if(imagePath!='-1'){
      String filename = '${petId}_Visit_${DateTime.now()} .${imagePath.substring(imagePath.length-3)}';
      File file = File(imagePath);
      TaskSnapshot snapshot = await storage.ref().child('$myUser/pets/$petId/visit/$filename').putFile(file);
      snapshot.ref.getDownloadURL().then((value){
        Map<String,dynamic> map = {};
        map['address'] = value;
        map['year'] = vacYear;
        map['month'] = vacMonth;
        map['day'] = vacDay;
        map['comment'] = comment;
        map['complete'] = false;
        map['time'] = DateTime.now();
        if( recordPath.isNotEmpty){
          uploadRecordFile(petId , map ,UploadRecord.visit);
        }else{
          if(recordPath.length==0){
            map['record'] = '-1';
            recordPath='-1';
          }
          fs.collection('pets').doc(myUser).collection('pet').doc(petId).collection('visit').doc().set(map).whenComplete((){
            if(vacYear.length>1){
              var Ryear=int.parse(vacYear);
              var Rmonth=int.parse(vacMonth);
              var Rday=int.parse(vacDay);
              setCalendarItem('visit', Ryear , Rmonth , Rday);

            }
            uploadStatus.uploaded();
            resetUpdate();
            setLoading(false);
          }).onError((error, stackTrace){
            uploadStatus.error();
            resetUpdate();
            setLoading(false);
          });
        }
      }).onError((error, stackTrace){
        uploadStatus.error();
        resetUpdate();
        setLoading(false);
      });
    }
    else{
      Map<String,dynamic> map = {};
      map['address'] = '-1';
      map['year'] = vacYear;
      map['month'] = vacMonth;
      map['day'] = vacDay;
      map['comment'] = comment;
      map['complete'] = false;
      map['time'] = DateTime.now();
      if( recordPath.isNotEmpty){
        uploadRecordFile(petId , map ,UploadRecord.visit);
      }else{
        if(recordPath.length==0){
          map['record'] = '-1';
          recordPath='-1';
        }
        fs.collection('pets').doc(myUser).collection('pet').doc(petId).collection('visit').doc().set(map).whenComplete((){
          if(vacYear.length>1){
            var Ryear=int.parse(vacYear);
            var Rmonth=int.parse(vacMonth);
            var Rday=int.parse(vacDay);
            setCalendarItem('visit', Ryear , Rmonth , Rday);
          }
          uploadStatus.uploaded();
          resetUpdate();
          setLoading(false);
        }).onError((error, stackTrace){
          uploadStatus.error();
          resetUpdate();
          setLoading(false);
        });
      }
    }

  }

  Future<QuerySnapshot> getAllmarker(String location){
    if(location == 'Veterinaria'){
      return fs.collection('location').where('category', isEqualTo: 'Veterinaria').get();
    }
    if(location == 'pet shop'){
      return fs.collection('location').where('category', isEqualTo: 'pet shop').get();
    }
    if(location == 'pet care'){
      return fs.collection('location').where('category', isEqualTo: 'pet care').get();
    }
    if(location == 'pet grooming'){
      return fs.collection('location').where('category', isEqualTo: 'pet grooming').get();
    }
    if(location == 'otros'){
      return fs.collection('location').where('category', isEqualTo: 'otros').get();
    }
    // return fs.collection('location').doc('Veterinary_establishments').collection('markers').snapshots();
    return fs.collection('location').get();
  }
  Future<QuerySnapshot> getCity(String city,String location){
    if(city != 'todo'){
      return fs.collection('location').where('category', isEqualTo: location).where('city',isEqualTo: city).get();
    }
    return fs.collection('location').get();
  }
  Stream<QuerySnapshot> getcitytips(String city){
    if(city != 'todo'){
      return fs.collection('tips').where('city',isEqualTo: city).snapshots();
    }
    return fs.collection('tips').snapshots();
  }

  Stream<QuerySnapshot> getcityadoption(String city){
    if(city != 'todo'){
      return fs.collection('adaptions').where('city',isEqualTo: city).snapshots();
    }
    return fs.collection('adaptions').snapshots();
  }
  Stream<QuerySnapshot> searchproduct(String name){
    if(name != ''){
      return fs.collection('products').where('name', isGreaterThanOrEqualTo:name).snapshots();
    }
    return fs.collection('products').snapshots();
  }




  saveCalendarItem(String petId,String mode , String Year,Month,Day){
    Map<String,dynamic> map = {};
    map['id'] = petId;
    map['mode'] = mode;
    map['year'] = Year;
    map['month'] = Month;
    map['day'] = Day;
    fs.collection('pets').doc(myUser).collection('all').add(map).whenComplete((){

    });
  }


  Stream<QuerySnapshot> getCalendarItem(){
    return fs.collection('pets').doc(myUser).collection('pet').doc(getSelectedPet).collection('calendar').snapshots();
    //   value.docs.map((e){
    //     print(e.data()['mode']);
    //     list.add(e.data());
    //   }).toList();
    //   return list;
    // }).onError((error, stackTrace){
    //   return list;
    // });
    // return list;
  }

  setCalendarItem(String mode , int year,int month , int day) {
    Map<String,dynamic> data = {};

    //data['mode'] = (mode=='vaccine'||mode=='medicalExam'||mode=='visit')?mode:othersName;
    data['mode']=mode;
    data['year'] = '$year';
    data['month'] = '$month';
    data['day'] = '$day';


    fs.collection('pets').doc(myUser).collection('pet').doc(getSelectedPet).collection('calendar')
        .add(data)
        .whenComplete(() {

    });
  }
  onDeleteCalendar(){
    print('start');

    print(fs.collection('pets').doc(myUser).collection('pet').doc(getSelectedPet).collection('calendar').doc());
    fs.collection('pets').doc(myUser).collection('pet').doc(getSelectedPet).collection('calendar').doc().delete();


  }

  checkPetReg2Validate(){
    String name = petNameController.text;
    if(name.isNotEmpty && day.isNotEmpty && month.isNotEmpty && year.isNotEmpty){
      apiStatus.login();
    }else{
      apiStatus.inputWrong();
    }
  }

  addPet(){
    if(checkRegister1 && checkRegister2){
      String name = petNameController.text;
      PetData petData = PetData('' , name: name , day: day ,month: month ,year: year , breed: breed , petType:  petType ,size:petSize, sex: sex ,image:'');
      putPetInServer(petData);
    }else{
      apiStatus.inputEmpty();
    }
  }

  putPetInServer(PetData petData){
    setLoading(true);
    Map<String,dynamic> data = {};
    data['id'] = myUser;

    fs.collection('pets').doc(myUser).set(data).whenComplete((){
      fs.collection('pets').doc(myUser).collection('pet').add(petData.toJson()).then((value){
        if(value.id != null){
          petData.id = value.id;
          fs.collection('pets').doc(myUser).collection('pet').doc(value.id).update(petData.toJson()).then((value) => data['image']='');
          apiStatus.login();
          clearInputPet();
          setLoading(false);
        }else{
          apiStatus.error();
          setLoading(false);
        }
      }).onError((error, stackTrace){
        apiStatus.error();
        setLoading(false);
      });
    }).onError((error, stackTrace){
      apiStatus.error();
      setLoading(false);
    });
  }

  signUpVet(){
    if(checkSignUpValidateVet()){
      String name = getVetNameController.text;
      String email = getVetEmailController.text;
      String password1 = getVetPassword1Controller.text;
      String number = getVetNumberController.text;
      String direction = getVetDirectionController.text;
      String nit = getVetNitController.text;
      String professional = getVetProfessionalCard.text;
      String shopName = '';
      VetData vetData = VetData('',
        name: name ,
        city: vetCity ,
        cityShop: vetCityShop,
        email: email,
        password: password1 ,
        number: number ,
        direction: direction ,
        nit: nit ,
        profession: professional,
        jobTitle: workAs ,
        expertise: expert,
        servicesRendered: services,
        shopName: shopName,
      );
      signUpEmailVet(vetData);
    }else{
      apiStatus.inputEmpty();
    }
  }

  getAllCalendarData(){

  }

  signUpEmailVet(VetData vetData) async {
    setLoading(true);
    try {
      await auth.createUserWithEmailAndPassword(
        email: vetData.email,
        password: vetData.password,
      ).then((value) {
        if (auth.currentUser != null) {
          vetData.id = auth.currentUser!.uid;
          signUpVetFs(vetData);
        } else {
          apiStatus.error();
          setLoading(false);
        }
      }).onError((error, stackTrace) {
        if(error.toString().contains('email-already-in-use')){
          apiStatus.accountAvailable();
        }else if(error.toString().contains('weak-password')){
          apiStatus.passwordWeak();
        }else{
          apiStatus.error();
        }
        setLoading(false);
      });
    } on FirebaseAuthException catch (_) {
      apiStatus.error();
      setLoading(false);
    }
  }

  signUpVetFs(VetData vetData) async {
    vetData.id = myUser;
    fs.collection('vet').doc(vetData.id).set(vetData.toJson()).then((value) {
      apiStatus.login();
      clearInputRegisterVet();
      setLoading(false);
    }).onError((error, stackTrace) {
      apiStatus.error();
      setLoading(false);
    });
  }

  signUpUser(){
    if(password1Controller.text==password2Controller.text){
      String email = emailController.text;
      String password1 = password1Controller.text;
      String password2=password2Controller.text;
      String fullName = fullNameController.text;
      UserData userData = UserData('',name: fullName, email: email,password1: password1, password2: password2);
      signUpEmail(userData);
    }else{
      apiStatus.inputEmpty();
    }
  }

  Future signUpEmail(UserData user) async {
    setLoading(true);
    try {
      await auth.createUserWithEmailAndPassword(
        email: user.email,
        password: user.password1,
      ).then((value) {
        if (auth.currentUser != null) {
          user.id = auth.currentUser!.uid;
          signUp(user);
        } else {
          apiStatus.error();
          setLoading(false);
        }
      }).onError((error, stackTrace) {
        if(error.toString().contains('email-already-in-use')){
          apiStatus.accountAvailable();
        }else if(error.toString().contains('weak-password')){
          apiStatus.passwordWeak();
        }else{
          apiStatus.error();
        }
        setLoading(false);
      });
    } on FirebaseAuthException catch (_) {
      apiStatus.error();
      setLoading(false);
    }
  }


  signIn() async {
    setLoading(true);
    String email = emailController.text;
    String password1 = password1Controller.text;
    print(email);
    print(password1);
      await auth.signInWithEmailAndPassword(
          email: email,
          password: password1
      ).then((value) {
        if (auth.currentUser != null) {
          // if(vet){
          //   fs.collection('vet').doc().get()
          // }else{
          //
          // }
          apiStatus.login();
          print('login');
          setLoading(false);
        } else {
          apiStatus.error();
          setLoading(false);
        }
      }).onError((error, stackTrace) {
        if (error.toString().contains('wrong-password')) {
          apiStatus.inputWrong();
        } else {
          apiStatus.error();
        }
        setLoading(false);
      });

  }

  bool checkSignUpValidate(String city){
    String email = emailController.text;
    String password1 = password1Controller.text;
    String password2 = password2Controller.text;
    String number = numberController.text;
    String fullName = fullNameController.text;
    if(email.isNotEmpty &&
        password1.isNotEmpty &&
        password2.isNotEmpty &&
        number.isNotEmpty &&
        fullName.isNotEmpty &&
        day.isNotEmpty &&
        month.isNotEmpty &&
        year.isNotEmpty &&
        city.isNotEmpty
    ){
      if(password1 == password2){
        return true;
      }else{
        return false;
      }
    }else{
      return false;
    }
  }

  bool checkSignUpValidateVet(){

    String name = getVetNameController.text;
    String email = getVetEmailController.text;
    String password1 = getVetPassword1Controller.text;
    String number = getVetNumberController.text;
    String direction = getVetDirectionController.text;
    String nit = getVetNitController.text;
    String professional = getVetProfessionalCard.text;

    if(name.isNotEmpty
        && email.isNotEmpty
        && password1.isNotEmpty
        && number.isNotEmpty
        && professional.isNotEmpty
        && expert.isNotEmpty
        && workAs.isNotEmpty){
      return true;
    }else{
      return false;
    }

  }

  bool checkLoginValidate() {
    String email = emailNameController.text;
    String password1 = password1Controller.text;
    if (email.isNotEmpty) {
      if (password1.isNotEmpty) {
        return true;
      } else {
        apiStatus.inputEmpty();
        return false;
      }
    } else {
      apiStatus.inputEmpty();
      return false;
    }
  }

  signUp(UserData user) async {
    user.id = myUser;
    fs.collection('users').doc(user.id).set(user.toJson()).then((value) {
      apiStatus.login();
      clearInputRegister();
      setLoading(false);
    }).onError((error, stackTrace) {
      apiStatus.error();
      setLoading(false);
    });
  }

  Future signOut(BuildContext context) async {
    await auth.signOut();
    fs.clearPersistence();
    kNavigatorBack(context);
   // kNavigator(context,  MyHomePage());
  }

}

abstract class UploadStatus {

  void error();
  void uploading();
  void uploaded();

}

abstract class ApiStatusLogin {


  void error();

  void login();

  void inputWrong();

  void inputEmpty();

  void accountAvailable();

  void passwordWeak();

}
