import 'package:maps_launcher/maps_launcher.dart';
import 'package:bike_services_vendor/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';
import '../provider/order_provider.dart';
import '../routes/app_routes_constant.dart';
import '../services/ring_service.dart';
import 'test_track.dart';
import '../utils/app_style.dart';
import '../utils/color.dart';
import 'dart:developer';

class OrderList extends StatefulWidget {
  const OrderList({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderList> createState() => _OrderListState();
}

class _OrderListState extends State<OrderList> {
  late OrderProvider orderProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    loadData();
  }

  loadData() {
    orderProvider = Provider.of<OrderProvider>(context, listen: false);
    orderProvider.getOrder("process");
  }

  String formatDateString(String dateString) {
    final parsedDate = DateTime.parse(dateString);
    final formattedDate = DateFormat('d MMMM y, hh:mm a').format(parsedDate);
    return formattedDate;
  }

  @override
  Widget build(BuildContext context) {
    orderProvider = Provider.of<OrderProvider>(context);
    log("loggg${orderProvider.orderList.length}");
    return Scaffold(
        body: orderProvider.isLoading
            ? Center(
                child: CircularProgressIndicator(
                  color: AppColor.btnColor,
                ),
              )
            : orderProvider.orderList.isEmpty
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
                : Consumer<OrderProvider>(
                  builder: (BuildContext context, value, Widget? child) {
                    return ListView.builder(
                        itemCount: value.orderList.length,
                        shrinkWrap: true,
                        primary: false,
                        itemBuilder: (context, index) {
                          return Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                                color: AppColor.btnColor.withOpacity(.1),
                                borderRadius: BorderRadius.circular(10)),
                            margin: const EdgeInsets.all(5),
                            padding: const EdgeInsets.all(5),
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
                                      width:
                                      MediaQuery.of(context).size.width * .02,
                                    ),
                                    SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width * .54,
                                      child: Text(
                                        value.orderList[index].id
                                            .toString(),
                                        style: subTitleBoldText,
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width * .02,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        launchUrl(Uri.parse(
                                            "tel:${value.orderList[index].userData?.mobile}"));
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
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Bike Name :",
                                      style: h4StyleLight,
                                    ),
                                    SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width * .01,
                                    ),
                                    Text(
                                      value.orderList[index].bikeName
                                          .toString(),
                                      style: subTitleBoldText,
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
                                      width:
                                      MediaQuery.of(context).size.width * .11,
                                    ),
                                    Text(
                                      orderProvider
                                          .orderList[index].userData?.name ??
                                          "",
                                      style: subTitleBoldText,
                                    ),
                                  ],
                                ),
                                Row(
                                  children: [
                                    const Text(
                                      "Model No :",
                                      style: h4StyleLight,
                                    ),
                                    SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width * .04,
                                    ),
                                    Text(
                                      value.orderList[index].bikeModel
                                          .toString(),
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
                                      width:
                                      MediaQuery.of(context).size.width * .06,
                                    ),
                                    SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width * .56,
                                      child: Text(
                                        value.orderList[index].services
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
                                      width:
                                      MediaQuery.of(context).size.width * .12,
                                    ),
                                    Text(
                                      "₹ ${value.orderList[index].price.toString()}",
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
                                      width:
                                      MediaQuery.of(context).size.width * .01,
                                    ),
                                    Text(
                                      formatDateString(orderProvider
                                          .orderList[index].createdAt
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
                                      width:
                                      MediaQuery.of(context).size.width * .01,
                                    ),
                                    SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width * .52,
                                      child: Text(
                                        value.orderList[index].pickUpAddress
                                            .toString(),
                                        style: subTitleBoldText,
                                      ),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: MediaQuery.of(context).size.height * .02,
                                ),
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        RingService.stopSirenSound();
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        alignment: Alignment.center,
                                        height: 30,
                                        width:MediaQuery.of(context).size.width*.17,
                                        decoration: BoxDecoration(
                                            color: AppColor.btnColor,
                                            borderRadius:
                                            BorderRadius.circular(10)),
                                        child: const Text(
                                          "Accept",
                                          style: smallStyle,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width * .01,
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        log("process : ${value.orderList[index].frontImage}");

                                        if (value.orderList[index].frontImage !=
                                            null &&
                                            value.orderList[index].backImage !=
                                                null &&
                                            value.orderList[index].leftImage !=
                                                null &&
                                            value.orderList[index].rightImage !=
                                                null) {  ApiServices()
                                            .sendToPicked(
                                          "picked",
                                          value.orderList[index].id,
                                        )
                                            .then((value) {
                                          log("Picked$value");
                                          //
                                          // if (value == "success") {
                                          Fluttertoast.showToast(
                                              msg: "Assign To Pickup");
                                          orderProvider.removeActiveOrder(index);
                                          // RingService.stopSirenSound();

                                          print(
                                              "List length before removal: ${value.orderList.length}");
                                          setState(() {
                                            print(
                                                "List length after removal: ${value.orderList.length}");
                                          });
                                        });
                                        }else{
                                          Fluttertoast.showToast(msg: "Please Upload Image");
                                        }


                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        alignment: Alignment.center,
                                        height: 30,
                                        width:MediaQuery.of(context).size.width*.14,
                                        decoration: BoxDecoration(
                                            color: AppColor.btnColor,
                                            borderRadius:
                                            BorderRadius.circular(10)),
                                        child: const Text(
                                          "Pick",
                                          style: smallStyle,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width * .01,
                                    ),
                                    GestureDetector(
                                      onTap: ()async {
                                  var data =   await   GoRouter.of(context).pushNamed(
                                          AppConstantRoute.addPhotoRoute,
                                          extra: value.orderList[index].id,
                                        );

                                  if(data!=null && data == "Uploaded"){
                                    loadData();
                                  }
                                      },
                                      child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 5),
                                        alignment: Alignment.center,
                                        height: 30,
                                        width:MediaQuery.of(context).size.width*.22,
                                        decoration: BoxDecoration(
                                            color: AppColor.btnColor,
                                            borderRadius:
                                            BorderRadius.circular(10)),
                                        child: const Text(
                                          "Add Photo",
                                          style: smallStyle,
                                        ),
                                      ),
                                    ),
                                    SizedBox(
                                      width:
                                      MediaQuery.of(context).size.width * .005,
                                    ),
                                    GestureDetector(
                                      onTap: () async {
                                        //  Navigator.push(context, MaterialPageRoute(builder: (context)=>OrderTrackingPage()));
                                        MapsLauncher.launchQuery(
                                            '${value.orderList[index].pickUpAddress}');
                                        Fluttertoast.showToast(msg: "msg");
                                        log("msg");
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
                                )
                              ],
                            ),
                          );
                        });
                  },

                ));
  }
}
