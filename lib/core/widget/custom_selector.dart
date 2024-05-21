import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../utils/styles.dart';


class CustomSelector extends ConsumerStatefulWidget {
  const CustomSelector(
      {required this.title,
      required this.colors,
      this.onPressed,
      this.icon,
      this.radius = 10,
      this.padding,
      this.isSelected = false,
      super.key});
  final String title;
  final Color colors;
  final VoidCallback? onPressed;
  final Widget? icon;
  final double radius;
  final EdgeInsets? padding;
  final bool isSelected;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _CustomSelectorState();
}

class _CustomSelectorState extends ConsumerState<CustomSelector> {
  bool onHover = false;
  @override
  Widget build(BuildContext context) {
    var styles = CustomStyles(context: context);
    return InkWell(
      onHover: (value) {
        setState(() {
          onHover = value;
        });
      },
      onTap: widget.onPressed,
      child: Container(
        padding: widget.padding,
        decoration: BoxDecoration(
          color: onHover && !widget.isSelected
              ? widget.colors.withOpacity(.6)
              : widget.isSelected
                  ? widget.colors
                  : Colors.transparent,
          borderRadius: BorderRadius.circular(widget.radius),
          border: Border.all(color: onHover ? Colors.white : widget.colors),
        ),
        child: Center(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.icon != null) widget.icon!,
              if (widget.icon != null && widget.title.isNotEmpty)
                const SizedBox(width: 10),
              Text(
                widget.title,
                style: styles.textStyle(
                    color: onHover
                        ? Colors.white
                        : !widget.isSelected
                            ? widget.colors
                            : Colors.white,
                    mobile: 15,
                    desktop: 15,
                    tablet: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
