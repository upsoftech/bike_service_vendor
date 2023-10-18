import 'dart:developer';

import 'package:bike_services_vendor/services/api_services.dart';
import 'package:bike_services_vendor/utils/app_style.dart';
import 'package:bike_services_vendor/utils/color.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class PlanPage extends StatefulWidget {
  const PlanPage({Key? key}) : super(key: key);

  @override
  State<PlanPage> createState() => _PlanPageState();
}

class _PlanPageState extends State<PlanPage> {
  final List<SubscriptionPlan> plans = [
    SubscriptionPlan('Normal Plan', 'Basic features', '15000.00', '38'),
    SubscriptionPlan('Silver Plan', 'Additional features', '25000.00', '63'),
    SubscriptionPlan('Gold Plan', 'Premium features', '50000.00', '125'),
    SubscriptionPlan('Platinum Plan', 'VIP access', '100000.00', '250'),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.transparent,
        iconTheme: const IconThemeData(color: Colors.black),
        title: const Text(
          "My Plan",
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            const SizedBox(height: 20),
            Expanded(
              child: ListView.builder(
                itemCount: plans.length,
                itemBuilder: (BuildContext context, int index) {
                  return SizedBox(
                    width: 350,
                    child: SubscriptionCard(plan: plans[index]),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SubscriptionCard extends StatelessWidget {
  final SubscriptionPlan plan;

  const SubscriptionCard({Key? key, required this.plan});

  @override
  Widget build(BuildContext context) {
    // Define a map to associate plan names with background colors
    final Map<String, Color> planColors = {
      'Normal Plan': const Color(0xFF797979),
      'Silver Plan': const Color(0xFFC0C0C0),
      'Gold Plan': const Color(0xFFFFD700),
      'Platinum Plan': Colors.blueGrey,
    };

    final backgroundColor = planColors[plan.name] ??
        AppColor.btnColor; // Default to AppColor.btnColor

    return Card(
      margin: const EdgeInsets.all(16),
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      color: backgroundColor, // Set the background color
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Center(
              child: Text(
                plan.name,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                Text(
                  plan.description,
                  style: h4StyleLight,
                ),
                Text(
                  "No of leads ${plan.leads}",
                  style: h1Style,
                ),
                const SizedBox(
                  height: 15,
                ),
                // Text(
                //  "₹ ${plan.price}/${plan.months}",
                //   style: const TextStyle(
                //     fontSize: 20,
                //     fontWeight: FontWeight.bold,
                //     color: Colors.blue,
                //   ),
                // ),
                const SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    ApiServices()
                        .subscriptionPlan(
                            plan.name, plan.description, plan.leads, plan.price
                            //  plan.months
                            )
                        .then((value) {
                      log("checking$value");
                      if (value["status"] == 1) {
                        Fluttertoast.showToast(msg: "Subscription successful");
                      } else {
                        Fluttertoast.showToast(msg: "Subscription failed");
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: backgroundColor,
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    textStyle: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  child: const Text(
                    'Subscribe Now',
                    style: appbarStyle,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class SubscriptionPlan {
  final String name;
  final String description;
  final String price;
  final String leads;

  SubscriptionPlan(
    this.name,
    this.description,
    this.price,
    this.leads,
  );
}
