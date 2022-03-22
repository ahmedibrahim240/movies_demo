import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../core_export.dart';

class CustomCachedNetworkImage extends StatelessWidget {
  final String? url;
  final BuildContext context;
  final BoxFit? boxFit;
  final double? width;
  final double? height;
  final double? borderRadius;
  final double borderTopLeftRadius;
  final double borderTopRightRadius;
  final double borderBottomLeftRadius;
  final double borderBottomRightRadius;
  final bool isOnlyRadius;
  const CustomCachedNetworkImage({
    Key? key,
    this.url,
    required this.context,
    this.boxFit,
    this.width,
    this.height,
    this.isOnlyRadius = false,
    this.borderRadius,
    this.borderBottomLeftRadius = 0,
    this.borderBottomRightRadius = 0,
    this.borderTopLeftRadius = 0,
    this.borderTopRightRadius = 0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: (isOnlyRadius)
          ? BorderRadius.only(
              topLeft: Radius.circular(borderTopLeftRadius),
              topRight: Radius.circular(borderTopRightRadius),
              bottomLeft: Radius.circular(borderBottomLeftRadius),
              bottomRight: Radius.circular(borderBottomRightRadius),
            )
          : BorderRadius.circular(borderRadius ?? 0.0),
      child: (Uri.parse(url!).isAbsolute)
          ? CachedNetworkImage(
              imageUrl: url!,
              fit: (boxFit) ?? BoxFit.cover,
              width: width,
              height: height,
              placeholder: (context, url) => Center(
                child: SpinKitWave(
                  color: Colors.redAccent.shade400,
                  size: Utilities.defaultSize * 2,
                ),
              ),
              errorWidget: (context, url, error) => const Icon(Icons.error),
            )
          : Icon(
              Icons.image,
              color: Colors.redAccent.shade400,
            ),
    );
  }
}
