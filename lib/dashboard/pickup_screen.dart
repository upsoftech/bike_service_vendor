import 'dart:developer';

import 'package:bike_services_vendor/dashboard/testmap_disatnce.dart';
import 'package:bike_services_vendor/utils/app_constant.dart';
import 'package:bike_services_vendor/utils/image.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:intl/intl.dart';
import 'package:maps_launcher/maps_launcher.dart';
import 'package:provider/provider.dart';
import 'package:url_launcher/url_launcher.dart';
import '../provider/order_provider.dart';
import '../services/api_services.dart';
import '../utils/app_style.dart';
import '../utils/color.dart';

class PickupPage extends StatefulWidget {
  const PickupPage({
    Key? key,
  }) : super(key: key);
  @override
  State<PickupPage> createState() => _PickupPageState();
}

class _PickupPageState extends State<PickupPage> {
  late OrderProvider orderProvider;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() {
    orderProvider = Provider.of<OrderProvider>(context, listen: false);
    orderProvider.getOrder2("picked");
  }

  String formatDateString(String dateString) {
    final parsedDate = DateTime.parse(dateString);
    final formattedDate = DateFormat('d MMMM y, hh:mm a').format(parsedDate);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    orderProvider = Provider.of<OrderProvider>(
      context,
    );
    //log("pickImage : ${AppConstants.baseUrl+""+orderProvider.orderList2[1].frontImage.toString()}");
    log("loghh2${orderProvider.orderList2.length}");
    return Scaffold(
        body: orderProvider.isLoading
            ? Center(
              child: CircularProgressIndicator(
                  color: AppColor.btnColor,
                ),
            )
            : orderProvider.orderList2.isEmpty
                ? Center(
                    child: Text(
                      "No Data",
                      style: TextStyle(
                          color: AppColor.btnColor,
                          fontSize: 18,
                          fontFamily: "Avalon_Bold",
                          fontWeight: FontWeight.w500),
                    ),
                  )
                : ListView.builder(
                    itemCount: orderProvider.orderList2.length,
                    itemBuilder: (context, index) {
                      return Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                            color: AppColor.btnColor.withOpacity(.1),
                            borderRadius: BorderRadius.circular(10)),
                        margin: const EdgeInsets.all(10),
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                const Text(
                                  "OrderID :",
                                  style: h4StyleLight,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      .07,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      .6,
                                  child: Text(
                                    orderProvider.orderList2[index].id
                                        .toString(),
                                    style: subTitleBoldText,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Name :",
                                  style: h4StyleLight,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      .11,
                                ),
                                Text(
                                  orderProvider.orderList2[index].userData
                                          ?.name ??
                                      "",
                                  style: subTitleBoldText,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Services :",
                                  style: h4StyleLight,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      .05,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      .56,
                                  child: Text(
                                    orderProvider.orderList2[index].services
                                        .toString(),
                                    style: subTitleBoldText,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Price :",
                                  style: h4StyleLight,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      .12,
                                ),
                                Text(
                                  "₹ ${orderProvider.orderList2[index].price.toString()}",
                                  style: subTitleBoldText,
                                ),
                              ],
                            ),
                            Row(
                              children: [
                                const Text(
                                  "Date & time :",
                                  style: h4StyleLight,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      .01,
                                ),
                                Text(
                                  formatDateString(orderProvider
                                      .orderList2[index].createdAt
                                      .toString()),
                                  style: subTitleBoldText,
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const Text(
                                  "Pickup Address :",
                                  style: h4StyleLight,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      .01,
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context)
                                      .size
                                      .width *
                                      .52,
                                  child: Text(
                                    orderProvider
                                        .orderList2[index].pickUpAddress
                                        .toString(),
                                    style: subTitleBoldText,
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * .02,
                            ),
                            Padding(
                              padding: const EdgeInsets.all(4.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(orderProvider
                                                          .orderList2[index]
                                                          .frontImage !=
                                                      null
                                                  ? "${AppConstants.baseUrl}${orderProvider.orderList2[index].frontImage}"
                                                  : AppImage.noImage),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                  // SizedBox(
                                  //   width: MediaQuery.of(context).size.width * .02,
                                  // ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(orderProvider
                                                          .orderList2[index]
                                                          .backImage !=
                                                      null
                                                  ? "${AppConstants.baseUrl}${orderProvider.orderList2[index].backImage}"
                                                  : AppImage.noImage),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(orderProvider
                                                          .orderList2[index]
                                                          .rightImage !=
                                                      null
                                                  ? "${AppConstants.baseUrl}${orderProvider.orderList2[index].rightImage}"
                                                  : AppImage.noImage),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                  ClipRRect(
                                    borderRadius: BorderRadius.circular(15),
                                    child: Container(
                                      height: 70,
                                      width: 70,
                                      decoration: BoxDecoration(
                                          image: DecorationImage(
                                              image: NetworkImage(orderProvider
                                                          .orderList2[index]
                                                          .leftImage !=
                                                      null
                                                  ? "${AppConstants.baseUrl}${orderProvider.orderList2[index].leftImage}"
                                                  : AppImage.noImage),
                                              fit: BoxFit.cover)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(
                              height:
                                  MediaQuery.of(context).size.height * .01,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    launchUrl(Uri.parse(
                                        "tel:${orderProvider.orderList2[index].userData?.mobile}"));
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    height: 30,
                                    width: 40,
                                    decoration: BoxDecoration(
                                        color: AppColor.btnColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: Icon(
                                      Icons.call,
                                      size: 15,
                                      color: AppColor.textWhite,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      .02,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    ApiServices()
                                        .sendToPicked(
                                            "completed",
                                            orderProvider
                                                .orderList2[index].id
                                                .toString())
                                        .then((value) {
                                      Fluttertoast.showToast(
                                          msg: "Assign to Completed");
                                      orderProvider.orderList2
                                          .removeAt(index);
                                      setState(() {});
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    alignment: Alignment.center,
                                    height: 30,
                                    width:MediaQuery.of(context).size.width*.34,
                                    decoration: BoxDecoration(
                                        color: AppColor.btnColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Text(
                                      "Complete",
                                      style: smallStyle,
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  width: MediaQuery.of(context).size.width *
                                      .02,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    // Navigator.push(
                                    //     context,
                                    //     MaterialPageRoute(
                                    //         builder: (context) => const TrackLocation()));
                                    MapsLauncher.launchQuery(
                                        '${orderProvider.orderList2[index].pickUpAddress}');
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 5),
                                    alignment: Alignment.center,
                                    height: 30,
                                    width:MediaQuery.of(context).size.width*.34,
                                    decoration: BoxDecoration(
                                        color: AppColor.btnColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                    child: const Text(
                                      "Track Location",
                                      style: smallStyle,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      );
                    }));
  }
}
