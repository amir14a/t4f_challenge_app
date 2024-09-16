import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:t4f_challenge_app/main.dart';
import 'package:t4f_challenge_app/repository/themes.dart';
import 'package:t4f_challenge_app/view/widget/item_widget.dart';
import 'package:t4f_challenge_app/view/widget/network_widget.dart';
import 'package:t4f_challenge_app/viewmodel/home_view_model.dart';

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
      builder: (BuildContext context, HomeViewModel vm, Widget? child) => Scaffold(
        appBar: AppBar(
          title: const Text('T4F.ir Challenge App'),
          centerTitle: true,
          leading: IconButton(
            onPressed: () {
              vm.toggleDarkMode();
            },
            icon: vm.isDarkMode ? const Icon(Icons.dark_mode) : const Icon(Icons.dark_mode_outlined),
          ),
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(8),
              bottomLeft: Radius.circular(8),
            ),
          ),
        ),
        body: RefreshIndicator(
          onRefresh: () => vm.getItemsFromApi(),
          child: Column(
            children: [
              SizedBox(
                width: double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(
                    'List of latest items:',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.start,
                  ),
                ),
              ),
              Expanded(
                child: AppNetworkWidget(
                  state: vm.requestState,
                  successBuilder: () => ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: vm.items.value!.length,
                    itemBuilder: (BuildContext context, int index) => ItemWidget(
                      model: vm.items.value![index],
                      onTap: () {},
                    ),
                  ),
                  loadingBuilder: () => const Center(child: CircularProgressIndicator()),
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
      ),
    );
  }
}
