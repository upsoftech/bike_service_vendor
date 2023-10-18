class SubscriptionHistoryModel {
  final String? id;
  final String? vendorId;
  final String? title;
  final String? subTitle;
  final int? count;
  final int? price;
  final String? validity;
  final bool? isActive;
  final String? createdAt;
  final String? updatedAt;

  SubscriptionHistoryModel({
    this.id,
    this.vendorId,
    this.title,
    this.subTitle,
    this.count,
    this.price,
    this.validity,
    this.isActive,
    this.createdAt,
    this.updatedAt,
  });

  SubscriptionHistoryModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        vendorId = json['vendorId'] as String?,
        title = json['title'] as String?,
        subTitle = json['subTitle'] as String?,
        count = json['count'] as int?,
        price = json['price'] as int?,
        validity = json['validity'] as String?,
        isActive = json['isActive'] as bool?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'vendorId' : vendorId,
    'title' : title,
    'subTitle' : subTitle,
    'count' : count,
    'price' : price,
    'validity' : validity,
    'isActive' : isActive,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt
  };
}