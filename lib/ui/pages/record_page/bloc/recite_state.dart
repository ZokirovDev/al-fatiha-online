import 'package:al_fatiha_online/data/models/detail_model.dart';

import '../../../../../utils/status.dart';

class ReciteState {
  final Duration? recordingTime;
  final Duration? playingTime;
  final PlayButtonState? playButtonState;
  final RecordButtonState? recordButtonState;
  final String? path;
  final String? date;
  final bool? moveToBack;

  ReciteState(
      {
      this.playButtonState = PlayButtonState.paused,
      this.recordButtonState = RecordButtonState.init,
      this.playingTime,
      this.recordingTime,
      this.path,
      this.date,
      this.moveToBack});

  ReciteState copyWith({
    Duration? playingTime,
    Duration? recordingTime,
    RecordButtonState? recordButtonState,
    PlayButtonState? playButtonState,
    String? path,
    String? date,
    bool? moveToBack
  }) =>
      ReciteState(
        recordingTime: recordingTime ?? this.recordingTime,
        playingTime: playingTime ?? this.playingTime,
        recordButtonState: recordButtonState ?? this.recordButtonState,
        playButtonState: playButtonState ?? this.playButtonState,
        path: path ?? this.path,
        date: date ?? this.date,
        moveToBack: moveToBack ?? this.moveToBack,
      );
}
