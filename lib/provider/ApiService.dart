import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';
import 'package:ressengaer_app/Authentication/confirm.dart';
import 'package:ressengaer_app/Model/ad.dart';
import 'package:ressengaer_app/Model/building.dart';
import 'package:ressengaer_app/Model/building_list.dart';
import 'package:ressengaer_app/Model/message.dart';
import 'package:ressengaer_app/Model/notice_model.dart';
import 'package:ressengaer_app/Model/property_model.dart';
import 'package:ressengaer_app/Model/service_model.dart';
import 'package:ressengaer_app/Model/user.dart';
import 'package:ressengaer_app/Model/vet.dart';
import 'package:ressengaer_app/screen/notices.dart';
import 'package:ressengaer_app/screen/residenceconfirm.dart';
import '../Authentication/login_signup.dart';
import '../Utils/custom_snackbar.dart';
import '../constants.dart';
import '../main.dart';
import '../screen/city.dart';
import '../screen/searchapartment.dart';
import 'package:http/http.dart' as http;


enum LoginStatus { error, login, isLogin, waiting, passwordWrong, emailWrong }
enum UploadData { error, upload, waiting }
enum UploadRecord { vaccine, visit, medicalExam }

class ApiService extends ChangeNotifier {
  FirebaseFirestore fs = FirebaseFirestore.instance;
  FirebaseStorage storage = FirebaseStorage.instance;
  FirebaseAuth auth = FirebaseAuth.instance;
  FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;


  // [Data] --------------------------------------------//
  String country = '';
  String city = '';
  String groupApartment = '';
  String apartment = '';
  String unit = '';
  String apartmentId = '';
  bool checkRegister1 = false;
  bool checkRegister2 = false;
  String address = '';
  String messageSent = '';
  bool vet = false;
  String selectedPet = '';
  String petId = '';
  String classifiedType = '';
  String propertyType = '';
  String adminN = '0';

  String services = '';
  String imagePath = '';
  List listimagepath = [];
  List listimagepathproperty = [];
  List image = [];
  List imageproperty = [];
  String propertyDocId = '';
  String Token = '';

  String othersName = '';

  //------------------message----------------------
  String? sender = '';
  String getter = '';
  String senderUid = '';
  String getterUid = '';
  String messageTime = '';
  String messageImage = '';
  String pm = '';
  TextEditingController messageController = TextEditingController();

  TextEditingController get getMessageController => messageController;

  //------------------message----------------------

  bool loadingAuth = false;
  bool isEmailVerified = false;

  late ApiStatusLogin apiStatus;
  late UploadStatus uploadStatus;

  // [TextEditingController] -----------------user---------------------------//
  TextEditingController emailNameController = TextEditingController();
  TextEditingController password1Controller = TextEditingController();
  TextEditingController password2Controller = TextEditingController();
  TextEditingController fullNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();

//--------------------------add building controller-------------------------
  TextEditingController buildingNameController = TextEditingController();
  TextEditingController addressController = TextEditingController();

  TextEditingController get getBuildingNameController => buildingNameController;

  TextEditingController get getAddressController => addressController;

  // GET

  bool get isAuthLoading => loadingAuth;

  bool get isVet => vet;

  ApiStatusLogin get getApiStatus => apiStatus;

  UploadStatus get getUploadStatus => uploadStatus;

  String get myUser => auth.currentUser!.uid;

  String? get myUserName => auth.currentUser!.email;

  // String get getAddress => address;
  // String get myCity => city;
  // String get myCountry => country;

//----------------------------user----------------------------------------------
  TextEditingController get getUserNameController => emailNameController;

  TextEditingController get getPassword1Controller => password1Controller;

  TextEditingController get getPassword2Controller => password2Controller;

  TextEditingController get getFullNameController => fullNameController;

  TextEditingController get getEmailController => emailController;

//----------------------------send notice---------------------------------------------
  TextEditingController sendNoticeController = TextEditingController();

  TextEditingController get getSendNoticeController => sendNoticeController;
  TextEditingController sendNoticeTitleController = TextEditingController();

  TextEditingController get getSendNoticeTitleController =>
      sendNoticeTitleController;

//------------------------residence confirm---------------------------------
  TextEditingController unitConfirmController = TextEditingController();

  TextEditingController get getUnitConfirmController => unitConfirmController;

//-------------------------postClassifiedControlle----------------------------------
  TextEditingController postClassifiedTitleController = TextEditingController();

