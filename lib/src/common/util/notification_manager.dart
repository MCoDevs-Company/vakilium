import 'package:flutter/material.dart';
import 'package:vakilium/src/common/extension/context_extension.dart';
import 'package:vakilium/src/common/util/dimension.dart';

enum NotificationVariant { error, success, info }

class NotificationManager {
  NotificationManager._();

  static OverlayEntry? _currentEntry;
  static AnimatedNotificationState? _currentNotificationState;

  static void show(BuildContext context, String message, NotificationVariant variant) {
    // Dismiss existing notification with animation if any
    if (_currentEntry != null) {
      if (_currentNotificationState != null) {
        _currentNotificationState!.dismiss();
      } else {
        _currentEntry!.remove();
      }
      _currentEntry = null;
      _currentNotificationState = null;
    }

    final overlay = Overlay.of(context);
    late OverlayEntry overlayEntry;
    late AnimatedNotificationState notificationState;

    overlayEntry = OverlayEntry(
      builder: (context) => AnimatedNotification(
        message: message,
        variant: variant,
        onDismiss: () {
          overlayEntry.remove();
          if (_currentEntry == overlayEntry) {
            _currentEntry = null;
            _currentNotificationState = null;
          }
        },
        onStateReady: (state) {
          notificationState = state;
        },
      ),
    );
    _currentEntry = overlayEntry;
    overlay.insert(overlayEntry);

    // Store the state reference after widget is built
    Future.delayed(const Duration(milliseconds: 50), () {
      if (_currentEntry == overlayEntry) {
        _currentNotificationState = notificationState;
      }
    });
  }
}

class AnimatedNotification extends StatefulWidget {
  const AnimatedNotification({
    required this.message,
    required this.variant,
    required this.onDismiss,
    required this.onStateReady,
  });

  final String message;
  final NotificationVariant variant;
  final VoidCallback onDismiss;
  final ValueChanged<AnimatedNotificationState> onStateReady;

  @override
  State<AnimatedNotification> createState() => AnimatedNotificationState();
}

class AnimatedNotificationState extends State<AnimatedNotification> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(duration: const Duration(milliseconds: 300), vsync: this);
    _animation = CurvedAnimation(parent: _controller, curve: Curves.easeOut, reverseCurve: Curves.easeIn);
    _controller.forward();

    // Notify parent that state is ready
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        widget.onStateReady(this);
      }
    });

    // Auto-dismiss after 4 seconds with animation
    Future.delayed(const Duration(seconds: 4), () {
      if (mounted) {
        _dismiss();
      }
    });
  }

  void dismiss() {
    _controller.reverse().then((_) {
      if (mounted) {
        widget.onDismiss();
      }
    });
  }

  void _dismiss() => dismiss();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Color _getBackgroundColor(BuildContext context) {
    switch (widget.variant) {
      case NotificationVariant.error:
        return context.color.error;
      case NotificationVariant.success:
        return context.color.success;
      case NotificationVariant.info:
        return context.color.primary;
    }
  }

  IconData _getIcon() {
    switch (widget.variant) {
      case NotificationVariant.error:
        return Icons.error_outline;
      case NotificationVariant.success:
        return Icons.check_circle_outline;
      case NotificationVariant.info:
        return Icons.info_outline;
    }
  }

  @override
  Widget build(BuildContext context) => SafeArea(
    child: Align(
      alignment: Alignment.topCenter,
      child: Padding(
        padding: Dimension.pH16Top16,
        child: Material(
          color: Colors.transparent,
          child: AnimatedBuilder(
            animation: _animation,
            builder: (context, child) => Transform.translate(
              offset: Offset(0, -50 * (1 - _animation.value)),
              child: Opacity(opacity: _animation.value, child: child),
            ),
            child: Container(
              decoration: BoxDecoration(color: _getBackgroundColor(context), borderRadius: BorderRadius.circular(12)),
              padding: Dimension.pV12H16,
              child: Row(
                children: [
                  Icon(_getIcon(), color: context.color.white, size: 20),
                  const SizedBox(width: 12),
                  Expanded(
                    child: Text(
                      widget.message,
                      style: context.textTheme.interW400s14.copyWith(color: context.color.white),
                    ),
                  ),
                  const SizedBox(width: 8),
                  GestureDetector(
                    onTap: _dismiss,
                    child: Icon(Icons.close, color: context.color.white, size: 20),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    ),
  );
}

