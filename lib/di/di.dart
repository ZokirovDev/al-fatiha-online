

import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';

final getIt = GetIt.instance;

Future<void> setup()async{
  getIt.registerLazySingleton<RecorderController>(() => RecorderController(),);
  getIt.registerLazySingleton<PlayerController>(() => PlayerController(),);
  getIt.registerSingleton<SharedPreferences>(await SharedPreferences.getInstance());
}