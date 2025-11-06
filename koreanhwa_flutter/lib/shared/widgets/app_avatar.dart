import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

class AppAvatar extends StatelessWidget {
  final String? imageUrl;
  final String? initials;
  final double size;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final Color? statusColor; // online/offline/away

  const AppAvatar({
    super.key,
    this.imageUrl,
    this.initials,
    this.size = 48,
    this.backgroundColor,
    this.foregroundColor,
    this.statusColor,
  });

  @override
  Widget build(BuildContext context) {
    final bg = backgroundColor ?? (Theme.of(context).brightness == Brightness.dark ? Colors.grey[800]! : Colors.grey[200]!);
    final fg = foregroundColor ?? (Theme.of(context).brightness == Brightness.dark ? Colors.white : Colors.black87);

    Widget child;
    if (imageUrl != null && imageUrl!.isNotEmpty) {
      child = ClipRRect(
        borderRadius: BorderRadius.circular(size),
        child: CachedNetworkImage(
          imageUrl: imageUrl!,
          width: size,
          height: size,
          fit: BoxFit.cover,
          placeholder: (c, _) => Container(width: size, height: size, color: bg),
          errorWidget: (c, _, __) => _initials(bg, fg),
        ),
      );
    } else {
      child = _initials(bg, fg);
    }

    return Stack(
      clipBehavior: Clip.none,
      children: [
        child,
        if (statusColor != null)
          Positioned(
            right: -1,
            bottom: -1,
            child: Container(
              width: size * .28,
              height: size * .28,
              decoration: BoxDecoration(
                color: Colors.white,
                shape: BoxShape.circle,
              ),
              alignment: Alignment.center,
              child: Container(
                width: size * .22,
                height: size * .22,
                decoration: BoxDecoration(color: statusColor, shape: BoxShape.circle),
              ),
            ),
          )
      ],
    );
  }

  Widget _initials(Color bg, Color fg) => Container(
        width: size,
        height: size,
        decoration: BoxDecoration(color: bg, shape: BoxShape.circle),
        alignment: Alignment.center,
        child: Text(
          (initials ?? '').toUpperCase(),
          style: TextStyle(fontWeight: FontWeight.w700, color: fg, fontSize: size * .38),
        ),
      );
}
