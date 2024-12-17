import 'package:al_fatiha_online/ui/pages/record_page/bloc/recite_bloc.dart';
import 'package:al_fatiha_online/ui/pages/record_page/bloc/recite_state.dart';
import 'package:al_fatiha_online/ui/pages/surah_page/surah_page.dart';
import 'package:al_fatiha_online/utils/constants.dart';
import 'package:al_fatiha_online/utils/status.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../di/di.dart';
import '../../theme/colors.dart';
import '../../widgets/get_custom_appbar.dart';
import '../../widgets/init_state.dart';

import '../../widgets/recording_state.dart';
import '../../widgets/sending_state.dart';
import 'bloc/recite_event.dart';

class RecitePage extends StatefulWidget {
  const RecitePage({super.key});
  static const id = "RecitePage";

  @override
  State<RecitePage> createState() => _RecitePageState();
}

class _RecitePageState extends State<RecitePage> {
  final recordingController = getIt<RecorderController>();
  final playingController = getIt<PlayerController>();
  var isStopped = false;

  @override
  void initState() {
    super.initState();
    // context.read<ReciteBloc>().add(InitialControllers());
    playingController.setFinishMode(finishMode: FinishMode.stop);
  }

  @override
  void dispose() {
    super.dispose();
    recordingController.dispose();
    playingController.dispose();
  }
  void listenPlayerState() {
    playingController.onPlayerStateChanged.listen(
          (event) {
        if (event == PlayerState.stopped && !isStopped) {
          playingController.stopPlayer();
          context.read<ReciteBloc>().add(DisposeEvent());
          isStopped = true;
        } else {
          isStopped = false;
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: backgroundColor,
      appBar: getCustomAppbar("Fotiha surasini qiroat qilish", () {
        Navigator.pop(context);
      }),
      body: BlocConsumer<ReciteBloc, ReciteState>(
        listener: (context, state) {
          if(state.moveToBack==true){
            Navigator.pushNamed(context,SurahPage.id,arguments: state.path);
          }
        },
          builder: (context, state) => Container(
            height: double.infinity,
            decoration: state.recordButtonState == RecordButtonState.init
                ? BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        backgroundColor,
                        Colors.white,
                        Colors.white,
                      ],
                    ),
                  )
                : BoxDecoration(color: backgroundColor),
            child: Column(
              children: [
                Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Image.asset(imgDemo),
                ),
                Expanded(
                    child: state.recordButtonState == RecordButtonState.init
                        ? getInitState(
                            () => context
                                .read<ReciteBloc>()
                                .add(StartRecordEvent()),
                          )
                        : state.recordButtonState == RecordButtonState.recording
                            ? getRecordingState(
                                recordingController,
                                state.recordingTime ?? Duration(),
                                screenWidth,
                                () => context
                                    .read<ReciteBloc>()
                                    .add(StopRecordEvent()))
                            : state.recordButtonState == RecordButtonState.sending
                                ? getSendingState(
                                    screenWidth,
                                    state.playingTime ?? Duration(),
                                    playingController,
                                    state.playButtonState ??
                                        PlayButtonState.paused,
                                    () => context
                                        .read<ReciteBloc>()
                                        .add(PlayAndPauseEvent()),
                                    () => context
                                        .read<ReciteBloc>()
                                        .add(DeleteRecordEvent()),
                                    () {context.read<ReciteBloc>().add(SendRecordEvent());},
                                  )
                                : SizedBox())
              ],
            ),
          ),
        ),
    );
  }
}
