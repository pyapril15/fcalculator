import 'package:flutter/material.dart';

class AnimatedPressButton extends StatefulWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? color;
  final double elevation;
  final BorderRadius borderRadius;
  final double? width;
  final double? height;
  final bool enableRipple;
  final String? semanticsLabel;

  const AnimatedPressButton({
    super.key,
    required this.child,
    required this.onPressed,
    this.color,
    this.elevation = 2.0,
    this.borderRadius = const BorderRadius.all(Radius.circular(24)),
    this.width,
    this.height,
    this.enableRipple = true,
    this.semanticsLabel,
  });

  @override
  State<AnimatedPressButton> createState() => _AnimatedPressButtonState();
}

class _AnimatedPressButtonState extends State<AnimatedPressButton>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _scaleAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 150),
      vsync: this,
    );
    _scaleAnimation = Tween<double>(
      begin: 1.0,
      end: 0.95,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleTapDown(_) {
    if (widget.onPressed != null) {
      _controller.forward();
    }
  }

  void _handleTapUp(_) {
    if (widget.onPressed != null) {
      _controller.reverse();
      widget.onPressed!();
    }
  }

  void _handleTapCancel() {
    if (widget.onPressed != null) {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final buttonColor = widget.color ?? Theme.of(context).colorScheme.surface;

    return GestureDetector(
      onTapDown: _handleTapDown,
      onTapUp: _handleTapUp,
      onTapCancel: _handleTapCancel,
      behavior: HitTestBehavior.translucent,
      child: AnimatedBuilder(
        animation: _scaleAnimation,
        builder: (context, child) {
          return Transform.scale(
            scale: _scaleAnimation.value,
            child: Material(
              color: buttonColor,
              elevation: widget.elevation,
              borderRadius: widget.borderRadius,
              child: Container(
                width: widget.width,
                height: widget.height,
                constraints: const BoxConstraints(minWidth: 44, minHeight: 44),
                decoration: BoxDecoration(borderRadius: widget.borderRadius),
                child:
                    widget.enableRipple && widget.onPressed != null
                        ? InkWell(
                          borderRadius: widget.borderRadius,
                          onTap: widget.onPressed,
                          child: Center(child: widget.child),
                        )
                        : Center(child: widget.child),
              ),
            ),
          );
        },
      ),
    );
  }
}
