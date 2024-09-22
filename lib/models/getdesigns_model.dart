import 'dart:convert';

// Function to convert JSON string to GetAllDesignsModel
GetAllDesignsModel getAllDesignsModelFromJson(String str) => GetAllDesignsModel.fromJson(json.decode(str));

// Function to convert GetAllDesignsModel to JSON string
String getAllDesignsModelToJson(GetAllDesignsModel data) => json.encode(data.toJson());

class GetAllDesignsModel {
  List<Design> designs;

  GetAllDesignsModel({
    required this.designs,
  });

  GetAllDesignsModel copyWith({
    List<Design>? designs,
  }) =>
      GetAllDesignsModel(
        designs: designs ?? this.designs,
      );

  factory GetAllDesignsModel.fromJson(Map<String, dynamic> json) => GetAllDesignsModel(
    designs: List<Design>.from(json["designs"].map((x) => Design.fromJson(x))),
  );

  Map<String, dynamic> toJson() => {
    "designs": List<dynamic>.from(designs.map((x) => x.toJson())),
  };
}

class Design {
  String id;
  String fileUrl;
  UploadedBy uploadedBy;
  String businessId;
  List<dynamic> likes;
  List<dynamic> dislikes;
  String comment;
  DateTime uploadDate;
  int v;
  int likeCount;
  int dislikeCount;
  List<dynamic> likedByUsers;
  List<dynamic> dislikedByUsers;

  Design({
    required this.id,
    required this.fileUrl,
    required this.uploadedBy,
    required this.businessId,
    required this.likes,
    required this.dislikes,
    required this.comment,
    required this.uploadDate,
    required this.v,
    required this.likeCount,
    required this.dislikeCount,
    required this.likedByUsers,
    required this.dislikedByUsers,
  });

  Design copyWith({
    String? id,
    String? fileUrl,
    UploadedBy? uploadedBy,
    String? businessId,
    List<dynamic>? likes,
    List<dynamic>? dislikes,
    String? comment,
    DateTime? uploadDate,
    int? v,
    int? likeCount,
    int? dislikeCount,
    List<dynamic>? likedByUsers,
    List<dynamic>? dislikedByUsers,
  }) =>
      Design(
        id: id ?? this.id,
        fileUrl: fileUrl ?? this.fileUrl,
        uploadedBy: uploadedBy ?? this.uploadedBy,
        businessId: businessId ?? this.businessId,
        likes: likes ?? this.likes,
        dislikes: dislikes ?? this.dislikes,
        comment: comment ?? this.comment,
        uploadDate: uploadDate ?? this.uploadDate,
        v: v ?? this.v,
        likeCount: likeCount ?? this.likeCount,
        dislikeCount: dislikeCount ?? this.dislikeCount,
        likedByUsers: likedByUsers ?? this.likedByUsers,
        dislikedByUsers: dislikedByUsers ?? this.dislikedByUsers,
      );

  factory Design.fromJson(Map<String, dynamic> json) => Design(
    id: json["_id"] ?? "",  // Fallback to empty string if null
    fileUrl: json["fileUrl"] ?? "",  // Fallback to empty string if null
    uploadedBy: UploadedBy.fromJson(json["uploadedBy"]),
    businessId: json["businessId"] ?? "",  // Already handled
    likes: List<dynamic>.from(json["likes"]?.map((x) => x) ?? []), // Handle null case
    dislikes: List<dynamic>.from(json["dislikes"]?.map((x) => x) ?? []), // Handle null case
    comment: json["comment"] ?? "",  // Added fallback
    uploadDate: DateTime.parse(json["uploadDate"] ?? DateTime.now().toIso8601String()), // Fallback to now if null
    v: json["__v"] ?? 0,  // Fallback to 0 if null
    likeCount: json["likeCount"] ?? 0,  // Fallback to 0 if null
    dislikeCount: json["dislikeCount"] ?? 0,  // Fallback to 0 if null
    likedByUsers: List<dynamic>.from(json["likedByUsers"]?.map((x) => x) ?? []), // Handle null case
    dislikedByUsers: List<dynamic>.from(json["dislikedByUsers"]?.map((x) => x) ?? []), // Handle null case
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fileUrl": fileUrl,
    "uploadedBy": uploadedBy.toJson(),
    "businessId": businessId,
    "likes": List<dynamic>.from(likes.map((x) => x)),
    "dislikes": List<dynamic>.from(dislikes.map((x) => x)),
    "comment": comment,
    "uploadDate": uploadDate.toIso8601String(),
    "__v": v,
    "likeCount": likeCount,
    "dislikeCount": dislikeCount,
    "likedByUsers": List<dynamic>.from(likedByUsers.map((x) => x)),
    "dislikedByUsers": List<dynamic>.from(dislikedByUsers.map((x) => x)),
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

  UploadedBy copyWith({
    String? id,
    String? fullname,
    String? email,
  }) =>
      UploadedBy(
        id: id ?? this.id,
        fullname: fullname ?? this.fullname,
        email: email ?? this.email,
      );

  factory UploadedBy.fromJson(Map<String, dynamic> json) => UploadedBy(
    id: json["_id"] ?? "",  // Fallback to empty string if null
    fullname: json["fullname"] ?? "",  // Fallback to empty string if null
    email: json["email"] ?? "",  // Fallback to empty string if null
  );

  Map<String, dynamic> toJson() => {
    "_id": id,
    "fullname": fullname,
    "email": email,
  };
}
