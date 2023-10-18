import 'dart:developer';

import 'package:bike_services_vendor/provider/subscription_history_provider.dart';
import 'package:bike_services_vendor/utils/app_style.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../utils/color.dart';

class SubscriptionHistory extends StatefulWidget {
  const SubscriptionHistory({Key? key}) : super(key: key);

  @override
  State<SubscriptionHistory> createState() => _SubscriptionHistoryState();
}

class _SubscriptionHistoryState extends State<SubscriptionHistory> {
  late SubscriptionHistoryProvider subscriptionHistoryProvider;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    load();
  }

  load() {
    subscriptionHistoryProvider =
        Provider.of<SubscriptionHistoryProvider>(context, listen: false);
    subscriptionHistoryProvider.getSubscriptionHistory();
  }

  @override
  Widget build(BuildContext context) {
    subscriptionHistoryProvider =
        Provider.of<SubscriptionHistoryProvider>(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text("Subscription History", style: h1Style),
      ),
      body: Center(
        child: subscriptionHistoryProvider.isLoading
            ? CircularProgressIndicator(
                color: AppColor.btnColor,
              )
            : subscriptionHistoryProvider.subscriptionHistory.isEmpty
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
                    itemCount:
                        subscriptionHistoryProvider.subscriptionHistory.length,
                    itemBuilder: (BuildContext context, int index) {
                      log("history${subscriptionHistoryProvider.subscriptionHistory[index].title}");
                      final displayIndex = index + 1;
                      return ListTile(
                        leading: Text("$displayIndex",style: h1Style,),
                        trailing: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "₹ ${subscriptionHistoryProvider.subscriptionHistory[index].price ?? ""}",
                              style: textColor,
                            ),
                            Text(
                              subscriptionHistoryProvider
                                      .subscriptionHistory[index].validity ??
                                  "",
                              style: textColor,
                            ),
                          ],
                        ),
                        title: Text(
                          subscriptionHistoryProvider
                                  .subscriptionHistory[index].title ??
                              "",
                          style: h1Style,
                        ),
                        subtitle: Text(
                          subscriptionHistoryProvider
                                  .subscriptionHistory[index].subTitle ??
                              "",
                          style: h4StyleLight,
                        ),
                      );
                    }),
      ),
    );
  }
}
