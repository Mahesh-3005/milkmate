import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:milklog/hive_model/admin.dart';
import 'package:milklog/hive_model/customer.dart';
import 'package:milklog/hive_model/delivered.dart';
import 'package:milklog/hive_model/edelivered.dart';
import 'package:milklog/hive_model/organization.dart';
import 'package:milklog/routes/app_routes.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

   // ✅ Register adapters
  Hive.registerAdapter(AdminAdapter());
  Hive.registerAdapter(CustomerAdapter());
  Hive.registerAdapter(OrganizationAdapter());
  Hive.registerAdapter(DeliveredAdapter());
  Hive.registerAdapter(EdeliveredAdapter());

  // ✅ Open Hive boxes
  await Hive.openBox<Admin>('Admin');
  await Hive.openBox<Customer>('Customer');
  await Hive.openBox<Organization>('Organization');
  await Hive.openBox<Delivered>('Delivered');
  await Hive.openBox<Edelivered>('Edelivered');

  await dotenv.load(fileName: ".env");

  // Initialize Supabase
  await Supabase.initialize(
    url: dotenv.env['SUPABASE_URL']!,
    anonKey: dotenv.env['SUPABASE_ANON_KEY']!,
  );
  runApp( 
    ScreenUtilInit(
      designSize: Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter New',
      initialRoute: '/',
      getPages: AppPages.pages,
    );
  }
}



