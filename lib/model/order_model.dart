class OrderModel {
  final String? id;
  final String? orderId;
  final String? bikeName;
  final String? bikeModel;
  final List<String>? services;
  final int? price;
  final String? orderStatus;
  final String? pickUpAddress;
  final String? createdAt;
  final String? updatedAt;
  final int? v;
  final String? backImage;
  final String? frontImage;
  final String? leftImage;
  final String? rightImage;
  final String? userId;
  final String? vendorId;
  final UserData? userData;
  final VendorData? vendorData;

  OrderModel({
    this.id,
    this.orderId,
    this.bikeName,
    this.bikeModel,
    this.services,
    this.price,
    this.orderStatus,
    this.pickUpAddress,
    this.createdAt,
    this.updatedAt,
    this.v,
    this.backImage,
    this.frontImage,
    this.leftImage,
    this.rightImage,
    this.userId,
    this.vendorId,
    this.userData,
    this.vendorData,
  });

  OrderModel.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        orderId = json['orderId'] as String?,
        bikeName = json['bikeName'] as String?,
        bikeModel = json['bikeModel'] as String?,
        services = (json['services'] as List?)?.map((dynamic e) => e as String).toList(),
        price = json['price'] as int?,
        orderStatus = json['orderStatus'] as String?,
        pickUpAddress = json['pickUpAddress'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        v = json['__v'] as int?,
        backImage = json['backImage'] as String?,
        frontImage = json['frontImage'] as String?,
        leftImage = json['leftImage'] as String?,
        rightImage = json['rightImage'] as String?,
        userId = json['userId'] as String?,
        vendorId = json['vendorId'] as String?,
        userData = (json['userData'] as Map<String,dynamic>?) != null ? UserData.fromJson(json['userData'] as Map<String,dynamic>) : null,
        vendorData = (json['vendorData'] as Map<String,dynamic>?) != null ? VendorData.fromJson(json['vendorData'] as Map<String,dynamic>) : null;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'orderId' : orderId,
    'bikeName' : bikeName,
    'bikeModel' : bikeModel,
    'services' : services,
    'price' : price,
    'orderStatus' : orderStatus,
    'pickUpAddress' : pickUpAddress,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt,
    '__v' : v,
    'backImage' : backImage,
    'frontImage' : frontImage,
    'leftImage' : leftImage,
    'rightImage' : rightImage,
    'userId' : userId,
    'vendorId' : vendorId,
    'userData' : userData?.toJson(),
    'vendorData' : vendorData?.toJson()
  };
}

class UserData {
  final String? id;
  final String? mobile;
  final String? createdAt;
  final String? updatedAt;
  final String? name;

  UserData({
    this.id,
    this.mobile,
    this.createdAt,
    this.updatedAt,
    this.name,
  });

  UserData.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        mobile = json['mobile'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        name = json['name'] as String?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'mobile' : mobile,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt,
    'name' : name
  };
}

class VendorData {
  final String? id;
  final String? mobile;
  final String? createdAt;
  final String? updatedAt;
  final String? email;
  final String? name;
  final String? profilePic;
  final String? otp;
  final String? otpExpiry;

  VendorData({
    this.id,
    this.mobile,
    this.createdAt,
    this.updatedAt,
    this.email,
    this.name,
    this.profilePic,
    this.otp,
    this.otpExpiry,
  });

  VendorData.fromJson(Map<String, dynamic> json)
      : id = json['_id'] as String?,
        mobile = json['mobile'] as String?,
        createdAt = json['createdAt'] as String?,
        updatedAt = json['updatedAt'] as String?,
        email = json['email'] as String?,
        name = json['name'] as String?,
        profilePic = json['profilePic'] as String?,
        otp = json['otp'] as String?,
        otpExpiry = json['otpExpiry'] as String?;

  Map<String, dynamic> toJson() => {
    '_id' : id,
    'mobile' : mobile,
    'createdAt' : createdAt,
    'updatedAt' : updatedAt,
    'email' : email,
    'name' : name,
    'profilePic' : profilePic,
    'otp' : otp,
    'otpExpiry' : otpExpiry
  };
}