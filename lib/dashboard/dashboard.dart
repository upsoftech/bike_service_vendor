import 'dart:developer';
import 'dart:io';
import 'package:bike_services_vendor/dashboard/subscription_history.dart';
import 'package:bike_services_vendor/dashboard/subscription_plan.dart';
import 'package:bike_services_vendor/provider/order_provider.dart';
import 'package:bike_services_vendor/routes/app_routes_constant.dart';
import 'package:bike_services_vendor/services/api_services.dart';
import 'package:bike_services_vendor/utils/app_constant.dart';
import 'package:bike_services_vendor/utils/app_style.dart';
import 'package:bike_services_vendor/utils/color.dart';
import 'package:bike_services_vendor/utils/image.dart';
import 'package:bike_services_vendor/dashboard/order_list.dart';
import 'package:bike_services_vendor/dashboard/pickup_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../provider/banner_provider.dart';
import 'completed_order.dart';

class DashBoardScreen extends StatefulWidget {
  const DashBoardScreen({Key? key}) : super(key: key);

  @override
  State<DashBoardScreen> createState() => _DashBoardScreenState();
}

class _DashBoardScreenState extends State<DashBoardScreen>
    with SingleTickerProviderStateMixin {
  late TabController tabController;
  late OrderProvider orderProvider;

  @override
  void initState() {
    tabController = TabController(length: 3, vsync: this);
    super.initState();
    loadData();
  }

  @override
  void dispose() {
    tabController.dispose();
    super.dispose();
  }

  loadData() {
    final dashboardProvider =
        Provider.of<DashboardProvider>(context, listen: false);
    dashboardProvider.getBanners();
    // orderProvider = Provider.of<OrderProvider>(context, listen: false);
    // orderProvider.getOrder("process");
  }

  bool status = false;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    final dashboardProvider = Provider.of<DashboardProvider>(
      context,
    );
    return WillPopScope(
      onWillPop: () async {
        if (_selectedIndex > 0) {
          _selectedIndex = 0;
          setState(() {});
          return false;
        } else {
          final shouldPop = await showDialog<bool>(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text(
                  'Do you want to close app ?',
                  style: discountTextStyle,
                ),
                actionsAlignment: MainAxisAlignment.end,
                actions: [
                  TextButton(
                    onPressed: () {
                      exit(0);
                    },
                    child: Text(
                      'Yes',
                      style: offTextStyle,
                    ),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.pop(context, false);
                    },
                    child: Text(
                      'No',
                      style: offTextStyle,
                    ),
                  ),
                ],
              );
            },
          );
          return shouldPop!;
        }
      },
      child: DefaultTabController(
        length: 3,
        child: Scaffold(
          appBar: AppBar(
            elevation: 0,
            automaticallyImplyLeading: false,
            backgroundColor: Colors.transparent,
            iconTheme: IconThemeData(color: AppColor.textBlack),
            title: Consumer<DashboardProvider>(
              builder: (context, value, child) {
                final message = status
                    ? 'Your account is active'
                    : 'Your account is deactivated';
                return Switch(
                  // activeColor: AppColor.btnColor,
                  activeTrackColor: Colors.grey,
                  inactiveTrackColor: Colors.green,
                  inactiveThumbColor: Colors.white,
                  value: status,
                  onChanged: (value) {
                    ApiServices().userActive().then((value) {
                      log("user$value");
                      Fluttertoast.showToast(msg: message);
                    });
                    setState(() {
                      status = value;
                    });
                  },
                );
              },
            ),
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(4.0),
              child: Container(
                color: AppColor.grey,
                height: 1.0,
              ),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const SubscriptionHistory()));
                  },
                  icon: const Icon(
                    Icons.history_rounded,
                    size: 30,
                  )),
              SizedBox(
                width: 5,
              ),
              GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const PlanPage()));
                  },
                  child: Image.asset(
                    AppImage.plan,
                    height: 25,
                    width: 25,
                  )),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: IconButton(
                    onPressed: () {
                      GoRouter.of(context)
                          .pushNamed(AppConstantRoute.profileRoute);
                    },
                    icon: const Icon(
                      Icons.person,
                      size: 30,
                    )),
              ),
              IconButton(
                  onPressed: () async {
                    SharedPreferences pref =
                        await SharedPreferences.getInstance();
                    await pref.clear().then((value) {
                      Navigator.popUntil(context, (route) => route.isFirst);
                      GoRouter.of(context)
                          .pushReplacementNamed(AppConstantRoute.loginRoute);
                    });
                  },
                  icon: const Icon(
                    Icons.logout_outlined,
                    size: 30,
                  )),
            ],
          ),
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: SizedBox(
              height: MediaQuery.of(context).size.height,
              child: Column(
                children: [
                  const SizedBox(height: 5),
                  Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 5,
                          vertical: 10,
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: dashboardProvider.bannerList.isNotEmpty
                              ? ImageSlideshow(
                                  width: double.infinity,
                                  height: 200,
                                  initialPage: 0,
                                  indicatorColor: AppColor.btnColor,
                                  indicatorBackgroundColor: AppColor.grey,
                                  onPageChanged: (value) {
                                    //  print('Page changed: $value');
                                  },
                                  autoPlayInterval: 3000,
                                  isLoop: true,
                                  children:
                                      dashboardProvider.bannerList.map((e) {
                                    return e["bannerImage"].toString() != ""
                                        ? Image.network(
                                            // ignore: prefer_interpolation_to_compose_strings
                                            "${AppConstants.baseUrl}uploads/banners/" +
                                                e["bannerImage"],
                                            fit: BoxFit.cover,
                                          )
                                        : Image.network(
                                            AppImage.noImage,
                                            fit: BoxFit.cover,
                                          );
                                  }).toList())
                              : const SizedBox(),
                        ),
                      ),
                      Container(
                        width: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(
                            color: AppColor.textBlack,
                            borderRadius: BorderRadius.circular(5)),
                        child: Column(
                          children: [
                            TabBar(
                              labelStyle: h1Style,
                              unselectedLabelColor: Colors.white,
                              labelColor: AppColor.textBlack,
                              indicatorColor: Colors.transparent,
                              indicatorPadding: const EdgeInsets.all(5),
                              indicatorSize: TabBarIndicatorSize.values[0],
                              indicator: BoxDecoration(
                                color: AppColor.textWhite,
                                borderRadius: BorderRadius.circular(10),
                              ),
                              controller: tabController,
                              tabs: const [
                                Tab(
                                  text: 'Active',
                                ),
                                Tab(
                                  text: 'Picked',
                                ),
                                Tab(
                                  text: 'Completed',
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  Expanded(
                    flex: 1,
                    child: TabBarView(
                      controller: tabController,
                      children: const [
                        OrderList(),
                        PickupPage(),
                        CompletedOrder(),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
