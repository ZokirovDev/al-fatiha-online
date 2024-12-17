import 'package:al_fatiha_online/utils/status.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/constants.dart';
import '../theme/colors.dart';

Widget getSendingState(double screenWidth,Duration duration, PlayerController controller,
    PlayButtonState buttonState, Function() clickPlay, Function() clickDelete,Function() clickSend) {
  return Column(children: [
    AudioFileWaveforms(
        //backgroundColor: Colors.black,
        waveformType: WaveformType.fitWidth,
        size: Size(screenWidth - 32, 48),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
          color: Colors.white,
        ),
        enableSeekGesture: true,
        continuousWaveform: false,
        playerWaveStyle: PlayerWaveStyle(
            seekLineColor: seekLineColor,
            fixedWaveColor: fixedWaveColor,
            liveWaveColor: seekLineColor,
            scaleFactor: 400,
            waveThickness: 1),
        playerController: controller),
    Padding(
      padding: const EdgeInsets.symmetric(vertical: 24.0),
      child: Text(
        formatDuration(duration),
        maxLines: 1,
        textAlign: TextAlign.center,
        style: GoogleFonts.golosText()
            .copyWith(fontSize: 14, fontWeight: FontWeight.w700),
      ),
    ),
    Material(
      color: Colors.white,
      borderRadius: BorderRadius.only(
          topRight: Radius.circular(33), topLeft: Radius.circular(33)),
      child: Padding(
        padding: const EdgeInsets.only(top: 4.0, left: 4, right: 4, bottom: 8),
        child: Row(
          children: [
            GestureDetector(
              onTap: clickPlay,
              child: Material(
                borderRadius: BorderRadius.circular(64),
                color: bottomBarBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Icon(
                    buttonState == PlayButtonState.paused
                        ? Icons.play_arrow_rounded
                        : Icons.stop,
                    color: primaryColor,
                    size: 24,
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            Expanded(
              child: Material(
                type: MaterialType.button,
                color: primaryColor,
                borderRadius: BorderRadius.circular(48),
                child: InkWell(
                  borderRadius: BorderRadius.circular(48),
                  splashColor: Color(0xff49bc82),
                  onTap: clickSend,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20.0, horizontal: 16),
                    child: Center(
                      child: Text(
                        "Yuborish",
                        style: GoogleFonts.golosText().copyWith(
                            color: Colors.white,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(
              width: 8,
            ),
            GestureDetector(
              onTap: clickDelete,
              child: Material(
                borderRadius: BorderRadius.circular(64),
                color: bottomBarBackgroundColor,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: SvgPicture.asset(icDelete),
                ),
              ),
            ),
          ],
        ),
      ),
    )
  ]);
}
