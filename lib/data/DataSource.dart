import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:twitch_ui_flutter/data/models/BrowsePageResponse.dart';
import 'package:twitch_ui_flutter/data/models/DiscoverPageResponse.dart';
import 'package:twitch_ui_flutter/data/models/HomePageResponse.dart';

class DataSource {
  static Future<HomePageResponse> fetchFollowingPageResponse(
      BuildContext context) async {
    String response = await DefaultAssetBundle.of(context)
        .loadString("assets/homeDummyData.json");

    if (response != null) {
      return Future.delayed(Duration(seconds: 1),
          () => HomePageResponse.fromJson(json.decode(response)));
    } else {
      print("loading failed");
      throw Exception('Failed to load');
    }
  }

  static Future<DiscoverPageResponse> fetchDiscoverPageResponse(
      BuildContext context) async {
    String response = await DefaultAssetBundle.of(context)
        .loadString("assets/discoverDummyData.json");

    if (response != null) {
      return Future.delayed(Duration(seconds: 1),
          () => DiscoverPageResponse.fromJson(json.decode(response)));
    } else {
      print("loading failed");
      throw Exception('Failed to load');
    }
  }

  static Future<BrowsePageResponse> fetchBrowsePageResponse(
      BuildContext context) async {
    String response = await DefaultAssetBundle.of(context)
        .loadString("assets/browseDummyData.json");

    if (response != null) {
      return Future.delayed(Duration(seconds: 1),
          () => BrowsePageResponse.fromJson(json.decode(response)));
    } else {
      print("loading failed");
      throw Exception('Failed to load');
    }
  }
}
