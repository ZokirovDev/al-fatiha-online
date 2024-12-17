import 'package:al_fatiha_online/di/di.dart';
import 'package:al_fatiha_online/main.dart';
import 'package:al_fatiha_online/ui/pages/record_page/bloc/recite_bloc.dart';
import 'package:al_fatiha_online/ui/pages/record_page/bloc/recite_event.dart';
import 'package:al_fatiha_online/ui/pages/record_page/bloc/recite_state.dart';
import 'package:al_fatiha_online/ui/pages/record_page/recite_page.dart';
import 'package:al_fatiha_online/ui/theme/colors.dart';
import 'package:al_fatiha_online/ui/widgets/get_custom_appbar.dart';
import 'package:al_fatiha_online/ui/widgets/get_custom_player_item.dart';
import 'package:al_fatiha_online/utils/constants.dart';
import 'package:audio_waveforms/audio_waveforms.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../utils/status.dart';

class SurahPage extends StatefulWidget {
  const SurahPage({super.key});

  static const id = "/SurahPage";

  @override
  State<SurahPage> createState() => _SurahPageState();
}
class _SurahPageState extends State<SurahPage> {
  final  playerController = getIt<PlayerController>();
  var isStopped = false;

  @override
  void dispose() {
    super.dispose();
    playerController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    return BlocBuilder<ReciteBloc,ReciteState>(
      builder: (context, state) => Scaffold(
        backgroundColor: backgroundColor,
        appBar: getCustomAppbar("Fotiha surasi", () {}),
        body: Column(
          children: [
            SizedBox(
              height: 8,
            ),
            Expanded(
                child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Material(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                child: Column(
                  children: [
                    GetCustomPlayerItem(),
                    SizedBox(
                      height: 8,
                    ),
                    state.date == null
                        ? SizedBox()
                        : Padding(
                            padding: const EdgeInsets.only(left: 32.0, right: 8),
                            child: Container(
                              padding: EdgeInsets.all(8),
                              decoration: BoxDecoration(
                                  color: backgroundColor,
                                  borderRadius: BorderRadius.circular(10)),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      GestureDetector(
                                        onTap: () => context.read<ReciteBloc>().add(PlayAndPauseEvent()),
                                        child: Material(
                                          shape: CircleBorder(),
                                          color: seekLineColor,
                                          child: Padding(
                                            padding: const EdgeInsets.all(12.0),
                                            child: Icon(
                                              state.playButtonState ==
                                                      PlayButtonState.paused
                                                  ? Icons.play_arrow_rounded
                                                  : Icons.stop,
                                              color: Colors.white,
                                              size: 20,
                                            ),
                                          ),
                                        ),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      AudioFileWaveforms(
                                          waveformType: WaveformType.long,
                                          size: Size(screenWidth - 200, 36),
                                          enableSeekGesture: true,
                                          continuousWaveform: false,
                                          playerWaveStyle: PlayerWaveStyle(
                                              seekLineColor: seekLineColor,
                                              fixedWaveColor: fixedWaveColor,
                                              liveWaveColor: seekLineColor,
                                              scaleFactor: 400,
                                              waveThickness: 1),
                                          playerController: playerController),
                                      SizedBox(
                                        width: 12,
                                      ),
                                      Text(
                                        formatDuration(state.playingTime??Duration()),
                                        style: GoogleFonts.golosText().copyWith(
                                            color: titleTextColor, fontSize: 12),
                                      )
                                    ],
                                  ),
                                  Text(
                                    state.date ?? "null",
                                    style: GoogleFonts.golosText().copyWith(
                                        color: Color(0xff7983A9), fontSize: 12),
                                  )
                                ],
                              ),
                            ),
                          )
                  ],
                ),
              ),
            )),
            SizedBox(
              height: 8,
            ),
            Material(
              color: Colors.white,
              borderRadius: BorderRadius.only(
                  topRight: Radius.circular(33), topLeft: Radius.circular(33)),
              child: Padding(
                padding:
                    const EdgeInsets.only(top: 4.0, left: 4, right: 4, bottom: 8),
                child: Material(
                  borderRadius: BorderRadius.circular(64),
                  color: bottomBarBackgroundColor,
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        Text(
                          "Qiroatni tekshirish...",
                          style: GoogleFonts.golosText().copyWith(
                              color: secondaryTextColor,
                              fontSize: 14,
                              fontWeight: FontWeight.w500),
                        ),
                        Spacer(),
                        Material(
                          type: MaterialType.button,
                          color: state.date == null
                              ? primaryColor
                              : disableButtonColor,
                          borderRadius: BorderRadius.circular(48),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(48),
                            splashColor: state.date == null
                                ? Color(0xff49bc82)
                                : disableButtonColor,
                            onTap: () {
                              if (state.date == null) {
                                Navigator.popAndPushNamed(context, RecitePage.id);
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                  vertical: 8.0, horizontal: 16),
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Text(
                                    "Qiroat qilish",
                                    style: GoogleFonts.golosText().copyWith(
                                        color: state.date == null
                                            ? Colors.white
                                            : fixedWaveColor,
                                        fontSize: 15,
                                        fontWeight: FontWeight.w600),
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Icon(
                                    Icons.arrow_forward_ios_rounded,
                                    color: state.date == null
                                        ? Colors.white
                                        : disableButtonColor,
                                    size: 15,
                                  )
                                ],
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
