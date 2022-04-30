import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:twitch_ui_flutter/components/TagChip.dart';
import 'package:twitch_ui_flutter/data/DataSource.dart';
import 'package:twitch_ui_flutter/data/models/DiscoverPageResponse.dart';

class DiscoverPage extends StatefulWidget {
  const DiscoverPage({Key key}) : super(key: key);

  @override
  _DiscoverPageState createState() => _DiscoverPageState();
}

class _DiscoverPageState extends State<DiscoverPage> {
  int _carouselIndex = 0;

  void _onCarouselMovement(int index, CarouselPageChangedReason reason) {
    debugPrint('carousel movement');
    setState(() {
      _carouselIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Future _discoverResponse = DataSource.fetchDiscoverPageResponse(context);

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
            child: const Text('Discover',
                style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
          ),
        ),
      ),
      FutureBuilder<DiscoverPageResponse>(
          future: _discoverResponse,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int index) {
                    if (index == 0) {
                      return Padding(
                          padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
                          child: CarouselSlider(
                            items: snapshot.data.topChannels.map((i) {
                              return Builder(
                                builder: (BuildContext context) {
                                  return Container(
                                      margin: const EdgeInsets.all(3.0),
                                      width: MediaQuery.of(context).size.width,
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        imageUrl: i.thumbnail,
                                      ));
                                },
                              );
                            }).toList(),
                            options: CarouselOptions(
                              height: 180.0,
                              onPageChanged: _onCarouselMovement,
                              enlargeCenterPage: true,
                            ),
                          ));
                    } else if (index == 1) {
                      return Padding(
                        padding: const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Text.rich(
                              TextSpan(children: [
                                TextSpan(
                                    text: snapshot
                                        .data
                                        .topChannels[_carouselIndex]
                                        .streamerName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700)),
                                const TextSpan(
                                  text: ' streaming ',
                                ),
                                TextSpan(
                                    text: snapshot
                                        .data
                                        .topChannels[_carouselIndex]
                                        .categoryName,
                                    style: const TextStyle(
                                        fontWeight: FontWeight.w700)),
                              ]),
                            ),
                            const SizedBox(
                              height: 8.0,
                            ),
                            TagChip(
                              label:
                                  snapshot.data.topChannels[_carouselIndex].tag,
                            ),
                          ],
                        ),
                      );
                    } else if (index == 2) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                            child: Text(
                              'RECOMMENDED CHANNELS',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .color),
                            ),
                          ),
                          SizedBox(
                            height: 270,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  snapshot.data.recommendedChannels.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: 320,
                                  padding: index == 0
                                      ? const EdgeInsets.fromLTRB(16, 0, 8, 0)
                                      : const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Stack(
                                        children: <Widget>[
                                          CachedNetworkImage(
                                            width: 320,
                                            height: 150,
                                            fit: BoxFit.cover,
                                            imageUrl: snapshot
                                                .data
                                                .recommendedChannels[index]
                                                .thumbnail,
                                          ),
                                          Positioned(
                                            left: 10,
                                            top: 10,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.red[600],
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0)),
                                              child: const Padding(
                                                padding: EdgeInsets.all(2.0),
                                                child: Text(
                                                  'LIVE',
                                                  style: TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w600),
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            left: 10,
                                            bottom: 10,
                                            child: Container(
                                              decoration: BoxDecoration(
                                                  color: Colors.black54,
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          4.0)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.all(2.0),
                                                child: Text(
                                                  snapshot
                                                          .data
                                                          .recommendedChannels[
                                                              index]
                                                          .views +
                                                      ' Viewers',
                                                  style: const TextStyle(
                                                      color: Colors.white,
                                                      fontWeight:
                                                          FontWeight.w400),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            CircleAvatar(
                                              backgroundImage:
                                                  CachedNetworkImageProvider(
                                                      snapshot
                                                          .data
                                                          .recommendedChannels[
                                                              index]
                                                          .streamerAvatar),
                                            ),
                                            const SizedBox(
                                              width: 8,
                                            ),
                                            Flexible(
                                              fit: FlexFit.tight,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: <Widget>[
                                                  Text(
                                                    snapshot
                                                        .data
                                                        .recommendedChannels[
                                                            index]
                                                        .streamerName,
                                                    style: const TextStyle(
                                                        fontWeight:
                                                            FontWeight.bold),
                                                  ),
                                                  const SizedBox(
                                                    height: 4.0,
                                                  ),
                                                  Text(snapshot
                                                      .data
                                                      .recommendedChannels[
                                                          index]
                                                      .streamTitle),
                                                  const SizedBox(
                                                    height: 4.0,
                                                  ),
                                                  Text(
                                                    snapshot
                                                        .data
                                                        .recommendedChannels[
                                                            index]
                                                        .categoryName,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .caption,
                                                  ),
                                                  const SizedBox(
                                                    height: 4.0,
                                                  ),
                                                  TagChip(
                                                    label: snapshot
                                                        .data
                                                        .recommendedChannels[
                                                            index]
                                                        .tag,
                                                  )
                                                ],
                                              ),
                                            ),
                                            IconButton(
                                              icon: const Icon(Icons.more_vert),
                                              onPressed: () =>
                                                  debugPrint('123'),
                                            )
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      );
                    } else if (index == 3) {
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
                            child: Text(
                              'RECOMMENDED CATEGORIES',
                              style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                  color: Theme.of(context)
                                      .textTheme
                                      .caption
                                      .color),
                            ),
                          ),
                          SizedBox(
                            height: 270,
                            child: ListView.builder(
                              scrollDirection: Axis.horizontal,
                              itemCount:
                                  snapshot.data.recommendedChannels.length,
                              itemBuilder: (BuildContext context, int index) {
                                return Container(
                                  width: 125,
                                  padding: index == 0
                                      ? const EdgeInsets.fromLTRB(16, 0, 8, 0)
                                      : const EdgeInsets.fromLTRB(0, 0, 8, 0),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      CachedNetworkImage(
                                        width: 125,
                                        height: 150,
                                        fit: BoxFit.cover,
                                        imageUrl: snapshot
                                            .data
                                            .recommendedCategories[index]
                                            .categoryCover,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 8.0, vertical: 8.0),
                                        child: Row(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          children: <Widget>[
                                            Column(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: <Widget>[
                                                Text(
                                                  snapshot
                                                      .data
                                                      .recommendedCategories[
                                                          index]
                                                      .categoryName,
                                                  maxLines: 1,
                                                ),
                                                Text(
                                                  snapshot
                                                          .data
                                                          .recommendedCategories[
                                                              index]
                                                          .viewerCount +
                                                      ' Viewers',
                                                  style: Theme.of(context)
                                                      .textTheme
                                                      .caption,
                                                ),
                                                const SizedBox(
                                                  height: 4,
                                                ),
                                                TagChip(
                                                  label: snapshot
                                                      .data
                                                      .recommendedCategories[
                                                          index]
                                                      .tag,
                                                )
                                              ],
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  ),
                                );
                              },
                            ),
                          )
                        ],
                      );
                    } else {
                      return const SizedBox(
                        width: 0,
                        height: 0,
                      );
                    }
                  },
                  childCount: 4,
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
    ]);
  }
}
