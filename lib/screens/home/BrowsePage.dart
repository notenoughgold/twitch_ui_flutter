import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:twitch_ui_flutter/components/TagChip.dart';
import 'package:twitch_ui_flutter/data/DataSource.dart';
import 'package:twitch_ui_flutter/data/models/BrowsePageResponse.dart';

class BrowsePage extends StatefulWidget {
  const BrowsePage({Key key}) : super(key: key);

  @override
  _BrowsePagePageState createState() => _BrowsePagePageState();
}

class _BrowsePagePageState extends State<BrowsePage>
    with SingleTickerProviderStateMixin {
  TabController _tabController;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    Future _browseResponse = DataSource.fetchBrowsePageResponse(context);

    return NestedScrollView(
      headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
        return <Widget>[
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
            expandedHeight: 170,
            pinned: true,
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                padding: const EdgeInsets.fromLTRB(16, 0, 0, 64),
                height: 100,
                alignment: Alignment.bottomLeft,
                child: const Text('Browse',
                    style:
                         TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
              ),
            ),
            bottom: TabBar(
              controller: _tabController,
              isScrollable: true,
              indicatorSize: TabBarIndicatorSize.label,
              tabs: const <Widget>[
                Tab(
                  text: "Categories",
                ),
                Tab(
                  text: "Live Channels",
                ),
              ],
            ),
          )
        ];
      },
      body: TabBarView(
        controller: _tabController,
        children: <Widget>[
          FutureBuilder<BrowsePageResponse>(
              future: _browseResponse,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Stack(
                    children: <Widget>[
                      ListView.builder(
                        itemCount: snapshot.data.categories.length,
                        itemBuilder: (BuildContext context, int index) =>
                            Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 16.0, vertical: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: <Widget>[
                              CachedNetworkImage(
                                fit: BoxFit.cover,
                                height: 80,
                                imageUrl: snapshot
                                    .data.categories[index].categoryCover,
                              ),
                              const SizedBox(
                                width: 16,
                              ),
                              Column(
                                children: <Widget>[
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: <Widget>[
                                      Text(
                                        snapshot.data.categories[index]
                                            .categoryName,
                                        maxLines: 1,
                                        style: const TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      const SizedBox(
                                        height: 4,
                                      ),
                                      Text(
                                        snapshot.data.categories[index]
                                                .viewerCount +
                                            ' Viewers',
                                        style:
                                            Theme.of(context).textTheme.caption,
                                      ),
                                      const SizedBox(
                                        height: 4.0,
                                      ),
                                      TagChip(
                                        label:
                                            snapshot.data.categories[index].tag,
                                      )
                                    ],
                                  ),
                                ],
                              )
                            ],
                          ),
                        ),
                      ),
                      Positioned(
                        width: MediaQuery.of(context).size.width / 2,
                        left: 16,
                        bottom: 8,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            primary: Colors.grey.shade900,
                          ),
                          child: Row(
                            children: const <Widget>[
                              Icon(FontAwesomeIcons.sliders),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Sort and Filter',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              CircleAvatar(
                                radius: 10.0,
                                backgroundColor: Colors.deepPurple,
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                          onPressed: () {},
                        ),
                      )
                    ],
                  );
                } else {
                  return const Center(
                    child:  CircularProgressIndicator(),
                  );
                }
              }),
          FutureBuilder<BrowsePageResponse>(
              future: _browseResponse,
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  return Stack(
                    children: <Widget>[
                      ListView.builder(
                          itemCount: snapshot.data.categories.length,
                          itemBuilder: (BuildContext context, int index) =>
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: <Widget>[
                                  Stack(
                                    children: <Widget>[
                                      Ink.image(
                                        height: 200,
                                        width:
                                            MediaQuery.of(context).size.width,
                                        fit: BoxFit.cover,
                                        image: CachedNetworkImageProvider(
                                            snapshot.data.liveChannels[index]
                                                .thumbnail),
                                        child: InkWell(
                                          onTap: () {},
                                        ),
                                      ),
                                      Positioned(
                                        left: 10,
                                        top: 10,
                                        child: Container(
                                          decoration: BoxDecoration(
                                              color: Colors.red[600],
                                              borderRadius:
                                                  BorderRadius.circular(4.0)),
                                          child: const Padding(
                                            padding:
                                                EdgeInsets.all(2.0),
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
                                                  BorderRadius.circular(4.0)),
                                          child: Padding(
                                            padding:
                                                const EdgeInsets.all(2.0),
                                            child: Text(
                                              snapshot
                                                      .data
                                                      .liveChannels[index]
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
                                    padding: const EdgeInsets.fromLTRB(
                                        8, 8, 8, 24),
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
                                                      .liveChannels[index]
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
                                                    .liveChannels[index]
                                                    .streamerName,
                                                style: const TextStyle(
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Text(snapshot
                                                  .data
                                                  .liveChannels[index]
                                                  .streamTitle),
                                              const SizedBox(
                                                height: 4,
                                              ),
                                              Text(
                                                snapshot
                                                    .data
                                                    .liveChannels[index]
                                                    .categoryName,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .caption,
                                              ),
                                              const SizedBox(
                                                height: 4.0,
                                              ),
                                              TagChip(
                                                label: snapshot.data
                                                    .liveChannels[index].tag,
                                              )
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                ],
                              )),
                      Positioned(
                        width: MediaQuery.of(context).size.width / 2,
                        left: 16,
                        bottom: 8,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              primary: Colors.grey.shade900),
                          child: Row(
                            children: const <Widget>[
                              Icon(FontAwesomeIcons.sliders),
                              SizedBox(
                                width: 4,
                              ),
                              Text(
                                'Sort and Filter',
                                style: TextStyle(fontWeight: FontWeight.w600),
                              ),
                              SizedBox(
                                width: 4,
                              ),
                              CircleAvatar(
                                radius: 10.0,
                                backgroundColor: Colors.deepPurple,
                                child: Text(
                                  '1',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              )
                            ],
                          ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  );
                } else {
                  return const Center(
                    child: CircularProgressIndicator(),
                  );
                }
              }),
        ],
      ),
    );

    // return DefaultTabController(
    //   length: 2,
    //   child: CustomScrollView(slivers: <Widget>[
    //     SliverAppBar(
    //       leading: IconButton(
    //         icon: CircleAvatar(
    //           radius: 14,
    //           backgroundImage: CachedNetworkImageProvider(
    //               'https://picsum.photos/id/1025/50/50'),
    //         ),
    //         onPressed: () => debugPrint('Action Notification'),
    //       ),
    //       actions: <Widget>[
    //         IconButton(
    //           icon: Icon(Icons.notifications_none),
    //           onPressed: () => debugPrint('Action Notification'),
    //         ),
    //         IconButton(
    //           icon: Icon(
    //             Icons.comment,
    //           ),
    //           onPressed: () => debugPrint('Action 2'),
    //         ),
    //         IconButton(
    //           icon: Icon(Icons.search),
    //           onPressed: () => debugPrint('Action 3'),
    //         ),
    //       ],
    //       expandedHeight: 170,
    //       pinned: true,
    //       flexibleSpace: FlexibleSpaceBar(
    //         background: Container(
    //           padding: EdgeInsets.fromLTRB(16, 0, 0, 64),
    //           height: 100,
    //           alignment: Alignment.bottomLeft,
    //           child: Text('Browse',
    //               style: TextStyle(fontSize: 36, fontWeight: FontWeight.bold)),
    //         ),
    //       ),
    //       bottom: TabBar(
    //         tabs: <Widget>[
    //           Tab(
    //             text: "Categories",
    //           ),
    //           Tab(
    //             text: "Live Channels",
    //           ),
    //         ],
    //       ),
    //     ),
    //     SliverToBoxAdapter(
    //       child: TabBarView(
    //         children: <Widget>[
    //           FutureBuilder<BrowsePageResponse>(
    //               future: _browseResponse,
    //               builder: (context, snapshot) {
    //                 return ListView.builder(
    //                   itemCount: snapshot.data.categories.length,
    //                   itemBuilder: (BuildContext context, int index) => Row(
    //                     children: <Widget>[
    //                       CachedNetworkImage(
    //                         imageUrl:
    //                             snapshot.data.categories[index].categoryCover,
    //                       )
    //                     ],
    //                   ),
    //                 );
    //               }),
    //           Center(
    //             child: Text("Second Tab"),
    //           ),
    //         ],
    //       ),
    //     ),
    // FutureBuilder<DiscoverPageResponse>(
    //     future: _browseResponse,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //         return SliverList(
    //           delegate: SliverChildBuilderDelegate(
    //             (BuildContext context, int index) {
    //               if (index == 0) {
    //                 return Padding(
    //                     padding: const EdgeInsets.fromLTRB(0, 20, 0, 0),
    //                     child: CarouselSlider(
    //                       height: 180.0,
    //                       enlargeCenterPage: true,
    //                       onPageChanged: _onCarouselMovement,
    //                       items: snapshot.data.topChannels.map((i) {
    //                         return Builder(
    //                           builder: (BuildContext context) {
    //                             return Container(
    //                                 margin: EdgeInsets.all(3.0),
    //                                 width:
    //                                     MediaQuery.of(context).size.width,
    //                                 child: CachedNetworkImage(
    //                                   fit: BoxFit.cover,
    //                                   imageUrl: i.thumbnail,
    //                                 ));
    //                           },
    //                         );
    //                       }).toList(),
    //                     ));
    //               } else if (index == 1) {
    //                 return Padding(
    //                   padding:
    //                       const EdgeInsets.fromLTRB(16.0, 16.0, 16.0, 0),
    //                   child: Column(
    //                     crossAxisAlignment: CrossAxisAlignment.start,
    //                     children: <Widget>[
    //                       Text.rich(
    //                         TextSpan(children: [
    //                           TextSpan(
    //                               text: snapshot
    //                                   .data
    //                                   .topChannels[_carouselIndex]
    //                                   .streamerName,
    //                               style: TextStyle(
    //                                   fontWeight: FontWeight.w700)),
    //                           TextSpan(
    //                             text: ' streaming ',
    //                           ),
    //                           TextSpan(
    //                               text: snapshot
    //                                   .data
    //                                   .topChannels[_carouselIndex]
    //                                   .categoryName,
    //                               style: TextStyle(
    //                                   fontWeight: FontWeight.w700)),
    //                         ]),
    //                       ),
    //                       RawChip(
    //                         onPressed: () {},
    //                         label: Text(
    //                           snapshot.data.topChannels[_carouselIndex].tag,
    //                           style: TextStyle(
    //                               fontSize: 12,
    //                               fontWeight: FontWeight.w500),
    //                         ),
    //                       )
    //                     ],
    //                   ),
    //                 );
    //               } else if (index == 2) {
    //                 return Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: <Widget>[
    //                     Padding(
    //                       padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
    //                       child: Text(
    //                         'RECOMMENDED CHANNELS',
    //                         style: TextStyle(fontWeight: FontWeight.w600),
    //                       ),
    //                     ),
    //                     Container(
    //                       height: 270,
    //                       child: ListView.builder(
    //                         scrollDirection: Axis.horizontal,
    //                         itemCount:
    //                             snapshot.data.recommendedChannels.length,
    //                         itemBuilder: (BuildContext context, int index) {
    //                           return Container(
    //                             width: 320,
    //                             padding: index == 0
    //                                 ? EdgeInsets.fromLTRB(16, 0, 2, 0)
    //                                 : EdgeInsets.fromLTRB(2, 0, 2, 0),
    //                             child: Column(
    //                               crossAxisAlignment:
    //                                   CrossAxisAlignment.start,
    //                               children: <Widget>[
    //                                 Stack(
    //                                   children: <Widget>[
    //                                     CachedNetworkImage(
    //                                       width: 320,
    //                                       height: 150,
    //                                       fit: BoxFit.cover,
    //                                       imageUrl: snapshot
    //                                           .data
    //                                           .recommendedChannels[index]
    //                                           .thumbnail,
    //                                     ),
    //                                     Positioned(
    //                                       left: 10,
    //                                       top: 10,
    //                                       child: Container(
    //                                         decoration: BoxDecoration(
    //                                             color: Colors.red[600],
    //                                             borderRadius:
    //                                                 BorderRadius.circular(
    //                                                     4.0)),
    //                                         child: Padding(
    //                                           padding:
    //                                               const EdgeInsets.all(2.0),
    //                                           child: Text(
    //                                             'LIVE',
    //                                             style: TextStyle(
    //                                                 color: Colors.white,
    //                                                 fontWeight:
    //                                                     FontWeight.w600),
    //                                           ),
    //                                         ),
    //                                       ),
    //                                     ),
    //                                     Positioned(
    //                                       left: 10,
    //                                       bottom: 10,
    //                                       child: Container(
    //                                         decoration: BoxDecoration(
    //                                             color: Colors.black54,
    //                                             borderRadius:
    //                                                 BorderRadius.circular(
    //                                                     4.0)),
    //                                         child: Padding(
    //                                           padding:
    //                                               const EdgeInsets.all(2.0),
    //                                           child: Text(
    //                                             snapshot
    //                                                     .data
    //                                                     .recommendedChannels[
    //                                                         index]
    //                                                     .views +
    //                                                 ' Viewers',
    //                                             style: TextStyle(
    //                                                 color: Colors.white,
    //                                                 fontWeight:
    //                                                     FontWeight.w400),
    //                                           ),
    //                                         ),
    //                                       ),
    //                                     ),
    //                                   ],
    //                                 ),
    //                                 Padding(
    //                                   padding: const EdgeInsets.symmetric(
    //                                       horizontal: 8.0, vertical: 8.0),
    //                                   child: Row(
    //                                     crossAxisAlignment:
    //                                         CrossAxisAlignment.start,
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.start,
    //                                     children: <Widget>[
    //                                       CircleAvatar(
    //                                         backgroundImage:
    //                                             CachedNetworkImageProvider(
    //                                                 snapshot
    //                                                     .data
    //                                                     .recommendedChannels[
    //                                                         index]
    //                                                     .streamerAvatar),
    //                                       ),
    //                                       SizedBox(
    //                                         width: 8,
    //                                       ),
    //                                       Flexible(
    //                                         fit: FlexFit.tight,
    //                                         child: Column(
    //                                           crossAxisAlignment:
    //                                               CrossAxisAlignment.start,
    //                                           children: <Widget>[
    //                                             Text(snapshot
    //                                                 .data
    //                                                 .recommendedChannels[
    //                                                     index]
    //                                                 .streamerName),
    //                                             Text(snapshot
    //                                                 .data
    //                                                 .recommendedChannels[
    //                                                     index]
    //                                                 .streamTitle),
    //                                             Text(
    //                                               snapshot
    //                                                   .data
    //                                                   .recommendedChannels[
    //                                                       index]
    //                                                   .categoryName,
    //                                               style: Theme.of(context)
    //                                                   .textTheme
    //                                                   .caption,
    //                                             ),
    //                                             RawChip(
    //                                               onPressed: () {},
    //                                               label: Text(
    //                                                 snapshot
    //                                                     .data
    //                                                     .recommendedChannels[
    //                                                         index]
    //                                                     .tag,
    //                                                 style: TextStyle(
    //                                                     fontSize: 12,
    //                                                     fontWeight:
    //                                                         FontWeight
    //                                                             .w500),
    //                                               ),
    //                                             )
    //                                           ],
    //                                         ),
    //                                       ),
    //                                       IconButton(
    //                                         icon: Icon(Icons.more_vert),
    //                                         onPressed: () =>
    //                                             debugPrint('123'),
    //                                       )
    //                                     ],
    //                                   ),
    //                                 )
    //                               ],
    //                             ),
    //                           );
    //                         },
    //                       ),
    //                     )
    //                   ],
    //                 );
    //               } else if (index == 3) {
    //                 return Column(
    //                   crossAxisAlignment: CrossAxisAlignment.start,
    //                   children: <Widget>[
    //                     Padding(
    //                       padding: const EdgeInsets.fromLTRB(16, 20, 16, 8),
    //                       child: Text(
    //                         'RECOMMENDED CATEGORIES',
    //                         style: TextStyle(fontWeight: FontWeight.w600),
    //                       ),
    //                     ),
    //                     Container(
    //                       height: 270,
    //                       child: ListView.builder(
    //                         scrollDirection: Axis.horizontal,
    //                         itemCount:
    //                             snapshot.data.recommendedChannels.length,
    //                         itemBuilder: (BuildContext context, int index) {
    //                           return Container(
    //                             width: 125,
    //                             padding: index == 0
    //                                 ? EdgeInsets.fromLTRB(16, 0, 2, 0)
    //                                 : EdgeInsets.fromLTRB(2, 0, 2, 0),
    //                             child: Column(
    //                               crossAxisAlignment:
    //                                   CrossAxisAlignment.start,
    //                               children: <Widget>[
    //                                 CachedNetworkImage(
    //                                   width: 125,
    //                                   height: 150,
    //                                   fit: BoxFit.cover,
    //                                   imageUrl: snapshot
    //                                       .data
    //                                       .recommendedCategories[index]
    //                                       .categoryCover,
    //                                 ),
    //                                 Padding(
    //                                   padding: const EdgeInsets.symmetric(
    //                                       horizontal: 8.0, vertical: 8.0),
    //                                   child: Row(
    //                                     crossAxisAlignment:
    //                                         CrossAxisAlignment.start,
    //                                     mainAxisAlignment:
    //                                         MainAxisAlignment.start,
    //                                     children: <Widget>[
    //                                       Column(
    //                                         crossAxisAlignment:
    //                                             CrossAxisAlignment.start,
    //                                         children: <Widget>[
    //                                           Text(
    //                                             snapshot
    //                                                 .data
    //                                                 .recommendedCategories[
    //                                                     index]
    //                                                 .categoryName,
    //                                             maxLines: 1,
    //                                           ),
    //                                           Text(
    //                                             snapshot
    //                                                     .data
    //                                                     .recommendedCategories[
    //                                                         index]
    //                                                     .viewerCount +
    //                                                 ' Viewers',
    //                                             style: Theme.of(context)
    //                                                 .textTheme
    //                                                 .caption,
    //                                           ),
    //                                           RawChip(
    //                                             onPressed: () {},
    //                                             label: Text(
    //                                               snapshot
    //                                                   .data
    //                                                   .recommendedChannels[
    //                                                       index]
    //                                                   .tag,
    //                                               style: TextStyle(
    //                                                   fontSize: 12,
    //                                                   fontWeight:
    //                                                       FontWeight.w500),
    //                                             ),
    //                                           )
    //                                         ],
    //                                       ),
    //                                     ],
    //                                   ),
    //                                 )
    //                               ],
    //                             ),
    //                           );
    //                         },
    //                       ),
    //                     )
    //                   ],
    //                 );
    //               } else {
    //                 return Container(
    //                   width: 0,
    //                   height: 0,
    //                 );
    //               }
    //             },
    //             childCount: 4,
    //           ),
    //         );
    //       } else {
    //         return SliverFillRemaining(
    //           child: Center(
    //             child: CircularProgressIndicator(),
    //           ),
    //         );
    //       }
    //     }),
    // ]),
    // );
  }
}
