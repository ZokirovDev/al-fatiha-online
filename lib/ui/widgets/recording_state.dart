import 'package:al_fatiha_online/di/di.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constants.dart';
import 'get_record_button.dart';

Widget getRecordingState(RecorderController recorderController,
    Duration duration,
    double screenWidth, Function() onClick) {
  return Column(
    children: [
      // Padding(
      //     padding: const EdgeInsets.all(8.0),
      //     child: AudioWaveforms(
      //       enableGesture: true,
      //       recorderController: recorderController,
      //       size: Size(screenWidth / 2, 50),
      //       waveStyle: const WaveStyle(
      //         waveColor: Colors.white,
      //         extendWaveform: true,
      //         showMiddleLine: false,
      //       ),
      //       decoration:  BoxDecoration(
      //         borderRadius: BorderRadius.circular(12.0),
      //         color: const Color(0xFF1E1B26),
      //       ),
      //       padding: const EdgeInsets.only(left: 18),
      //       margin: const EdgeInsets.symmetric(horizontal: 15),
      //
      //     )),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20.0),
        child: Text(
          formatDuration(duration),
          textAlign: TextAlign.center,
          style: GoogleFonts.golosText()
              .copyWith(fontSize: 14, fontWeight: FontWeight.w700),
        ),
      ),
      GetRecordButton(
        onClick: onClick,
      )
    ],
  );
}

class RecordingState extends StatefulWidget {
  const RecordingState({super.key, required this.onClick});

  final Function() onClick;

  @override
  State<RecordingState> createState() => _RecordingStateState();
}

class _RecordingStateState extends State<RecordingState> {
  final controller = getIt<RecorderController>();

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        StreamBuilder(
          stream: controller.onCurrentDuration,
          builder: (context, snapshot) => Text(
            formatDuration(snapshot.requireData),
            textAlign: TextAlign.center,
            style: GoogleFonts.golosText()
                .copyWith(fontSize: 14, fontWeight: FontWeight.w700),
          ),
        ),
        SizedBox(
          height: 18,
        ),
        GetRecordButton(
          onClick: widget.onClick,
        )
      ],
    );
  }
}
