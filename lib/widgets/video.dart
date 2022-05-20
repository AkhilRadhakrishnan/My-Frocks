import 'package:cached_network_image/cached_network_image.dart';
import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:video_player/video_player.dart';

class WidgetVideo extends StatefulWidget {
  final String url;
  final String thumbnail;
  const WidgetVideo(
      {Key key,
      @required this.url,
      @required this.thumbnail})
      : super(key: key);

  @override
  _WidgetVideoState createState() => _WidgetVideoState();
}

class _WidgetVideoState extends State<WidgetVideo> {
  VideoPlayerController videoPlayerController;
  Future<void> _initializeVideoPlayerFuture;

  @override
  void initState() {
    super.initState();
    videoPlayerController = new VideoPlayerController.network('http://myfrocks.com/App/Admin/'+widget.url);
    _initializeVideoPlayerFuture = videoPlayerController.initialize().then((_) {
      setState(() {});
    });
  }

  @override
  void dispose() {
    videoPlayerController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _initializeVideoPlayerFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.done) {
          return Container(
            height: 200,
            child: Chewie(
              key: new PageStorageKey('http://myfrocks.com/App/Admin/'+widget.url),
              controller: ChewieController(
                videoPlayerController: videoPlayerController,
                aspectRatio: 16 / 9,
                autoInitialize: false,
                showControlsOnInitialize: true,
                looping: false,
                autoPlay: false,
                deviceOrientationsAfterFullScreen: [DeviceOrientation.portraitUp],
                placeholder: CachedNetworkImage(
                  placeholder: (context, url) => Center(child: CircularProgressIndicator()),
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  imageUrl: 'http://myfrocks.com/App/Admin/'+widget.thumbnail,
                ),
                errorBuilder: (context, errorMessage) {
                  return Center(
                    child: Text(
                      errorMessage,
                      style: TextStyle(color: Colors.white),
                    ),
                  );
                },
              ),
            ),
          );
        } else {
          return CachedNetworkImage(
              height: 200,
              fit: BoxFit.fitWidth,
              placeholder: (context, url) =>
                  Center(child: CircularProgressIndicator()),
              imageUrl: 'http://myfrocks.com/App/Admin/' + widget.thumbnail);
        }
      },
    );
  }
}
