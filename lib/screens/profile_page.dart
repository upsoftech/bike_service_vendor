import 'dart:developer';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import '../provider/profile_provider.dart';
import '../services/api_services.dart';
import '../shared_preference/pref_services.dart';
import '../utils/app_constant.dart';
import '../utils/app_style.dart';
import '../utils/color.dart';
import '../utils/image.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final emailController = TextEditingController();
  final PrefService _prefService = PrefService();

  late ProfileProvider profileProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    profileProvider = Provider.of<ProfileProvider>(context, listen: false);
    profileProvider.getProfile().then((value) {
      log("message${profileProvider.profileData}");
      nameController.text = profileProvider.profileData["name"] ?? "";
      phoneController.text = profileProvider.profileData["mobile"].toString();
      emailController.text = profileProvider.profileData["email"].toString();
    });
  }

  bool isVisible = false;
  XFile? photo;
  final ImagePicker camera = ImagePicker();

  openGalleryPhoto(ImageSource imageSource) async {
    await camera.pickImage(source: imageSource).then((value) {
      photo = value;
      setState(() {});
      log("uploadImage${value!.path}");
    });
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    log("1111111111111${profileProvider.profileData}");
    log("123${profileProvider.profileData["profilePic"] != ""}");
    log("100${AppConstants.baseUrl}${profileProvider.profileData["profilePic"]}");
    log("karanChecking${profileProvider.profileData}");
    return Scaffold(
      appBar: AppBar(
        iconTheme: IconThemeData(color: AppColor.textBlack),
        centerTitle: true,
        title: const Text(
          "Profile",
          style: h1Style,
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Consumer<ProfileProvider>(
              builder: (context, value, child) {
                return Container(
                  height: 220,
                  margin: const EdgeInsets.only(left: 15, right: 15, top: 10),
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: AppColor.textWhite,
                      borderRadius: BorderRadius.circular(0),
                      boxShadow: const [
                        BoxShadow(
                          color: Colors.grey,
                          offset: Offset(
                            1.0,
                            2.0,
                          ),
                          blurRadius: 2.0,
                          spreadRadius: 2.0,
                        ), //BoxShadow
                        BoxShadow(
                          color: Colors.white,
                          offset: Offset(0.0, 0.0),
                          blurRadius: 50.0,
                          spreadRadius: 2.0,
                        ),
                      ]),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        margin: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            value.profileData["profilePic"] != ""
                                ? CircleAvatar(
                                    radius: 40,
                                    backgroundImage: NetworkImage(
                                      "${AppConstants.baseUrl}/${value.profileData["profilePic"]}",
                                    ),
                                  )
                                : CircleAvatar(
                                    radius: 40,
                                    backgroundImage: photo != null
                                        ? FileImage(File(photo!.path))
                                        : NetworkImage(
                                            "${AppConstants.baseUrl}/${value.profileData["profile_pic"]}",
                                          ) as ImageProvider,
                                  ),
                            IconButton(
                                onPressed: () {
                                  setState(() {
                                    isVisible = !isVisible;
                                  });
                                },
                                icon: const Icon(
                                  Icons.edit,
                                  size: 35,
                                ))
                          ],
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 20, top: 5),
                        child: Text(
                          '${value.profileData["name"] ?? ""}',
                          style: const TextStyle(
                              fontFamily: 'Avalon_Bold',
                              fontSize: 16,
                              fontWeight: FontWeight.bold),
                        ),
                      ),
                      Container(
                        padding:
                            const EdgeInsets.only(left: 20, right: 25, top: 5),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text('Mobile No. :',
                                        style: TextStyle(
                                            fontFamily: 'Avalon_Bold',
                                            fontSize: 16,
                                            color: AppColor.grey,
                                            fontWeight: FontWeight.bold)),
                                    Text('${value.profileData["mobile"] ?? ""}',
                                        style: TextStyle(
                                            fontFamily: 'Avalon_Bold',
                                            fontSize: 16,
                                            color: AppColor.grey)),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                      Container(
                          padding: const EdgeInsets.only(left: 20, top: 5),
                          child: Row(
                            children: [
                              Text('Email :',
                                  style: TextStyle(
                                      fontFamily: 'Avalon_Bold',
                                      fontSize: 16,
                                      color: AppColor.grey,
                                      fontWeight: FontWeight.bold)),
                              Text('${value.profileData["email"] ?? ""}',
                                  style: TextStyle(
                                      fontFamily: 'Avalon_Bold',
                                      fontSize: 16,
                                      color: AppColor.grey)),
                            ],
                          )),
                      Container(
                          padding: const EdgeInsets.only(left: 20, top: 5),
                          child: Row(
                            children: [
                              Text('Availability Leads:',
                                  style: TextStyle(
                                      fontFamily: 'Avalon_Bold',
                                      fontSize: 16,
                                      color: AppColor.grey,
                                      fontWeight: FontWeight.bold)),
                              Text('${value.profileData["leads"] ?? ""}',
                                  style: TextStyle(
                                      fontFamily: 'Avalon_Bold',
                                      fontSize: 16,
                                      color: AppColor.grey)),
                            ],
                          )),
                    ],
                  ),
                );
              },
            ),
            Visibility(
              visible: isVisible,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(
                    height: 20,
                  ),
                  Stack(
                    clipBehavior: Clip.none,
                    children: [
                      photo != null
                          ? CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey.withOpacity(.2),
                              backgroundImage: FileImage(File(photo!.path)),
                            )
                          : CircleAvatar(
                              radius: 50,
                              backgroundColor: Colors.grey.withOpacity(.2),
                              backgroundImage: NetworkImage(AppImage.noImage),
                            ),
                      Positioned(
                        right: -15,
                        bottom: -10,
                        child: IconButton(
                            onPressed: () async {
                              log("aaaaaaa");
                              await showDialog(
                                context: context,
                                builder: (ctx) => AlertDialog(
                                  content: TextButton(
                                      onPressed: () {
                                        openGalleryPhoto(ImageSource.camera);
                                      },
                                      child: const Text(
                                        "From Camera",
                                        style: h1Style,
                                      )),
                                  title: TextButton(
                                      onPressed: () {
                                        openGalleryPhoto(ImageSource.gallery);
                                      },
                                      child: const Text(
                                        "From Gallery",
                                        style: h1Style,
                                      )),
                                ),
                              );
                            },
                            icon: Icon(
                              Icons.camera_alt,
                              color: AppColor.textBlack,
                              size: 30,
                            )),
                      )
                    ],
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 30, 20, 0),
                    child: TextFormField(
                      controller: nameController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: AppColor.textBlack),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: AppColor.textBlack),
                            borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: ('Name'),
                        labelStyle: const TextStyle(
                            color: Colors.black, fontFamily: 'Avalon'),
                        contentPadding:
                            const EdgeInsets.only(top: 10, left: 20),
                      ),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: TextFormField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: AppColor.textBlack),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: AppColor.textBlack),
                            borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: ('Phone Number'),
                        labelStyle: const TextStyle(
                            color: Colors.black, fontFamily: 'Avalon'),
                        contentPadding:
                            const EdgeInsets.only(top: 10, left: 20),
                      ),
                      inputFormatters: [
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(10),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.fromLTRB(20, 10, 20, 0),
                    child: TextFormField(
                      controller: emailController,
                      cursorColor: Colors.black,
                      decoration: InputDecoration(
                        focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: AppColor.textBlack),
                            borderRadius: BorderRadius.circular(10)),
                        enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(width: 1, color: AppColor.textBlack),
                            borderRadius: BorderRadius.circular(10)),
                        filled: true,
                        fillColor: Colors.white,
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10)),
                        labelText: ('Email'),
                        labelStyle: const TextStyle(
                            color: Colors.black, fontFamily: 'Avalon'),
                        contentPadding:
                            const EdgeInsets.only(top: 10, left: 20),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      var p=_prefService.getDeviceId();
                      log("karan deviceId : $p");
                      ApiServices()
                          .updateProfile(
                        photo?.path,
                        nameController.text.trim(),
                        phoneController.text.trim(),
                        emailController.text.trim(),
                        p
                      )
                          .then((value) {
                        log("profileUpload$value");
                        Fluttertoast.showToast(
                            msg: "Profile Updated Successfully");
                        Provider.of<ProfileProvider>(context, listen: false)
                            .getProfile();
                        setState(() {
                          isVisible = false;
                        });
                      });
                    },
                    child: Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(
                          left: 20, right: 20, bottom: 10),
                      height: 45,
                      width: double.infinity,
                      decoration: BoxDecoration(
                          color: AppColor.textBlack,
                          borderRadius: BorderRadius.circular(10)),
                      child: Text(
                        'Submit',
                        style: TextStyle(
                            fontFamily: 'Avalon',
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: AppColor.textWhite),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
