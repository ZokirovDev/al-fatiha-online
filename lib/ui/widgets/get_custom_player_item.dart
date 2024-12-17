import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../theme/colors.dart';

class GetCustomPlayerItem extends StatelessWidget {
  const GetCustomPlayerItem({super.key, this.url = "https://www.youtube.com/watch?v=PLHddf-1MHY", this.title =  "Fotiha surasida yo‘l qo‘yilishi mumkin\nbo‘lgan xatolar"});
  final String url;
  final String title;
  // String? videoId = YoutubePlayer.convertUrlToId("https://www.youtube.com/watch?v=PLHddf-1MHY");


  @override
  Widget build(BuildContext context) {
    YoutubePlayerController controller = YoutubePlayerController(
      initialVideoId:YoutubePlayer.convertUrlToId(url)??'PLHddf-1MHY',
      flags: YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
        showLiveFullscreenButton: true,
      ),
    );
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: AspectRatio(
        aspectRatio: 1.35,
        child: Material(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(10),
          child: Padding(padding: EdgeInsets.all(8), child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: YoutubePlayer(
                  controller: controller,
                  showVideoProgressIndicator: true,
                  progressIndicatorColor: Colors.amber,
                  progressColors: const ProgressBarColors(
                    playedColor: Colors.amber,
                    handleColor: Colors.amberAccent,
                  ),
                  onReady: () {},
                ),
              ),
              SizedBox(height: 8,),
              Text(title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.golosText().copyWith(
                    color: titleTextColor,fontWeight: FontWeight.w700,fontSize: 14
                ),)
            ],
          ),),),
      ),
    );
  }
}
