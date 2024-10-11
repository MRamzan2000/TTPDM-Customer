
import 'dart:convert';

GetCampaignRulesModel getCampaignRulesModelFromJson(String str) => GetCampaignRulesModel.fromJson(json.decode(str));

String getCampaignRulesModelToJson(GetCampaignRulesModel data) => json.encode(data.toJson());

class GetCampaignRulesModel {
  bool advyroSocialPages;
  bool google;
  bool tiktok;
  bool facebook;
  bool instagram;
  bool youtube;
  double socialFee;
  double dayFee;
  double hourFee;
  double advyroGoogleFee;
  double advyroSocialMediaPagesFee;
  double advyroTiktokFee;
  double advyroFacebookFee;
  double advyroInstagramFee;
  double advyroYoutubeFee;

  GetCampaignRulesModel({
    required this.advyroSocialPages,
    required this.google,
    required this.tiktok,
    required this.facebook,
    required this.instagram,
    required this.youtube,
    required this.socialFee,
    required this.dayFee,
    required this.hourFee,
    required this.advyroGoogleFee,
    required this.advyroSocialMediaPagesFee,
    required this.advyroTiktokFee,
    required this.advyroFacebookFee,
    required this.advyroInstagramFee,
    required this.advyroYoutubeFee,
  });

  GetCampaignRulesModel copyWith({
    bool? advyroSocialPages,
    bool? google,
    bool? tiktok,
    bool? facebook,
    bool? instagram,
    bool? youtube,
    double? socialFee,
    double? dayFee,
    double? hourFee,
    double? advyroGoogleFee,
    double? advyroSocialMediaPagesFee,
    double? advyroTiktokFee,
    double? advyroFacebookFee,
    double? advyroInstagramFee,
    double? advyroYoutubeFee,
  }) =>
      GetCampaignRulesModel(
        advyroSocialPages: advyroSocialPages ?? this.advyroSocialPages,
        google: google ?? this.google,
        tiktok: tiktok ?? this.tiktok,
        facebook: facebook ?? this.facebook,
        instagram: instagram ?? this.instagram,
        youtube: youtube ?? this.youtube,
        socialFee: socialFee ?? this.socialFee,
        dayFee: dayFee ?? this.dayFee,
        hourFee: hourFee ?? this.hourFee,
        advyroGoogleFee: advyroGoogleFee ?? this.advyroGoogleFee,
        advyroSocialMediaPagesFee: advyroSocialMediaPagesFee ?? this.advyroSocialMediaPagesFee,
        advyroTiktokFee: advyroTiktokFee ?? this.advyroTiktokFee,
        advyroFacebookFee: advyroFacebookFee ?? this.advyroFacebookFee,
        advyroInstagramFee: advyroInstagramFee ?? this.advyroInstagramFee,
        advyroYoutubeFee: advyroYoutubeFee ?? this.advyroYoutubeFee,
      );

  factory GetCampaignRulesModel.fromJson(Map<String, dynamic> json) => GetCampaignRulesModel(
    advyroSocialPages: json["advyro_social_pages"],
    google: json["google"],
    tiktok: json["tiktok"],
    facebook: json["facebook"],
    instagram: json["instagram"],
    youtube: json["youtube"],
    socialFee: json["socialFee"]?.toDouble(),
    dayFee: json["dayFee"]?.toDouble(),
    hourFee: json["hourFee"]?.toDouble(),
    advyroGoogleFee: json["advyro_google_fee"]?.toDouble(),
    advyroSocialMediaPagesFee: json["advyro_social_media_pages_fee"]?.toDouble(),
    advyroTiktokFee: json["advyro_tiktok_fee"]?.toDouble(),
    advyroFacebookFee: json["advyro_facebook_fee"]?.toDouble(),
    advyroInstagramFee: json["advyro_instagram_fee"]?.toDouble(),
    advyroYoutubeFee: json["advyro_youtube_fee"]?.toDouble(),
  );

  Map<String, dynamic> toJson() => {
    "advyro_social_pages": advyroSocialPages,
    "google": google,
    "tiktok": tiktok,
    "facebook": facebook,
    "instagram": instagram,
    "youtube": youtube,
    "socialFee": socialFee,
    "dayFee": dayFee,
    "hourFee": hourFee,
    "advyro_google_fee": advyroGoogleFee,
    "advyro_social_media_pages_fee": advyroSocialMediaPagesFee,
    "advyro_tiktok_fee": advyroTiktokFee,
    "advyro_facebook_fee": advyroFacebookFee,
    "advyro_instagram_fee": advyroInstagramFee,
    "advyro_youtube_fee": advyroYoutubeFee,
  };
}