  TextEditingController get getPostClassifiedTitleController =>
      postClassifiedTitleController;
  TextEditingController postClassifiedPriceController = TextEditingController();

  TextEditingController get getPostClassifiedPriceController =>
      postClassifiedPriceController;
  TextEditingController postClassifiedDescriptionController =
      TextEditingController();

  TextEditingController get getPostClassifiedDescriptionController =>
      postClassifiedDescriptionController;

  //---------------------post property------------------------------------------------------
  TextEditingController postPropertyTitleController = TextEditingController();

  TextEditingController get getPostPropertyTitleController =>
      postPropertyTitleController;
  TextEditingController postPropertyPriceController = TextEditingController();

  TextEditingController get getPostPropertyPriceController =>
      postPropertyPriceController;
  TextEditingController postPropertyDescriptionController =
      TextEditingController();

  TextEditingController get getPostPropertyDescriptionController =>
      postPropertyDescriptionController;

  // SET
  setGroupApartment(String val) => groupApartment = val;

  setCheckRegister1(bool val) => checkRegister1 = val;

  setCheckRegister2(bool val) => checkRegister2 = val;

  setCountry(String val) => country = val;

  setCity(String val) => city = val;

  setApartment(String val) => apartment = val;

  setMessageSender(String? val) => sender = val;

  setMessageGetter(String val) => getter = val;

  setMessageSenderUid(String val) => senderUid = val;

  setMessageGetterUid(String val) => getterUid = val;

  setMessageTime(String val) => messageTime = val;

  setMessageImage(String val) => messageImage = val;

  setApartmentId(String val) => apartmentId = val;

  setMessageSent(String val) => messageSent = val;

  setServices(String val) => services = val;

  setPetId(String val) => petId = val;

  setImagePath(String val) {
    imagePath = val;
    notifyListeners();
  }

  setListImagePath(List list) {
    listimagepath = list;
    notifyListeners();
  }
  setListImagePathproperty(List list) {
    listimagepathproperty = list;
    notifyListeners();
  }

  setPropertyDocId(String val) {
    propertyDocId = val;
  }

  setSelectedPet(String val) {
    selectedPet = val;
    notifyListeners();
  }

  setClassifiedType(String val) => classifiedType = val;

  setPropertyType(String val) => propertyType = val;

  setOthers(String name) {
    othersName = name;
  }

  setVet(bool b) => vet = b;

  clearInputPet() {
    buildingNameController.text = '';
    address = '';
    adminN = '';

    notifyListeners();
  }

  clearInputRegister() {
    emailNameController.text = '';
    password1Controller.text = '';
    password2Controller.text = '';
    fullNameController.text = '';
    emailController.text = '';
    adminN = '';

    notifyListeners();
  }

