import 'package:flutter/material.dart';
import 'package:t4f_challenge_app/repository/enums.dart';

class AppNetworkWidget extends StatelessWidget {
  final Widget Function() loadingBuilder;
  final Widget Function() successBuilder;
  final Widget Function() failedBuilder;
  final ValueNotifier<AppApiRequestState> state;

  const AppNetworkWidget(
      {super.key, required this.successBuilder, required this.loadingBuilder, required this.failedBuilder, required this.state});

  @override
  Widget build(BuildContext context) {
    return AnimatedSize(
      duration: kThemeAnimationDuration,
      child: AnimatedSwitcher(
        duration: kThemeAnimationDuration,
        child: state.value == AppApiRequestState.SUCCESS
            ? successBuilder.call()
            : state.value == AppApiRequestState.SENDING
                ? loadingBuilder.call()
                : state.value == AppApiRequestState.FAILED
                    ? failedBuilder.call()
                    : const SizedBox(),
      ),
    );
  }
}
