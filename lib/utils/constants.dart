
import 'package:al_fatiha_online/data/models/detail_model.dart';

final imgDemo = "assets/images/img_demo.png";
final icDelete = "assets/images/ic_delete.svg";

final recordedAudio = "recordedAudio";
final recordedDate = "recordedDate";

final detailList = <DetailModel>[
  VideoData(videoUrl: "https://www.youtube.com/watch?v=PLHddf-1MHY", title: "Fotiha surasida yo‘l qo‘yilishi mumkin\nbo‘lgan xatolar"),
];

String formatDuration(Duration duration) {
  String twoDigits(int n) => n.toString().padLeft(2, '0');
  final minutes = twoDigits(duration.inMinutes.remainder(60));
  final seconds = twoDigits(duration.inSeconds.remainder(60));
  return "$minutes:$seconds";
}