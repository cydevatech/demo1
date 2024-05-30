import 'dart:math';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:demo1/utils/string.dart';

class ImageAssets {
  static getImagePng(
    String image, {
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
    bool getTestImage = true,
    Alignment alignment = Alignment.center,
  }) {
    if (image.isUrl) {
      return networkImage(
        url: image,
        height: height,
        width: width,
        fit: fit,
        color: color,
        alignment: alignment,
      );
    } else {
      return pngAsset(
        image,
        height: height,
        width: width,
        fit: fit,
        color: color,
        alignment: alignment,
      );
    }
  }

  //! Get placeholder image
  static String getTestImage(int width, [int height = 0]) {
    return 'https://picsum.photos/$width${height > 0 ? '/$height' : ''}?x=${Random().nextInt(100)}';
  }

  static Widget networkImage({
    String? url,
    double? width,
    double? height,
    BoxFit? fit,
    Color? color,
    double? borderRadius = 0,
    Alignment alignment = Alignment.center,
    LoadingErrorWidgetBuilder? errorWidget,
  }) {
    return SizedBox(
      width: width ?? double.maxFinite,
      height: height,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(borderRadius ?? 0),
        child: CachedNetworkImage(
          alignment: alignment,
          imageUrl: url ?? '',
          fit: fit ?? BoxFit.cover,
          color: color,
          errorWidget: errorWidget ??
              (context, error, _) {
                return Container(
                  color: Colors.grey.withOpacity(0.3),
                );
              },
        ),
      ),
    );
  }

  static Widget pngAsset(
    String name, {
    Color? color,
    double? width,
    double? height,
    AlignmentGeometry alignment = Alignment.center,
    bool circle = false,
    BoxFit? fit,
  }) {
    return Image.asset(
      name,
      color: color,
      alignment: alignment,
      fit: fit ?? BoxFit.cover,
      width: width,
      height: height,
      errorBuilder: (context, error, _) {
        return Container();
      },
    );
  }

  static SvgPicture svgAssets(
    String name, {
    Color? color,
    double? width,
    double? height,
    BoxFit fit = BoxFit.contain,
  }) {
    return SvgPicture.asset(
      name,
      color: color,
      width: width,
      height: height,
      fit: fit,
    );
  }

  static Widget svgUrl(
    String name, {
    Color? color,
    double? width,
    double? height,
    bool circle = false,
    Widget? placeholderWidget,
    EdgeInsets padding = const EdgeInsets.all(6.0),
  }) {
    return Padding(
      padding: padding,
      child: SvgPicture.network(
        name,
        color: color,
        placeholderBuilder: (context) => placeholderWidget ?? Container(),
        width: width,
        height: height,
      ),
    );
  }
}
