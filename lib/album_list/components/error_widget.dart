import 'package:flutter/material.dart';
import 'package:navatech_assignment/generated/l10n.dart';

abstract class BaseErrorWidget extends StatelessWidget {
  const BaseErrorWidget({
    super.key,
    required this.displayMessage,
    required this.onRetryPressed,
  });

  final String displayMessage;
  final VoidCallback onRetryPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        buildErrorIcon(),
        const SizedBox(height: 24),
        buildErrorText(),
        const SizedBox(height: 36),
        ElevatedButton(
          onPressed: onRetryPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 16.0,
              horizontal: 24,
            ),
            child: Text(Strings.of(context).retry),
          ),
        ),
      ],
    );
  }

  Widget buildErrorIcon();

  Widget buildErrorText() {
    return Text(
      displayMessage,
      style: const TextStyle(
        color: Colors.black,
        fontSize: 20,
      ),
      textAlign: TextAlign.center,
    );
  }
}

class NoNetworkErrorWidget extends BaseErrorWidget {
  const NoNetworkErrorWidget({
    super.key,
    required super.displayMessage,
    required super.onRetryPressed,
  });

  @override
  Widget buildErrorIcon() {
    return const Icon(
      Icons.wifi_off,
      size: 100,
    );
  }
}

class UnknownErrorWidget extends BaseErrorWidget {
  const UnknownErrorWidget({
    super.key,
    required super.displayMessage,
    required super.onRetryPressed,
  });

  @override
  Widget buildErrorIcon() {
    return const Icon(
      Icons.error,
      size: 100,
    );
  }
}
