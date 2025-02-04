import 'package:flutter/material.dart';

enum AnchorPosition {
  start(0),
  center(0.5),
  end(1);

  const AnchorPosition(this.value);
  final double value;
}

class BidirectionalListView extends StatelessWidget {
  BidirectionalListView({
    super.key,
    this.axis = Axis.vertical,
    this.anchorPosition = AnchorPosition.center,
    required this.forwardChildrenDelegate,
    this.reverseChildrenDelegate,
    this.center,
  }) : separatorBuilder = null;

  BidirectionalListView.builder({
    super.key,
    this.axis = Axis.vertical,
    this.anchorPosition = AnchorPosition.center,
    int? forwardChildCount,
    required IndexedWidgetBuilder forwardListBuilder,
    int? reverseChildCount,
    IndexedWidgetBuilder? reverseListBuilder,
    this.center,
  })  : forwardChildrenDelegate = SliverChildBuilderDelegate(
          forwardListBuilder,
          childCount: forwardChildCount,
        ),
        reverseChildrenDelegate = reverseListBuilder != null
            ? SliverChildBuilderDelegate(
                reverseListBuilder,
                childCount: reverseChildCount,
              )
            : null,
        separatorBuilder = null;

  BidirectionalListView.separated({
    super.key,
    this.axis = Axis.vertical,
    this.anchorPosition = AnchorPosition.center,
    int? forwardChildCount,
    required IndexedWidgetBuilder forwardListBuilder,
    int? reverseChildCount,
    IndexedWidgetBuilder? reverseListBuilder,
    required IndexedWidgetBuilder this.separatorBuilder,
    this.center,
  })  : forwardChildrenDelegate = SliverChildBuilderDelegate(
          (context, index) {
            final int itemIndex = index ~/ 2;
            if (index.isEven) {
              return forwardListBuilder(context, itemIndex);
            }
            return separatorBuilder(context, itemIndex);
          },
          childCount:
          forwardChildCount != null
              ? (forwardChildCount * 2 - 1)
              : null,
        ),
        reverseChildrenDelegate = reverseListBuilder != null
            ? SliverChildBuilderDelegate(
                (context, index) {
                  final int itemIndex = index ~/ 2;
                  if (index.isEven) {
                    return reverseListBuilder(context, itemIndex);
                  }
                  return separatorBuilder(context, itemIndex);
                },
                childCount: reverseChildCount != null
                    ? (reverseChildCount * 2 - 1)
                    : null,
              )
            : null;

  final Axis axis;
  final AnchorPosition anchorPosition;
  final SliverChildDelegate forwardChildrenDelegate;
  final SliverChildDelegate? reverseChildrenDelegate;
  final IndexedWidgetBuilder? separatorBuilder;
  final Widget? center;
  final UniqueKey _centerKey = UniqueKey();

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      scrollDirection: axis,
      anchor: anchorPosition.value,
      center: _centerKey,
      slivers: <Widget>[
        if (reverseChildrenDelegate != null)
          _buildReverseList(),
        if (separatorBuilder != null)
          SliverToBoxAdapter(child: separatorBuilder!.call(context, 0)),
        if (center != null)
          KeyedSubtree(
            key: _centerKey,
            child: SliverToBoxAdapter(child: center),
          ),
        _buildForwardList(
          key: center == null ? _centerKey : null,
        ),
      ],
    );
  }

  Widget _buildReverseList() {
    return SliverList(
      delegate: reverseChildrenDelegate!,
    );
  }

  Widget _buildForwardList({Key? key}) {
    return SliverList(
      key: key,
      delegate: forwardChildrenDelegate,
    );
  }
}
