import 'package:get/get.dart';
import 'package:milklog/getx/binding/bd.abill.dart';
import 'package:milklog/getx/binding/bd.acustomer.dart';
import 'package:milklog/getx/binding/bd.addcustomer.dart';
import 'package:milklog/getx/binding/bd.adelivered.dart';
import 'package:milklog/getx/binding/bd.aexpense.dart';
import 'package:milklog/getx/binding/bd.aincome.dart';
import 'package:milklog/getx/binding/bd.areport.dart';
import 'package:milklog/getx/binding/bd.dcustomerprofile.dart';
import 'package:milklog/getx/binding/bd.editprofile.dart';
import 'package:milklog/getx/binding/bd.dcustomer.dart';
import 'package:milklog/getx/binding/bd.deliverystatus.dart';
import 'package:milklog/getx/binding/bd.extradelivered.dart';
import 'package:milklog/getx/binding/bd.homepage.dart';
import 'package:milklog/getx/binding/bd.login.dart';
import 'package:milklog/getx/binding/bd.profile.dart';
import 'package:milklog/getx/binding/bd.registration.dart';
import 'package:milklog/getx/binding/bd.userhome.dart';
import 'package:milklog/views/abill.dart';
import 'package:milklog/views/acustomer.dart';
import 'package:milklog/views/addcustomer.dart';
import 'package:milklog/views/adelivered.dart';
import 'package:milklog/views/aexpense.dart';
import 'package:milklog/views/aincome.dart';
import 'package:milklog/views/areport.dart';
import 'package:milklog/views/customerhome.dart';
import 'package:milklog/views/dcustomerprofile.dart';
import 'package:milklog/views/editprofile.dart';
import 'package:milklog/views/dcustomer.dart';
import 'package:milklog/views/deliverystatus.dart';
import 'package:milklog/views/extradelivered.dart';
import 'package:milklog/views/homepage.dart';
import 'package:milklog/views/login.dart';
import 'package:milklog/views/profile.dart';
import 'package:milklog/views/registration.dart';

class AppPages {
  static final pages = [
    GetPage(
      name: ('/home'),
      page: () => HomePage(),
      binding: HomePageBinding(),
    ),
    GetPage(
      name: ('/'),
      page: () => Login(),
      binding: LoginBinding(),
    ),
    GetPage(
      name: ('/register'),
      page: () => Registration(),
      binding: RegistrationBinding(),
    ),
    GetPage(
      name: ('/adelivered'),
      page: () => ADelivered(),
      binding: ADeliveredBinding(),
    ),
    GetPage(
      name: ('/acustomer'),
      page: () => ACustomer(),
      binding: ACustomerBinding(),
    ),
    GetPage(
      name: ('/dcustomer'),
      page: () => DCustomer(),
      binding: DCustomerBinding(),
    ),
    GetPage(
      name: ('/profile'),
      page: () => Profile(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: ('/editprofile'),
      page: () => EditProfilePage(),
      binding: EditProfilePageBinding(),
    ),
    GetPage(
      name: ('/dcustomerprofile'),
      page: () => DCustomerProfile(),
      binding: DCustomerProfileBinding(),
    ),
    GetPage(
      name: ('/customerhome'),
      page: () => CustomerHome(),
      binding: CustomerHomeBinding(),
    ),
    GetPage(
      name: ('/deliverystatus'),
      page: () => DeliveryStatus(),
      binding: DeliveryStatusBinding(),
    ),
    GetPage(
      name: ('/extradelivered'),
      page: () => ExtraDelivered(),
      binding: ExtraDeliveredBinding(),
    ),
    GetPage(
      name: ('/addcustomer'),
      page: () => AddCustomer(),
      binding: AddCustomerBinding(),
    ),
    GetPage(
      name: ('/abill'),
      page: () => ABill(),
      binding: ABillBindings(),
    ),
    GetPage(
      name: ('/areport'),
      page: () => AReport(),
      binding: AReportBindings(),
    ),
    GetPage(
      name: ('/aexpense'),
      page: () => AExpense(),
      binding: AExpenseBinding(),
    ),
    GetPage(
      name: ('/aincome'),
      page: () => AIncome(),
      binding: AIncomeBimding(),
    ),
  ];
}