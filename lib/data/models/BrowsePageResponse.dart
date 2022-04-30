import 'DiscoverPageResponse.dart';
import 'HomePageResponse.dart';

class BrowsePageResponse {
  List<LiveChannels> liveChannels;
  List<RecommendedCategories> categories;

  BrowsePageResponse({this.liveChannels, this.categories});

  BrowsePageResponse.fromJson(Map<String, dynamic> json) {
    if (json['live_channels'] != null) {
      liveChannels = <LiveChannels>[];
      json['live_channels'].forEach((v) {
        liveChannels.add(LiveChannels.fromJson(v));
      });
    }
    if (json['categories'] != null) {
      categories = <RecommendedCategories>[];
      json['categories'].forEach((v) {
        categories.add(RecommendedCategories.fromJson(v));
      });
    }
  }
}
