import 'package:flutter/material.dart';
import 'package:quick_flutter/model/ogp/ogp.dart';
import 'package:quick_flutter/widget/skeleton/skeleton_card.dart';
import 'package:quick_flutter/widget/skeleton/skeleton_text.dart';
import 'package:quick_flutter/widget/theme/app_theme.dart';

/// ogp の 画像の横幅
const double _ogpImageWidth = 120;

/// ogp の 画像の縦幅
const double _ogpImageHeight = 63;

/// URLプレビューのカード。
class UrlPreviewCard extends StatelessWidget {
  final Ogp ogp;

  /// タップ時の処理。
  final void Function()? onTap;

  const UrlPreviewCard({
    super.key,
    required this.ogp,
    this.onTap,
  });

  const factory UrlPreviewCard.loading() = _Skeleton;

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor:
          onTap != null ? SystemMouseCursors.click : SystemMouseCursors.basic,
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: EdgeInsets.all(context.appSpacing.small),
          decoration: BoxDecoration(
            border: Border.all(
              color: context.appColors.borderDefault,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(8.0),
          ),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      ogp.title,
                      style: context.appTextTheme.bodySmall,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: context.appSpacing.smallX),
                    Text(
                      ogp.description,
                      style: context.appTextTheme.bodySmall
                          .copyWith(color: context.appColors.textSubtle),
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ],
                ),
              ),
              SizedBox(width: context.appSpacing.medium),
              ClipRRect(
                borderRadius: BorderRadius.circular(8.0),
                child: Image.network(
                  ogp.imageUrl,
                  width: _ogpImageWidth,
                  height: _ogpImageHeight,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) =>
                      const SizedBox.shrink(),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _Skeleton extends UrlPreviewCard {
  const _Skeleton()
      : super(
          ogp: const Ogp(
            url: '',
            title: '',
            description: '',
            imageUrl: '',
          ),
        );

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.appSpacing.small),
      decoration: BoxDecoration(
        border: Border.all(
          color: context.appColors.borderDefault,
          width: 1.0,
        ),
        borderRadius: BorderRadius.circular(8.0),
      ),
      child: Row(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SkeletonText(width: 100, style: context.appTextTheme.bodySmall),
              SizedBox(height: context.appSpacing.smallX),
              SkeletonText(
                width: 200,
                style: context.appTextTheme.bodySmall,
                lineLength: 2,
              ),
            ],
          ),
          const Spacer(),
          const SkeletonCard(
            width: _ogpImageWidth,
            height: _ogpImageHeight,
          ),
        ],
      ),
    );
  }
}