  clearInputRegisterVet() {
    // vetDirectionController.text = '';

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

  bool checkLogin() {
    if (auth.currentUser == null) {
      return false;
    } else {
      return true;
    }
  }

  Stream<QuerySnapshot> getAllMyPosts() {
    return fs.collection('users').doc(myUser).collection('posts').snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getalltest() {
    return fs.collection('test').doc(myUser).get();
  }

  Stream<QuerySnapshot> getCountry() {
    return fs.collection('country').snapshots();
  }

  Stream<QuerySnapshot> getCity(countryName) {
    return fs
        .collection('country')
        .doc(countryName)
        .collection('city')
        .snapshots();
  }

  Stream<QuerySnapshot> getApartment() {
    return fs.collection('apartment_list').snapshots();
  }

  Stream<QuerySnapshot> getApartment2(String query) {
    return fs
        .collection('apartment_list')
        .where('name', isGreaterThanOrEqualTo: query)
        .snapshots();
  }

  Stream<QuerySnapshot> getBanner() {
    return fs.collection('banner').snapshots();
  }

  Future<String> getImageProfileLink(petId) async {
    DocumentSnapshot documentSnapshot = await fs
        .collection('pets')
        .doc(myUser)
        .collection('pet')
        .doc(petId)
        .get();
    return documentSnapshot.get('image');
  }

  updateProfileImage(String path) async {
    String filename =
        '${auth.currentUser!.uid}.${path.substring(path.length - 3)}';
    File file = File(path);
    TaskSnapshot snapshot =
        await storage.ref().child('$myUser/profile/$filename').putFile(file);
    snapshot.ref.getDownloadURL().then((value) {
      Map<String, dynamic> map = {};
      map['image'] = value;
      fs
          .collection('users')
          .doc(auth.currentUser!.uid)
          .update(map)
          .whenComplete(() {
        uploadStatus.uploaded();
        print('--------------------------------------------------');
        print(snapshot.ref.getDownloadURL());
      }).onError((error, stackTrace) {
        uploadStatus.error();
      });
    });
  }

   submitclassifieds(context) async {
    for (int i = 0; i < listimagepath.length; i++) {
      String filename =
          '${myUser}_classified_${DateTime.now()} .${listimagepath[i].substring(listimagepath[i].length - 3)}';
      File file = File(listimagepath[i]);
      TaskSnapshot snapshot = await storage
          .ref()
          .child('$myUser/classifieds/$filename')
          .putFile(file);
      await snapshot.ref.getDownloadURL().then((value){
        image.add(value);
        print(value);
      }).onError((error, stackTrace) {
        ModeSnackBar.show(context, 'try again', SnackBarMode.error);
        print('-------------------------------------');
        print(error);
      });
    }

  }

  checktoken()async{
    var box = await Hive.openBox('Token');
    if(box.isEmpty){
      _firebaseMessaging.getToken(
          vapidKey: 'BDg8n01p3KOPp2cahWXFb4rfmJv4w3eu3UnWuUHomuvxmWp3WGAyYmMOyAgEUXsVVmwrRoSf5fVEnur3S470igs'
      ).then((val) async {
        print('Token: '+val!);
        Map<String,dynamic> data = {
          'token' : val
        };
        await fs.collection('Token').doc(myUser).set(data).whenComplete(() async{
          await box.put('token', val);
          Token = val;
        });
      });
    }
    else{
      String token = await box.get('token');
      Token = token;
    }
  }


  Future<void> sendNotificationMessageToPeerUser(text , username,image,getter) async {
    DocumentSnapshot documentSnapshot = await fs
        .collection('Token')
        .doc(getter)
        .get();
    String token = documentSnapshot.get('token');
    print(token);
    print(image);
    // FirebaseMessaging _firebaseMessaging = FirebaseMessaging.instance;
    try{
      await http.post(
        // 'https://fcm.googleapis.com/fcm/send',
        // 'https://api.rnfirebase.io/messaging/send',
        Uri.parse('https://fcm.googleapis.com/fcm/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
          'Authorization': 'key=AAAAgAyYEKA:APA91bHrw3zl9skkX3L07QeCELhoGh0_yvUIXN7K3txtJE3mGdoOf1EV6U0AwP3OOfxR5AnNtZ0vo-g4tixlVavRmquGb65KDWdvTn3uh3vbwxU1rSu8QN6D_MO5fSb_KvsDzOJxOAe6 ',
        },
        body: jsonEncode(
          <String, dynamic>{
            'notification': <String, dynamic>{
              'body': text,
              'title': username,
              "sound" : "default",
              "image" : 'https://images.unsplash.com/photo-1553095066-5014bc7b7f2d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8d2FsbCUyMGJhY2tncm91bmR8ZW58MHx8MHx8&w=1000&q=80'
            },
            // 'priority': 'high',
            'data': <String, dynamic>{
              'click_action': 'FLUTTER_NOTIFICATION_CLICK',
              'id': '1',
              'status': 'done',
              'chatroomid': 1,
              'userImage':'https://images.unsplash.com/photo-1553095066-5014bc7b7f2d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8d2FsbCUyMGJhY2tncm91bmR8ZW58MHx8MHx8&w=1000&q=80',
              'userName':username,
              'message': text,
            },
            'to': token,
          },
        ),
      );
    } catch (e) {
      print(e);
    }
  }


  submitClassifiedPost(context) async {
    setLoading(true);
    List list = [];
    String title = '';
    {
      if (listimagepath.isNotEmpty) {
        await submitclassifieds(context);
        adData AdData = adData(
            category: classifiedType,
            title: postClassifiedTitleController.text,
            description: postClassifiedDescriptionController.text,
            time: (DateFormat.yMMMMEEEEd().add_Hm().format(DateTime.now())),
            image: image,
            price: postClassifiedPriceController.text,
            sender: myUser,
            senderName: myUserName);
        print(AdData.image);
        fs
            .collection('apartment')
            .doc(groupApartment)
            .collection('classifieds')
            .doc(classifiedType)
            .collection('ads')
            .add(AdData.toJson())
            .then((value) => {
                  fs
                      .collection('users')
                      .doc(myUser)
                      .collection('posts')
                      .add(AdData.toJson())
                })
            .whenComplete(() {
          ModeSnackBar.show(context, 'posted', SnackBarMode.success);
          kNavigatorBack(context);
        }).onError((error, stackTrace) {
          print(error);
          return ModeSnackBar.show(context, 'try again', SnackBarMode.error);
        });
      } else {
        adData AdData = adData(
            category: classifiedType,
            title: postClassifiedTitleController.text,
            description: postClassifiedDescriptionController.text,
            time: (DateFormat.yMMMMEEEEd().add_Hm().format(DateTime.now())),
            image: [],
            price: postClassifiedPriceController.text,
            sender: myUser,
            senderName: myUserName);
        fs
            .collection('apartment')
            .doc(groupApartment)
            .collection('classifieds')
            .doc(classifiedType)
            .collection('ads')
            .add(AdData.toJson())
            .then((value) => {
                  fs
                      .collection('users')
                      .doc(myUser)
                      .collection('posts')
                      .add(AdData.toJson())
                })
            .whenComplete(() {
          ModeSnackBar.show(context, 'posted', SnackBarMode.success);
          kNavigatorBack(context);
        }).onError((error, stackTrace) {
          print(error);
          return ModeSnackBar.show(context, 'try again', SnackBarMode.error);
        });
      }
    }
  }

  submitproperty(context)async{
    for(int i = 0 ; i< listimagepathproperty.length;i++){
      String filename =
          '${myUser}_property_${DateTime.now()} .${listimagepathproperty[i].substring(listimagepathproperty[i].length - 3)}';
      File file = File(listimagepathproperty[i]);
      TaskSnapshot snapshot = await storage
          .ref()
          .child('$myUser/classifieds/$filename')
          .putFile(file);
      await snapshot.ref.getDownloadURL().then((value){
        imageproperty.add(value);
        print(value);
      }).onError((error, stackTrace) {
        ModeSnackBar.show(context, 'try again', SnackBarMode.error);
        print(error);
      });
    }
  }

  submitPropertyPost(context) async {
    setLoading(true);

    String title = '';
    {
      if (listimagepathproperty.isNotEmpty) {
        await submitproperty(context);
        PropertyData propertyData = PropertyData(
            title: postPropertyTitleController.text,
            description: postPropertyDescriptionController.text,
            time: (DateFormat.yMMMMEEEEd().add_Hm().format(DateTime.now())),
            image: imageproperty,
            price: postPropertyPriceController.text,
            sender: myUser,
            sale: propertyType,
            rent: propertyType,
            senderName: myUserName);
        print(propertyData.image);
        fs
            .collection('apartment')
            .doc(groupApartment)
            .collection('property')
            .add(propertyData.toJson())
            .then((value) => {
          fs
              .collection('users')
              .doc(myUser)
              .collection('posts')
              .add(propertyData.toJson())
        })
            .whenComplete(() {
          ModeSnackBar.show(context, 'posted', SnackBarMode.success);
          kNavigatorBack(context);
        }).onError((error, stackTrace) {
          print(error);
          return ModeSnackBar.show(context, 'try again', SnackBarMode.error);
        });

      } else {
        PropertyData propertyData = PropertyData(
            title: postClassifiedTitleController.text,
            description: postClassifiedDescriptionController.text,
            time: (DateFormat.yMMMMEEEEd().add_Hm().format(DateTime.now())),
            image: [],
            price: postClassifiedPriceController.text,
            sender: myUser,
            rent: propertyType,
            sale: propertyType,
            senderName: myUserName);
        fs
            .collection('apartment')
            .doc(groupApartment)
            .collection('property')
            .add(propertyData.toJson())
            .then((value) => {
                  fs
                      .collection('users')
                      .doc(myUser)
                      .collection('posts')
                      .add(propertyData.toJson())
                })
            .whenComplete(() {
          ModeSnackBar.show(context, 'posted', SnackBarMode.success);
          kNavigatorBack(context);
        }).onError((error, stackTrace) {
          print(error);
          return ModeSnackBar.show(context, 'try again', SnackBarMode.error);
        });
      }
    }
  }

  updateProfileUserImage(
    String path,
  ) async {
    String filename = '$myUser.${path.substring(path.length - 3)}';
    File file = File(path);
    TaskSnapshot snapshot =
        await storage.ref().child('$myUser/profilePic/$filename').putFile(file);
    snapshot.ref.getDownloadURL().then((value) {
      Map<String, dynamic> map = {};
      map['image'] = value;
      fs.collection('users').doc(myUser).update(map).whenComplete(() {
        uploadStatus.uploaded();
        print('done');
      }).onError((error, stackTrace) {
        uploadStatus.error();
      });
    });
  }

  updateCity(
    context,
    city,
  ) {
    Map<String, dynamic> map = {};
    map['city'] = city;
    fs.collection('users').doc(myUser).update(map).whenComplete(() {
      kNavigator(
          context,
          SearchApartment(
            previusScreen: '',
          ));
      uploadStatus.uploaded();
    }).onError((error, stackTrace) {
      uploadStatus.error();
    });
  }

  updateCountry(
    context,
    country,
  ) {
    Map<String, dynamic> map = {};
    map['country'] = country;
    fs.collection('users').doc(myUser).update(map).whenComplete(() {
      kNavigator(
          context,
          SelectCity(
            previosScreen: 'confirm',
            countryName: country,
          ));
    }).onError((error, stackTrace) {});
  }

  updateApartment(context) {
    if (context != '-1') {
      Map<String, dynamic> map = {};
      map['apartment'] = apartment;
      map['apartmentId'] = apartmentId;
      fs.collection('users').doc(myUser).update(map).whenComplete(() {
        ModeSnackBar.show(context, 'success', SnackBarMode.success);
        kNavigator(context, ResidenceConfirm());
      }).onError((error, stackTrace) {
        ModeSnackBar.show(context, 'try again', SnackBarMode.error);
      });
    } else {
      Map<String, dynamic> map = {};
      map['apartment'] = apartment;
      map['apartmentId'] = apartmentId;
      fs.collection('users').doc(myUser).update(map);
    }
  }

  updateUnit(context) {
    Map<String, dynamic> map = {};
    map['unit'] = unitConfirmController.text;
    print(unitConfirmController.text);

    fs.collection('users').doc(myUser).update(map).whenComplete(() {
      ModeSnackBar.show(context, 'success', SnackBarMode.success);
      kNavigator(context, Notices());
    }).onError((error, stackTrace) {
      print(error);
      ModeSnackBar.show(context, 'try again', SnackBarMode.error);
    });
  }

  Stream<QuerySnapshot> getPetsImagesVaccine(String petId) {
    return fs
        .collection('users')
        .doc(myUser)
        .collection('pets')
        .doc(petId)
        .collection('vaccine')
        .snapshots();
  }

  setCalendarItem(List mode, int year, int month, int day) {
    Map<String, dynamic> data = {};

    //data['mode'] = (mode=='vaccine'||mode=='medicalExam'||mode=='visit')?mode:othersName;
    data['mode'] = mode;
    data['year'] = '$year';
    data['month'] = '$month';
    data['day'] = '$day';

    fs
        .collection('pets')
        .doc(myUser)
        .collection('pet')
        .add(data)
        .whenComplete(() {});
  }

  addMyBuilding(context) {
    String buildingName = buildingNameController.text;
    String name = fullNameController.text;
    String address = addressController.text;
    print(name);

    BuildingData buildingData = BuildingData(
      id: '',
      name: buildingName,
      adminName: name,
      city: city,
      country: country,
      address: address,
    );

    putBuildingInServer(buildingData, context);
  }

  putBuildingInServer(BuildingData buildingData, context) {
    setLoading(true);
    Map<String, dynamic> data = {};
    apartmentId = myUser;
    apartment = buildingNameController.text;
    updateApartment('-1');
    data['id'] = myUser;
    String name = buildingNameController.text;
    fs.collection('apartment').doc(myUser).set(data).whenComplete(() {
      fs
          .collection('apartment')
          .doc(myUser)
          .collection('apartment')
          .add(buildingData.toJson())
          .then((value) {
        if (value.id != null) {
          buildingData.id = value.id;
          fs
              .collection('apartment')
              .doc(myUser)
              .collection('apartment')
              .doc(value.id)
              .update(buildingData.toJson())
              .then((value) {
            adData AdData = adData(
                category: '',
                title: '',
                description: '',
                time: '',
                image: [],
                price: '',
                sender: '',
                senderName: '');
            Message message = Message('', '', '', '',
                getterUid: '',
                image: '',
                senderUid: '',
                getter: '',
                sender: '',
                time: '',
                pm: '');
            NoticeData noticeData =
                NoticeData(title: '', description: '', time: '');
            ServiceData serviceData = ServiceData(
                category: '',
                title: '',
                description: '',
                image: '',
                telephone: '',
                mobile: '',
                email: '',
                website: '',
                instagram: '',
                facebook: '',
                twitter: '',
                linkedin: '');
            PropertyData propertyData = PropertyData(
                sender: '',
                title: '',
                description: '',
                time: '',
                image: [],
                price: '',
                rent: '',
                sale: '',
                senderName: '');
            BuildingListData buildingListData =
                BuildingListData(id: myUser, name: name);
            fs
                .collection('apartment')
                .doc(myUser)
                .collection('classifieds')
                .doc('Electronics')
                .collection('ads')
                .add(AdData.toJson())
                .then((value) => fs
                    .collection('apartment')
                    .doc(myUser)
                    .collection('classifieds')
                    .doc('Home & Garden')
                    .collection('ads')
                    .add(AdData.toJson()))
                .then((value) => fs
                    .collection('apartment')
                    .doc(myUser)
                    .collection('classifieds')
                    .doc('Automotive Vehicles')
                    .collection('ads')
                    .add(AdData.toJson()))
                .then((value) => fs
                    .collection('apartment')
                    .doc(myUser)
                    .collection('classifieds')
                    .doc('Baby & Kids')
                    .collection('ads')
                    .add(AdData.toJson()))
                .then((value) => fs
                    .collection('apartment')
                    .doc(myUser)
                    .collection('classifieds')
                    .doc('Fashion')
                    .collection('ads')
                    .add(AdData.toJson()))
                .then((value) => fs
                    .collection('apartment')
                    .doc(myUser)
                    .collection('classifieds')
                    .doc('Pets')
                    .collection('ads')
                    .add(AdData.toJson()))
                .then((value) => fs
                    .collection('apartment')
                    .doc(myUser)
                    .collection('classifieds')
                    .doc('Sports & Leisure')
                    .collection('ads')
                    .add(AdData.toJson()))
                .then(
                    (value) => fs.collection('apartment').doc(myUser).collection('classifieds').doc('Services').collection('ads').add(AdData.toJson()))
                .then((value) => fs.collection('apartment').doc(myUser).collection('classifieds').doc('Lost & Found').collection('ads').add(AdData.toJson()))
                .then((value) => fs.collection('apartment').doc(myUser).collection('classifieds').doc('Charity').collection('ads').add(AdData.toJson()))
                .then((value) => fs.collection('apartment').doc(myUser).collection('classifieds').doc('Community').collection('ads').add(AdData.toJson()))
                .then((value) => fs.collection('apartment').doc(myUser).collection('notices').add(noticeData.toJson()))
                .then((value) => fs.collection('apartment').doc(myUser).collection('members').add(AdData.toJson()))
                ////////////////////////////////////////
                .then((value) => fs.collection('apartment').doc(myUser).collection('services').doc('Automotive').collection('ads').add(serviceData.toJson()))
                .then((value) => fs.collection('apartment').doc(myUser).collection('services').doc('Child Care').collection('ads').add(serviceData.toJson()))
                .then((value) => fs.collection('apartment').doc(myUser).collection('services').doc('Cleaning').collection('ads').add(serviceData.toJson()))
                .then((value) => fs.collection('apartment').doc(myUser).collection('services').doc('Construction').collection('ads').add(serviceData.toJson()))
                .then((value) => fs.collection('apartment').doc(myUser).collection('services').doc('Dj & Entertainment').collection('ads').add(serviceData.toJson()))
                .then((value) => fs.collection('apartment').doc(myUser).collection('services').doc('DSTV').collection('ads').add(serviceData.toJson()))
                .then((value) => fs.collection('apartment').doc(myUser).collection('services').doc('Educational').collection('ads').add(serviceData.toJson()))
                .then((value) => fs.collection('apartment').doc(myUser).collection('services').doc('Electronically').collection('ads').add(serviceData.toJson()))
                .then((value) => fs.collection('apartment').doc(myUser).collection('services').doc('Event Services').collection('ads').add(serviceData.toJson()))
                .then((value) => fs.collection('apartment').doc(myUser).collection('services').doc('Handyman').collection('ads').add(serviceData.toJson()))
                .then((value) => fs.collection('apartment').doc(myUser).collection('services').doc('Health & Beauty').collection('ads').add(serviceData.toJson()))
                .then((value) => fs.collection('apartment').doc(myUser).collection('property').add(propertyData.toJson()))
                .then((value) => fs.collection('apartment_list').add(buildingListData.toJson()))
                .then((value) => fs.collection('apartment').doc(myUser).collection('message').add(message.toJson()));
          }).whenComplete(() {
            ModeSnackBar.show(context, ' added', SnackBarMode.success);
            kNavigator(context, SearchApartment(previusScreen: ''));
          });

          clearInputPet();
        } else {
          ModeSnackBar.show(context, ' try again', SnackBarMode.error);
        }
      }).onError((error, stackTrace) {
        ModeSnackBar.show(context, ' try again', SnackBarMode.error);
      });
    }).onError((error, stackTrace) {
      ModeSnackBar.show(context, ' try again', SnackBarMode.error);
    });
  }

  sendNoticeService(context) {
    String notice = '';
    if (sendNoticeController.text.isNotEmpty) {
      notice = sendNoticeController.text;
    }
    String titleNotice = '';
    titleNotice = sendNoticeTitleController.text;
    NoticeData noticeData = NoticeData(
        title: titleNotice,
        description: notice,
        time: (DateFormat.yMMMMEEEEd().add_Hm().format(DateTime.now()))
            .toString());
    Map<String, dynamic> map = {};
    map['notice'] = notice;
    fs
        .collection('apartment')
        .doc(myUser)
        .collection('notices')
        .add(noticeData.toJson())
        .whenComplete(() {
      sendNoticeTitleController.text = '';
      sendNoticeController.text = '';
      ModeSnackBar.show(context, ' sent', SnackBarMode.success);
      kNavigatorBack(context);
    });
  }

  Stream<QuerySnapshot> getAllNotice(myApartment) {
    groupApartment = myApartment;
    return fs
        .collection('apartment')
        .doc(myApartment)
        .collection('notices')
        .orderBy('time', descending: true)
        .snapshots();
  }

  sendMessage(context) async {
    print(messageImage);
    if (imagePath.isNotEmpty) {
      String filename =
          '${petId}_Vaccine_${DateTime.now()} .${imagePath.substring(imagePath.length - 3)}';
      File file = File(imagePath);
      TaskSnapshot snapshot = await storage
          .ref()
          .child('$myUser/pets/$petId/vaccine/$filename')
          .putFile(file);
      snapshot.ref.getDownloadURL().then((value) {
        Message message = Message('', '', '''''', '',
            sender: sender,
            getter: getter,
            senderUid: senderUid,
            getterUid: getterUid,
            image: value,
            time: messageTime,
            pm: messageController.text);
        sendNotificationMessageToPeerUser('(Photo)', sender, value, getterUid);
        Map<String, dynamic> map = {};
        map['senderUidDoc'] = senderUid;
        map['getterUidDoc'] = getterUid;
        map['senderDoc'] = sender;
        map['getterDoc'] = getter;
        map['time'] = DateTime.now();

        fs
            .collection('users')
            .doc(senderUid)
            .collection('message')
            .doc(getterUid)
            .set(map)
            .then((value) => {
                  fs
                      .collection('users')
                      .doc(senderUid)
                      .collection('message')
                      .doc(getterUid)
                      .collection('chats')
                      .add(message.toJson())
                })
            .then((value) => fs
                    .collection('users')
                    .doc(getterUid)
                    .collection('message')
                    .doc(senderUid)
                    .set(map)
                    .then((value) => {
                          fs
                              .collection('users')
                              .doc(getterUid)
                              .collection('message')
                              .doc(senderUid)
                              .collection('chats')
                              .add(message.toJson())
                        })
                    .whenComplete(() {
                  setMessageSent('sent');
                  messageController.text = '';
                  imagePath = '';
                  setMessageImage('');
                  notifyListeners();
                  // ModeSnackBar.show(context, ' sent', SnackBarMode.success);
                  // kNavigatorBack(context);
                }));
      }).onError((error, stackTrace) {
        print(error);
      });
    } else {
      sendNotificationMessageToPeerUser(messageController.text, sender, '', getterUid);
      Message message = Message('', '', '''''', '',
          sender: sender,
          getter: getter,
          senderUid: senderUid,
          getterUid: getterUid,
          image: messageImage,
          time: messageTime,
          pm: messageController.text);
      Map<String, dynamic> map = {};
      map['senderUidDoc'] = senderUid;
      map['getterUidDoc'] = getterUid;
      map['senderDoc'] = sender;
      map['getterDoc'] = getter;
      map['time'] = DateTime.now();
      fs
          .collection('users')
          .doc(senderUid)
          .collection('message')
          .doc(getterUid)
          .set(map)
          .then((value) => {
                fs
                    .collection('users')
                    .doc(senderUid)
                    .collection('message')
                    .doc(getterUid)
                    .collection('chats')
                    .add(message.toJson())
              })
          .then((value) => fs
                  .collection('users')
                  .doc(getterUid)
                  .collection('message')
                  .doc(senderUid)
                  .set(map)
                  .then((value) => {
                        fs
                            .collection('users')
                            .doc(getterUid)
                            .collection('message')
                            .doc(senderUid)
                            .collection('chats')
                            .add(message.toJson())
                      })
                  .whenComplete(() {
        messageController.text = '';
                imagePath = '';
                setMessageImage('');
                // ModeSnackBar.show(context, ' sent', SnackBarMode.success);
                // kNavigatorBack(context);
              }));
    }
  }

  Stream<QuerySnapshot> getAllMessageList() {
    return fs
        .collection('users')
        .doc(myUser)
        .collection('message')
        .orderBy('time', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getAllMessageDetails(whichDoc) {
    return fs
        .collection('users')
        .doc(myUser)
        .collection('message')
        .doc(whichDoc)
        .collection('chats')
        .orderBy('time', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getAllClassifiedAds(myApartment, category) {
    return fs
        .collection('apartment')
        .doc(myApartment)
        .collection('classifieds')
        .doc(category)
        .collection('ads')
        .orderBy('time')
        .snapshots();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getClassifiedAdsDetails(
      myApartment, category, documentId) {
    return fs
        .collection('apartment')
        .doc(myApartment)
        .collection('classifieds')
        .doc(category)
        .collection('ads')
        .doc(documentId)
        .get();
  }

  Future<DocumentSnapshot<Map<String, dynamic>>> getPropertyAdsDetails(
      documentId) {
    return fs
        .collection('apartment')
        .doc(groupApartment)
        .collection('property')
        .doc(documentId)
        .get();
  }

  Stream<QuerySnapshot> getAllServiceAds(category) {
    print(fs.collection('services').doc(category).collection('ads').doc().path);

    return fs
        .collection('services')
        .doc(category)
        .collection('ads')
        .orderBy('time')
        .snapshots();
  }

  Stream<QuerySnapshot> getAllPropertyItems(myApartment) {
    return fs
        .collection('apartment')
        .doc(myApartment)
        .collection('property')
        .orderBy('time', descending: true)
        .snapshots();
  }

  Stream<QuerySnapshot> getAllClassifieds(myApartment) {
    return fs
        .collection('apartment')
        .doc(myApartment)
        .collection('classifieds')
        .snapshots();
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

  signUpUser() {
    if (password1Controller.text == password2Controller.text) {
      String email = emailController.text;
      String password1 = password1Controller.text;
      String password2 = password2Controller.text;
      String fullName = fullNameController.text;
      UserData userData = UserData('',
          name: fullName,
          email: email,
          password1: password1,
          password2: password2,
          admin: 'false',
          image: '',
          country: '',
          city: '',
          apartment: '',
          unit: '',
          apartmentId: '');
      signUpEmail(userData);
    } else {
      apiStatus.inputEmpty();
    }
  }

  Future signUpEmail(UserData user) async {
    setLoading(true);
    try {
      await auth
          .createUserWithEmailAndPassword(
        email: user.email,
        password: user.password1,
      )
          .then((value) {
        if (auth.currentUser != null) {
          user.id = auth.currentUser!.uid;
          signUp(user);
        } else {
          apiStatus.error();
          setLoading(false);
        }
      }).onError((error, stackTrace) {
        if (error.toString().contains('email-already-in-use')) {
          apiStatus.accountAvailable();
        } else if (error.toString().contains('weak-password')) {
          apiStatus.passwordWeak();
        } else {
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
    await auth
        .signInWithEmailAndPassword(email: email, password: password1)
        .then((value) {
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

  bool checkSignUpValidate(String city) {
    String email = emailController.text;
    String password1 = password1Controller.text;
    String password2 = password2Controller.text;
    String fullName = fullNameController.text;
    if (email.isNotEmpty &&
        password1.isNotEmpty &&
        password2.isNotEmpty &&
        fullName.isNotEmpty &&
        adminN.isNotEmpty &&
        city.isNotEmpty) {
      if (password1 == password2) {
        return true;
      } else {
        return false;
      }
    } else {
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
    kNavigator(context, LoginOrSignup());
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
