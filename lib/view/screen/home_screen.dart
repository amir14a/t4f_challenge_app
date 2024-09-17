import 'package:animated_theme_switcher/animated_theme_switcher.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';
import 'package:t4f_challenge_app/repository/colors.dart';
import 'package:t4f_challenge_app/view/screen/item_details_screen.dart';
import 'package:t4f_challenge_app/view/widget/item_widget.dart';
import 'package:t4f_challenge_app/view/widget/network_widget.dart';
import 'package:t4f_challenge_app/viewmodel/home_view_model.dart';
import 'package:url_launcher/url_launcher_string.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((c) {
      context.read<HomeViewModel>().getItemsFromApi();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<HomeViewModel>(
      builder: (BuildContext context, HomeViewModel vm, Widget? child) => ThemeSwitchingArea(
        child: Scaffold(
          appBar: AppBar(
            title: const Text('T4F.ir Challenge App'),
            centerTitle: true,
            leading: ThemeSwitcher(
              builder: (c) => IconButton(
                onPressed: () {
                  vm.toggleDarkMode(c);
                },
                icon: vm.isDarkMode ? const Icon(Icons.dark_mode) : const Icon(Icons.dark_mode_outlined),
              ),
            ),
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                bottomRight: Radius.circular(8),
                bottomLeft: Radius.circular(8),
              ),
            ),
          ),
          body: Column(
            children: [
              Expanded(
                child: RefreshIndicator(
                  onRefresh: () => vm.getItemsFromApi(),
                  child: CustomScrollView(
                    slivers: [
                      SliverFillRemaining(
                        child: Column(
                          children: [
                            SizedBox(
                              width: double.infinity,
                              child: Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Text(
                                  'List of latest products:',
                                  style: Theme.of(context).textTheme.titleLarge,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ),
                            Expanded(
                              child: AppNetworkWidget(
                                state: vm.requestState,
                                successBuilder: () => AnimatedSwitcher(
                                  duration: kThemeAnimationDuration * 2,
                                  transitionBuilder: (child, anim) {
                                    return SlideTransition(
                                      position: anim.drive(
                                          Tween<Offset>(begin: const Offset(-.4, 0), end: const Offset(0, 0))),
                                      child: FadeTransition(
                                        opacity: anim,
                                        child: child,
                                      ),
                                    );
                                  },
                                  child: ListView.builder(
                                    key: vm.listKey,
                                    scrollDirection: Axis.horizontal,
                                    controller: vm.listController,
                                    itemCount: vm.items.value!.length,
                                    itemBuilder: (BuildContext context, int index) => ItemWidget(
                                      key: Key(vm.items.value![index].id.toString()),
                                      model: vm.items.value![index],
                                      onTap: () async {
                                        await Navigator.of(context).push(
                                          CupertinoPageRoute(
                                            builder: (context) => ItemDetailsScreen(model: vm.items.value![index]),
                                          )..completed.then((c) {
                                              //When page transition animations end
                                              vm.saveLastVisitedItem(vm.items.value![index].id!);
                                            }),
                                        );
                                      },
                                    ),
                                  ),
                                ),
                                loadingBuilder: () => Shimmer.fromColors(
                                  baseColor: Colors.grey.withOpacity(.5),
                                  highlightColor: Colors.grey,
                                  period: kThemeAnimationDuration * 4,
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 268,
                                        child: ListView(
                                          scrollDirection: Axis.horizontal,
                                          children: List.filled(
                                            4,
                                            Container(
                                              width: 300,
                                              margin: const EdgeInsets.all(8),
                                              decoration: BoxDecoration(
                                                color: Colors.grey,
                                                borderRadius: BorderRadius.circular(16),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                failedBuilder: () => Center(
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      const Icon(Icons.wifi_off, size: 120),
                                      const Text('Please check your network...'),
                                      IconButton(
                                        onPressed: vm.getItemsFromApi,
                                        icon: const Icon(Icons.refresh),
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text('© AmirAbbas Jannatian', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
              ),
              InkWell(
                onTap: () => launchUrlString('https://github.com/amir14a/t4f_challenge_app'),
                borderRadius: BorderRadius.circular(8),
                child: const Padding(
                  padding: EdgeInsets.all(8.0),
                  child: Text('Source code on Github', style: TextStyle(color: AppColors.linkTextColor)),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
