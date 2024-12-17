
abstract class DetailModel{}

class VideoData extends DetailModel{
  final String videoUrl;
  final String title;

  VideoData({required this.videoUrl, required this.title});
}

class AudioData extends DetailModel{
  final String audioUrl;

  AudioData({required this.audioUrl});
}