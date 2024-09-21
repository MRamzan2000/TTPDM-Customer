import 'dart:convert';

GetAllDesignsModel getAllDesignsModelFromJson(String str) => GetAllDesignsModel.fromJson(json.decode(str));

String getAllDesignsModelToJson(GetAllDesignsModel data) => json.encode(data.toJson());

class GetAllDesignsModel {
  List<Design> designs;

  GetAllDesignsModel({
    required this.designs,
  });

  factory GetAllDesignsModel.fromJson(Map<String, dynamic> json) {
    // Handle the case where "designs" might be null
    return GetAllDesignsModel(
      designs: json["designs"] != null
          ? List<Design>.from(json["designs"].map((x) => Design.fromJson(x)))
          : [], // Provide an empty list if "designs" is null
    );
  }

  Map<String, dynamic> toJson() => {
    "designs": List<dynamic>.from(designs.map((x) => x.toJson())),
  };
}

class Design {
  String id;
  String fileUrl;
  UploadedBy uploadedBy;
  DateTime uploadDate;
  int v;
  List<UploadedBy> dislikes;
  List<UploadedBy> likes;
  int likeCount;
  int dislikeCount;
  List<LikedByUser> likedByUsers;
  List<DislikedByUser> dislikedByUsers;

  Design({
    required this.id,
    required this.fileUrl,
    required this.uploadedBy,
    required this.uploadDate,
    required this.v,
    required this.dislikes,
    required this.likes,
    required this.likeCount,
    required this.dislikeCount,
    required this.likedByUsers,
    required this.dislikedByUsers,
  });

  factory Design.fromJson(Map<String, dynamic> json) {
    return Design(
      id: json["_id"] ?? '',
      fileUrl: json["fileUrl"] ?? '',
      uploadedBy: json["uploadedBy"] != null
          ? UploadedBy.fromJson(json["uploadedBy"])
          : UploadedBy(id: '', fullname: '', email: ''),
      uploadDate: json["uploadDate"] != null
          ? DateTime.parse(json["uploadDate"])
          : DateTime.now(),
      v: json["__v"] ?? 0,
      dislikes: json["dislikes"] != null
          ? List<UploadedBy>.from(json["dislikes"].map((x) => UploadedBy.fromJson(x)))
          : [], // Handle null case
      likes: json["likes"] != null
          ? List<UploadedBy>.from(json["likes"].map((x) => UploadedBy.fromJson(x)))
          : [], // Handle null case
      likeCount: json["likeCount"] ?? 0,
      dislikeCount: json["dislikeCount"] ?? 0,
      likedByUsers: json["likedByUsers"] != null
          ? List<LikedByUser>.from(json["likedByUsers"].map((x) => LikedByUser.fromJson(x)))
          : [], // Handle null case
      dislikedByUsers: json["dislikedByUsers"] != null
          ? List<DislikedByUser>.from(json["dislikedByUsers"].map((x) => DislikedByUser.fromJson(x)))
          : [], // Handle null case
    );
  }

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fileUrl": fileUrl,
    "uploadedBy": uploadedBy.toJson(),
    "uploadDate": uploadDate.toIso8601String(),
    "__v": v,
    "dislikes": List<dynamic>.from(dislikes.map((x) => x.toJson())),
    "likes": List<dynamic>.from(likes.map((x) => x.toJson())),
    "likeCount": likeCount,
    "dislikeCount": dislikeCount,
    "likedByUsers": List<dynamic>.from(likedByUsers.map((x) => x.toJson())),
    "dislikedByUsers": List<dynamic>.from(dislikedByUsers.map((x) => x.toJson())),
  };
}

class LikedByUser {
  String fullname;
  String email;

  LikedByUser({
    required this.fullname,
    required this.email,
  });

  factory LikedByUser.fromJson(Map<String, dynamic> json) => LikedByUser(
    fullname: json["fullname"] ?? '',
    email: json["email"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "fullname": fullname,
    "email": email,
  };
}

class DislikedByUser {
  String fullname;
  String email;

  DislikedByUser({
    required this.fullname,
    required this.email,
  });

  factory DislikedByUser.fromJson(Map<String, dynamic> json) => DislikedByUser(
    fullname: json["fullname"] ?? '',
    email: json["email"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "fullname": fullname,
    "email": email,
  };
}

class UploadedBy {
  String id;
  String fullname;
  String email;

  UploadedBy({
    required this.id,
    required this.fullname,
    required this.email,
  });

  factory UploadedBy.fromJson(Map<String, dynamic> json) => UploadedBy(
    id: json["_id"] ?? '',
    fullname: json["fullname"] ?? '',
    email: json["email"] ?? '',
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullname": fullname,
    "email": email,
  };
}
