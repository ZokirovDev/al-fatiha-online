import 'package:al_fatiha_online/di/di.dart';
import 'package:al_fatiha_online/ui/pages/record_page/bloc/recite_event.dart';
import 'package:al_fatiha_online/ui/pages/record_page/bloc/recite_state.dart';
import 'package:al_fatiha_online/utils/constants.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:path_provider/path_provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../utils/status.dart';

class ReciteBloc extends Bloc<ReciteEvent, ReciteState> {
  final recordController = getIt<RecorderController>();
  final playerController = getIt<PlayerController>();
  final pref = getIt<SharedPreferences>();

  ReciteBloc() : super(ReciteState()) {
    on<CheckPermissionEvent>((event, emit) {
      recordController.checkPermission();
    });

    on<PlayerAttachToListeners>((event, emit) async {
      await playerController.onCurrentDurationChanged.forEach(
        (duration) {
          emit(state.copyWith(playingTime: Duration(milliseconds: duration)));
        },
      );
      await playerController.onCompletion.forEach(
        (element) {
          playerController.stopPlayer();
          playerController.preparePlayer(path: state.path ?? "");
        },
      );
    });
    on<InitialControllers>((event, emit) async {
      add(PlayerAttachToListeners());
      recordController
        ..androidEncoder = AndroidEncoder.aac
        ..androidOutputFormat = AndroidOutputFormat.mpeg4
        ..iosEncoder = IosEncoder.kAudioFormatMPEG4AAC
        ..sampleRate = 16000;

      add(RecorderAttachToListeners());
      final directory = await getApplicationDocumentsDirectory();
      final url = pref.getString(recordedAudio);
      if(url!=null){
        playerController.preparePlayer(path: url);
      emit(state.copyWith(path: url,date: pref.getString(recordedDate)));
      }else{
      emit(state.copyWith(path: "${directory.path}/test_audio.aac",date: null));
      }
    });
    on<RecorderAttachToListeners>((event, emit) async {
      await recordController.onCurrentDuration.forEach(
        (duration) {
          emit(state.copyWith(recordingTime: duration));
        },
      );
    });
    on<StartRecordEvent>((event, emit) async {
      await recordController.record(path: state.path);
      emit(state.copyWith(recordButtonState: RecordButtonState.recording));
    });
    on<StopRecordEvent>((event, emit) async {
      final url = await recordController.stop() ?? "";
      playerController.preparePlayer(path: url);
      emit(state.copyWith(
          path: url,
          playingTime: state.recordingTime,
          recordButtonState: RecordButtonState.sending));
    });
    on<DeleteRecordEvent>((event, emit) {
      playerController.stopAllPlayers();
      emit(state.copyWith(
          recordButtonState: RecordButtonState.init,
          playButtonState: PlayButtonState.paused));
    });
    on<SendRecordEvent>((event, emit) async {
      await pref.setString(recordedAudio, state.path ?? "");
      final time = DateTime.now();
      final date = "${time.hour}:${time.minute}, ${time.day}.${time.month}.${time.year}";
      await pref.setString(recordedDate,date);
      playerController.stopPlayer();
      emit(state.copyWith(moveToBack: true,date: date));
    });
    on<PlayAndPauseEvent>((event, emit) async {
      playerController.playerState == PlayerState.playing
          ? await playerController.pausePlayer()
          : await playerController.startPlayer();
      playerController.playerState == PlayerState.stopped?{playerController.stopPlayer(),playerController.preparePlayer(path: state.path??"")}:{};
      playerController.playerState == PlayerState.playing
          ? emit(state.copyWith(playButtonState: PlayButtonState.playing))
          : emit(state.copyWith(playButtonState: PlayButtonState.paused));
    });
    on<DisposeEvent>((event, emit) {
      playerController.preparePlayer(path: state.path??"");
      emit(state.copyWith(playButtonState: PlayButtonState.paused));
    });
  }

// @override
// Future<void> close() {
//   recordController.dispose();
//   playerController.dispose();
//   return super.close();
// }
}
