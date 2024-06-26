import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get/get.dart';
import '../../../utils/app_images.dart';

enum ImageType { png, network, decorationImage }

class CustomImage extends StatefulWidget {
  final String imageSrc;
  final String defaultImage;
  final Color? imageColor;
  final double? height;
  final double? width;
  final ImageType imageType;
  final BoxFit fill;

  const CustomImage({
    required this.imageSrc,
    this.imageColor,
    this.height,
    this.width,
    this.imageType = ImageType.png,
    this.fill = BoxFit.fill,
    this.defaultImage = AppImages.defaultProfile,
    super.key,
  });

  @override
  State<CustomImage> createState() => _CustomImageState();
}

class _CustomImageState extends State<CustomImage> {
  RxBool notNetworkError = true.obs;

  late Widget imageWidget;

  @override
  Widget build(BuildContext context) {


    if (widget.imageType == ImageType.png) {
      imageWidget = Image.asset(
        widget.imageSrc,
        color: widget.imageColor,
        height: widget.height,
        width: widget.width,
        fit: widget.fill,
        errorBuilder: (context, error, stackTrace) =>
            Image.asset(widget.defaultImage),
      );
    }

    if (widget.imageType == ImageType.network) {
      imageWidget = Image.network(
        widget.imageSrc.isNotEmpty ? widget.imageSrc : 'https://www.google.com/url?sa=i&url=https%3A%2F%2Fstock.adobe.com%2Fsearch%2Fimages%3Fk%3Ddefault%2Bprofile%2Bpicture&psig=AOvVaw0RvPMEqlP7xmKJyCrICc0R&ust=1716405976712000&source=images&cd=vfe&opi=89978449&ved=0CBIQjRxqFwoTCMjX7te8n4YDFQAAAAAdAAAAABAE',
        color: widget.imageColor,
        height: widget.height,
        width: widget.width,
        fit: widget.fill,
        errorBuilder: (context, error, stackTrace) {
          if (kDebugMode) {
            print(error);
            print(widget.imageSrc);
          }

          return Image.asset(
            widget.defaultImage,
            color: widget.imageColor,
            height: widget.height,
            width: widget.width,
            fit: widget.fill,
          );
        },
        loadingBuilder: (BuildContext context, Widget child,
            ImageChunkEvent? loadingProgress) {
          if (loadingProgress == null) return child;
          return Center(
            child: CircularProgressIndicator(
              value: loadingProgress.expectedTotalBytes != null
                  ? loadingProgress.cumulativeBytesLoaded /
                      loadingProgress.expectedTotalBytes!
                  : null,
            ),
          );
        },
      );
    }

    if (widget.imageType == ImageType.decorationImage) {
      imageWidget = Obx(() => notNetworkError.value
          ? Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                    image: NetworkImage(widget.imageSrc),
                    onError: (exception, stackTrace) {
                      if (kDebugMode) {
                        print("before: ${notNetworkError.value}");
                      }

                      notNetworkError.value = false;
                      if (kDebugMode) {
                        print("before: ${notNetworkError.value}");
                        print(widget.imageSrc);
                      }

                      setState(() {});
                    },
                    fit: widget.fill,
                  )),
            )
          : Container(
              width: widget.width,
              height: widget.height,
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10.r),
                  image: DecorationImage(
                      fit: widget.fill,
                      image: AssetImage(widget.defaultImage))),
            ));
    }

    return SizedBox(
        height: widget.height, width: widget.width, child: imageWidget);
  }
}
