import 'package:twitch_ui_flutter/data/models/HomePageResponse.dart';

class DiscoverPageResponse {
  List<TopChannels> topChannels;
  List<LiveChannels> recommendedChannels;
  List<RecommendedCategories> recommendedCategories;

  DiscoverPageResponse(
      {this.topChannels, this.recommendedChannels, this.recommendedCategories});

  DiscoverPageResponse.fromJson(Map<String, dynamic> json) {
    if (json['top_channels'] != null) {
      topChannels = new List<TopChannels>();
      json['top_channels'].forEach((v) {
        topChannels.add(new TopChannels.fromJson(v));
      });
    }
    if (json['recommended_channels'] != null) {
      recommendedChannels = new List<LiveChannels>();
      json['recommended_channels'].forEach((v) {
        recommendedChannels.add(new LiveChannels.fromJson(v));
      });
    }
    if (json['recommended_categories'] != null) {
      recommendedCategories = new List<RecommendedCategories>();
      json['recommended_categories'].forEach((v) {
        recommendedCategories.add(new RecommendedCategories.fromJson(v));
      });
    }
  }
}

class TopChannels {
  String streamerName;
  String categoryName;
  String tag;
  String thumbnail;
  String views;

  TopChannels(
      {this.streamerName,
      this.categoryName,
      this.tag,
      this.thumbnail,
      this.views});

  TopChannels.fromJson(Map<String, dynamic> json) {
    streamerName = json['streamer_name'];
    categoryName = json['category_name'];
    tag = json['tag'];
    thumbnail = json['thumbnail'];
    views = json['views'];
  }
}

class RecommendedCategories {
  String categoryName;
  String categoryCover;
  String viewerCount;
  String tag;

  RecommendedCategories(
      {this.categoryName, this.categoryCover, this.viewerCount, this.tag});

  RecommendedCategories.fromJson(Map<String, dynamic> json) {
    categoryName = json['category_name'];
    categoryCover = json['category_cover'];
    viewerCount = json['viewer_count'];
    tag = json['tag'];
  }
}
