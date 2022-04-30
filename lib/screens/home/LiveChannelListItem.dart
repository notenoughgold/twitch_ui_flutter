import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:twitch_ui_flutter/components/TagChip.dart';
import 'package:twitch_ui_flutter/data/models/HomePageResponse.dart';

class LiveChannelItem extends StatelessWidget {
  final LiveChannels channel;
  final bool recommended;

  const LiveChannelItem({Key key, this.channel, this.recommended})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Flexible(
            flex: 4,
            child: Stack(
              children: [
                AspectRatio(
                  aspectRatio: 16 / 9,
                  child: CachedNetworkImage(
                    placeholder: (BuildContext context, _) => Container(
                      color: Colors.grey,
                    ),
                    imageUrl: channel.thumbnail,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  child: Row(
                    children: <Widget>[
                      const CircleAvatar(
                        radius: 5,
                        backgroundColor: Colors.red,
                      ),
                      const SizedBox(
                        width: 4,
                      ),
                      Text(
                        channel.views,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      )
                    ],
                  ),
                  left: 4,
                  bottom: 6,
                ),
              ],
            ),
          ),
          const SizedBox(
            width: 16.0,
          ),
          Flexible(
              flex: 6,
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Flexible(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            CircleAvatar(
                              radius: 10,
                              backgroundImage: CachedNetworkImageProvider(
                                  channel.streamerAvatar),
                            ),
                            const SizedBox(
                              width: 4,
                            ),
                            Text(
                              channel.streamerName,
                              style: const TextStyle(
                                  fontSize: 16, fontWeight: FontWeight.w600),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(channel.streamTitle),
                        const SizedBox(
                          height: 4,
                        ),
                        Text(
                          channel.categoryName,
                          style: Theme.of(context).textTheme.caption,
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        TagChip(
                          label: channel.tag,
                        )
                      ],
                    ),
                  ),
                  if (recommended)
                    IconButton(
                      icon: const Icon(Icons.more_vert),
                      onPressed: () => debugPrint('123'),
                    )
                ],
              )),
        ],
      ),
    );
  }
}
