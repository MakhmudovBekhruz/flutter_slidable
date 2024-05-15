import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/widgets.dart';

import 'controller.dart';

// INTERNAL USE
// ignore_for_file: public_member_api_docs

class SlidableGestureDetector extends StatefulWidget {
  const SlidableGestureDetector(
      {Key? key,
      this.enabled = true,
      this.closeOnScroll = true,
      required this.controller,
      required this.direction,
      required this.child,
      this.dragStartBehavior = DragStartBehavior.start,
      this.endGestureWidth = 10,
      this.endGestureHeight = 50,
      this.endPadding = 150,
      this.startPadding = 150,
      this.onDragStart})
      : super(key: key);
  final bool closeOnScroll;
  final SlidableController controller;
  final Widget child;
  final Axis direction;
  final bool enabled;
  final VoidCallback? onDragStart;
  final double endGestureWidth;
  final double endGestureHeight;
  final double? endPadding;
  final double? startPadding;

  /// Determines the way that drag start behavior is handled.
  ///
  /// If set to [DragStartBehavior.start], the drag gesture used to dismiss a
  /// dismissible will begin upon the detection of a drag gesture. If set to
  /// [DragStartBehavior.down] it will begin when a down event is first detected.
  ///
  /// In general, setting this to [DragStartBehavior.start] will make drag
  /// animation smoother and setting it to [DragStartBehavior.down] will make
  /// drag behavior feel slightly more reactive.
  ///
  /// By default, the drag start behavior is [DragStartBehavior.start].
  ///
  /// See also:
  ///
  ///  * [DragGestureRecognizer.dragStartBehavior], which gives an example for the different behaviors.
  final DragStartBehavior dragStartBehavior;

  @override
  _SlidableGestureDetectorState createState() =>
      _SlidableGestureDetectorState();
}

class _SlidableGestureDetectorState extends State<SlidableGestureDetector> {
  double dragExtent = 0;
  Offset? startPosition;
  Offset? lastPosition;

  bool get directionIsXAxis {
    return widget.direction == Axis.horizontal;
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final canDragHorizontally = directionIsXAxis && widget.enabled;
    final canDragVertically = !directionIsXAxis && widget.enabled;
    return Stack(
      children: [
        widget.child,
        Positioned(
          right:
              widget.controller.direction.value == -1 ? widget.endPadding : 0,
          top: 0,
          child: GestureDetector(
            onHorizontalDragStart: canDragHorizontally ? handleDragStart : null,
            onHorizontalDragUpdate:
                canDragHorizontally ? handleDragUpdate : null,
            onHorizontalDragEnd: canDragHorizontally ? handleDragEnd : null,
            onVerticalDragStart: canDragVertically ? handleDragStart : null,
            onVerticalDragUpdate: canDragVertically ? handleDragUpdate : null,
            onVerticalDragEnd: canDragVertically ? handleDragEnd : null,
            behavior: HitTestBehavior.opaque,
            dragStartBehavior: widget.dragStartBehavior,
            child: SizedBox(
              width: widget.controller.direction.value == -1
                  ? MediaQuery.sizeOf(context).width - 150
                  : widget.endGestureWidth,
              height: widget.endGestureHeight,
            ),
          ),
        ),
        Positioned(
          left:
              widget.controller.direction.value == 1 ? widget.startPadding : 0,
          top: 0,
          child: GestureDetector(
            onHorizontalDragStart: canDragHorizontally ? handleDragStart : null,
            onHorizontalDragUpdate:
                canDragHorizontally ? handleDragUpdate : null,
            onHorizontalDragEnd: canDragHorizontally ? handleDragEnd : null,
            onVerticalDragStart: canDragVertically ? handleDragStart : null,
            onVerticalDragUpdate: canDragVertically ? handleDragUpdate : null,
            onVerticalDragEnd: canDragVertically ? handleDragEnd : null,
            behavior: HitTestBehavior.opaque,
            dragStartBehavior: widget.dragStartBehavior,
            child: SizedBox(
              width: widget.controller.direction.value == 1
                  ? MediaQuery.sizeOf(context).width - 150
                  : widget.endGestureWidth,
              height: widget.endGestureHeight,
            ),
          ),
        ),
      ],
    );
  }

  double get overallDragAxisExtent {
    final Size? size = context.size;
    return directionIsXAxis ? size!.width : size!.height;
  }

  void handleDragStart(DragStartDetails details) {
    if (widget.onDragStart != null) {
      widget.onDragStart!();
    }
    startPosition = details.localPosition;
    lastPosition = startPosition;
    dragExtent = dragExtent.sign *
        overallDragAxisExtent *
        widget.controller.ratio *
        widget.controller.direction.value;
  }

  void handleDragUpdate(DragUpdateDetails details) {
    // print(details.primaryDelta);
    final delta = details.primaryDelta!;
    dragExtent += delta;
    lastPosition = details.localPosition;
    widget.controller.ratio = dragExtent / overallDragAxisExtent;
  }

  void handleDragEnd(DragEndDetails details) {
    // print('handleDragEnd');

    widget.controller.dispatchEndGesture(
      details.primaryVelocity,
      getDirection(),
    );
  }

  GestureDirection getDirection() {
    if (lastPosition == null || startPosition == null) {
      return GestureDirection.opening;
    }
    final delta = lastPosition! - startPosition!;

    final primaryDelta = directionIsXAxis ? delta.dx : delta.dy;
    // print(primaryDelta);
    final gestureDirection =
        primaryDelta >= 0 ? GestureDirection.opening : GestureDirection.closing;

    return gestureDirection;
  }
}
