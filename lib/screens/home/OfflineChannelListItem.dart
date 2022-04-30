import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:twitch_ui_flutter/data/models/HomePageResponse.dart';

class OfflineChannelItem extends StatelessWidget {
  final OfflineChannels channel;
  const OfflineChannelItem({Key key, this.channel}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          CircleAvatar(
            radius: 24,
            backgroundImage: CachedNetworkImageProvider(channel.streamerAvatar),
          ),
          const SizedBox(
            width: 8,
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Text(
                channel.streamerName,
                style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
              ),
              if (int.parse(channel.newVideos) > 0)
                Text(
                  channel.newVideos + ' new videos',
                  style: Theme.of(context).textTheme.caption,
                ),
            ],
          )
        ],
      ),
    );
  }
}
