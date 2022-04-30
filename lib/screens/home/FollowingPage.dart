import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:twitch_ui_flutter/data/DataSource.dart';
import 'package:twitch_ui_flutter/data/models/HomePageResponse.dart';

import 'LiveChannelListItem.dart';
import 'OfflineChannelListItem.dart';

class FollowingPage extends StatelessWidget {
  const FollowingPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Future _homeResponse = DataSource.fetchFollowingPageResponse(context);

    return CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        leading: IconButton(
          icon: const CircleAvatar(
            radius: 14,
            backgroundImage: CachedNetworkImageProvider(
                'https://picsum.photos/id/1025/50/50'),
          ),
          onPressed: () => debugPrint('Action Notification'),
        ),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.notifications_none),
            onPressed: () => debugPrint('Action Notification'),
          ),
          IconButton(
            icon: const Icon(
              Icons.comment,
            ),
            onPressed: () => debugPrint('Action 2'),
          ),
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () => debugPrint('Action 3'),
          ),
        ],
        expandedHeight: 130,
        pinned: true,
        flexibleSpace: FlexibleSpaceBar(
          background: Container(
            padding: const EdgeInsets.fromLTRB(16, 0, 0, 24),
            height: 100,
            alignment: Alignment.bottomLeft,
            child: const Text('Following',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
      FutureBuilder<HomePageResponse>(
          future: _homeResponse,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(16, 20, 0, 0),
                        child: Text(
                          'LIVE CHANNELS',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).textTheme.caption.color),
                        ),
                      );
                    } else {
                      return LiveChannelItem(
                          channel: snapshot.data.liveChannels[index - 1],
                          recommended: false);
                    }
                  },
                  childCount: snapshot.data.liveChannels.length + 1,
                ),
              );
            } else {
              return const SliverFillRemaining(
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }),
      FutureBuilder<HomePageResponse>(
          future: _homeResponse,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(16, 20, 0, 0),
                        child: Text(
                          'RECOMMENDED CHANNELS',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).textTheme.caption.color),
                        ),
                      );
                    } else {
                      return LiveChannelItem(
                          channel: snapshot.data.recommendedChannels[index - 1],
                          recommended: true);
                    }
                  },
                  childCount: snapshot.data.recommendedChannels.length + 1,
                ),
              );
            } else {
              return const SliverFillRemaining(
                child: SizedBox(
                  height: 0,
                  width: 0,
                ),
              );
            }
          }),
      FutureBuilder<HomePageResponse>(
          future: _homeResponse,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (index == 0) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(16, 20, 0, 0),
                        child: Text(
                          'OFFLINE CHANNELS',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              color: Theme.of(context).textTheme.caption.color),
                        ),
                      );
                    } else {
                      return OfflineChannelItem(
                          channel: snapshot.data.offlineChannels[index - 1]);
                    }
                  },
                  childCount: snapshot.data.offlineChannels.length + 1,
                ),
              );
            } else {
              return const SliverFillRemaining(
                child: SizedBox(
                  height: 0,
                  width: 0,
                ),
              );
            }
          }),
    ]);
  }
}
