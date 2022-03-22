import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

import '../../core_export.dart';

class NetworkSensitive extends StatelessWidget {
  final Widget child;
  final double opacity;
  const NetworkSensitive({
    required this.child,
    this.opacity = 0.5,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get our connection status from the provider
    var connectionStatus = Provider.of<ConnectivityStatus>(context);

    if (connectionStatus == ConnectivityStatus.WiFi) {
      return child;
    }

    if (connectionStatus == ConnectivityStatus.Cellular) {
      return child;
    }

    return Stack(
      children: [
        Opacity(
          opacity: 0.1,
          child: child,
        ),
        Container(
          height: double.infinity,
          width: double.infinity,
          color: Colors.grey.withOpacity(.1),
          child: Shimmer.fromColors(
            baseColor: Colors.red.shade200,
            highlightColor: Colors.red.shade800,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(height: 100),
                  const Icon(
                    Icons.error_outline,
                    color: Colors.red,
                    size: 50,
                  ),
                  const SizedBox(height: 20),
                  Text(
                    'No internet connections',
                    style: TextStyle(
                      fontSize: 10,
                      color: Colors.redAccent.shade200,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
