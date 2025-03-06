import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wonderfood/data/local/local_notification_service.dart';
import 'package:wonderfood/data/model/received_notification.dart';
import 'package:wonderfood/data/model/restaurant.dart';
import 'package:wonderfood/provider/home/restaurant_list_provider.dart';
import 'package:wonderfood/provider/settings/payload_provider.dart';
import 'package:wonderfood/screen/common/rounded_sliver_app_bar.dart';
import 'package:wonderfood/screen/common/skeleton_loading.dart';
import 'package:wonderfood/screen/home/restaurant_list_item.dart';
import 'package:wonderfood/static/navigation_route.dart';
import 'package:wonderfood/static/restaurant_list_result_state.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  void _configureSelectNotificationSubject() {
    selectNotificationStream.stream.listen((String? payload) {
      context.read<PayloadProvider>().payload = payload;
      Navigator.pushNamed(
        context,
        NavigationRoute.detailRoute.name,
        arguments: Restaurant.fromJson(jsonDecode(payload ?? "")),
      );
    });
  }

  void _configureDidReceiveLocalNotificationSubject() {
    didReceiveLocalNotificationStream.stream.listen((
      ReceivedNotification receivedNotification,
    ) {
      final payload = receivedNotification.payload;
      context.read<PayloadProvider>().payload = payload;
      Navigator.pushNamed(
        context,
        NavigationRoute.detailRoute.name,
        arguments: Restaurant.fromJson(
          jsonDecode(receivedNotification.payload ?? ""),
        ),
      );
    });
  }

  @override
  void initState() {
    super.initState();
    _configureSelectNotificationSubject();
    _configureDidReceiveLocalNotificationSubject();
    Future.microtask(() {
      context.read<RestaurantListProvider>().fetchRestaurantList();
    });
  }

  @override
  void dispose() {
    selectNotificationStream.close();
    didReceiveLocalNotificationStream.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NavigationRoute.searchRoute.name);
        },
        tooltip: 'Search Restaurant',
        child: const Icon(Icons.search, size: 28),
      ),
      body: CustomScrollView(
        slivers: [
          RoundedSliverAppBar(isFirstPage: true),
          SliverPadding(
            padding: const EdgeInsets.all(9),
            sliver: Consumer<RestaurantListProvider>(
              builder: (context, value, child) {
                return switch (value.resultState) {
                  RestaurantListLoadingState() => SliverToBoxAdapter(
                    child: SizedBox(
                      height: MediaQuery.of(context).size.height,
                      child: SkeletonLoading(count: 10),
                    ),
                  ),
                  RestaurantListLoadedState(data: var restaurantList) =>
                    SliverList.separated(
                      itemCount: restaurantList.length,
                      itemBuilder: (context, index) {
                        final restaurant = restaurantList[index];
                        return InkWell(
                          child: RestaurantListItem(restaurant: restaurant),
                          onTap: () {
                            Navigator.pushNamed(
                              context,
                              NavigationRoute.detailRoute.name,
                              arguments: restaurant,
                            );
                          },
                        );
                      },
                      separatorBuilder: (BuildContext context, int index) {
                        return const SizedBox(height: 9);
                      },
                    ),
                  RestaurantListErrorState(error: var message) =>
                    SliverToBoxAdapter(
                      child: SizedBox(
                        height:
                            MediaQuery.of(context).size.height - kToolbarHeight,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Image.asset(
                              "assets/images/nodata.png",
                              width: 250,
                              height: 250,
                            ),
                            const SizedBox.square(dimension: 10),
                            Text(
                              message,
                              style: Theme.of(context).textTheme.bodyMedium,
                            ),
                          ],
                        ),
                      ),
                    ),
                  _ => SliverToBoxAdapter(
                    child: SizedBox(height: MediaQuery.of(context).size.height),
                  ),
                };
              },
            ),
          ),
        ],
      ),
    );
  }
}
