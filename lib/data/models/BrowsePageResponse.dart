import 'package:twitch_ui_flutter/data/models/DiscoverPageResponse.dart';
import 'package:twitch_ui_flutter/data/models/HomePageResponse.dart';

class BrowsePageResponse {
  List<LiveChannels> liveChannels;
  List<RecommendedCategories> categories;

  BrowsePageResponse({this.liveChannels, this.categories});

  BrowsePageResponse.fromJson(Map<String, dynamic> json) {
    if (json['live_channels'] != null) {
      liveChannels = new List<LiveChannels>();
      json['live_channels'].forEach((v) {
        liveChannels.add(new LiveChannels.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = new List<RecommendedCategories>();
      json['categories'].forEach((v) {
        categories.add(new RecommendedCategories.fromJson(v));
      });
    }
  }
}
