class HomePageResponse {
  List<LiveChannels> liveChannels;
  List<LiveChannels> recommendedChannels;
  List<OfflineChannels> offlineChannels;

  HomePageResponse(
      {this.liveChannels, this.recommendedChannels, this.offlineChannels});

  HomePageResponse.fromJson(Map<String, dynamic> json) {
    if (json['live_channels'] != null) {
      liveChannels = <LiveChannels>[];
      json['live_channels'].forEach((v) {
        liveChannels.add(LiveChannels.fromJson(v));
      });
    }
    if (json['recommended_channels'] != null) {
      recommendedChannels = <LiveChannels>[];
      json['recommended_channels'].forEach((v) {
        recommendedChannels.add(LiveChannels.fromJson(v));
      });
    }
    if (json['offline_channels'] != null) {
      offlineChannels = <OfflineChannels>[];
      json['offline_channels'].forEach((v) {
        offlineChannels.add(OfflineChannels.fromJson(v));
      });
    }
  }
}

class LiveChannels {
  String streamerName;
  String streamerAvatar;
  String streamTitle;
  String categoryName;
  String tag;
  String thumbnail;
  String views;

  LiveChannels(
      {this.streamerName,
      this.streamerAvatar,
      this.streamTitle,
      this.categoryName,
      this.tag,
      this.thumbnail,
      this.views});

  LiveChannels.fromJson(Map<String, dynamic> json) {
    streamerName = json['streamer_name'];
    streamerAvatar = json['streamer_avatar'];
    streamTitle = json['stream_title'];
    categoryName = json['category_name'];
    tag = json['tag'];
    thumbnail = json['thumbnail'];
    views = json['views'];
  }
}

class OfflineChannels {
  String streamerName;
  String streamerAvatar;
  String newVideos;

  OfflineChannels({this.streamerName, this.streamerAvatar, this.newVideos});

  OfflineChannels.fromJson(Map<String, dynamic> json) {
    streamerName = json['streamer_name'];
    streamerAvatar = json['streamer_avatar'];
    newVideos = json['new_videos'];
  }
}
