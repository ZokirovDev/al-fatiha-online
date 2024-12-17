import 'package:al_fatiha_online/di/di.dart';
import 'package:al_fatiha_online/ui/pages/record_page/bloc/recite_bloc.dart';
import 'package:al_fatiha_online/ui/pages/record_page/bloc/recite_event.dart';
import 'package:al_fatiha_online/ui/pages/record_page/recite_page.dart';
import 'package:al_fatiha_online/ui/pages/surah_page/surah_page.dart';
import 'package:al_fatiha_online/ui/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
late ReciteBloc bloc;
void main()async{
  WidgetsFlutterBinding.ensureInitialized();
  await setup();
  bloc = ReciteBloc()..add(InitialControllers());
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(statusBarColor: backgroundColor));
    return
      MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Al Fatiha',
      theme: ThemeData(
        useMaterial3: true,
      ),
      initialRoute: SurahPage.id,
      routes: {
        SurahPage.id:(context)=>BlocProvider(create: (context) => bloc,child: SurahPage(),),
        RecitePage.id:(context)=>BlocProvider(create: (context) => bloc,child: RecitePage(),)
      }
    );
  }

}
