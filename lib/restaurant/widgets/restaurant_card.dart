import 'package:flutter/cupertino.dart';
import 'package:indulge/lists/viewmodels/list_view_model.dart';
import 'package:indulge/lists/viewmodels/lists_view_model.dart';
import 'package:indulge/restaurant/models/restaurant.dart';
import 'package:indulge/restaurant/viewmodels/restaurant_view_model.dart';
import 'package:provider/provider.dart';

class SwipeableRestaurantCard extends StatefulWidget {
  final Restaurant restaurant;
  final VoidCallback onSwipeLeft;
  final VoidCallback onSwipeRight;
  final VoidCallback onSkip;

  const SwipeableRestaurantCard({
    Key? key,
    required this.restaurant,
    required this.onSwipeLeft,
    required this.onSwipeRight,
    required this.onSkip,
  }) : super(key: key);

  @override
  _SwipeableRestaurantCardState createState() => _SwipeableRestaurantCardState();
}

class _SwipeableRestaurantCardState extends State<SwipeableRestaurantCard> {
  double _dx = 0; // Horizontal offset
  double _dy = 0; // Vertical offset
  double _rotation = 0; // Rotation angle
  bool _isAnimating = false; // Prevent multiple animations

  static const double swipeThreshold = 100;

  void _onDragUpdate(DragUpdateDetails details) {
    if (_isAnimating) return;

    setState(() {
      _dx += details.delta.dx;
      _dy += details.delta.dy;
      _rotation = _dx / 200; // Adjust rotation scale
    });
  }

  void _onDragEnd(DragEndDetails details) {
    if (_isAnimating) return;

    if (_dx > swipeThreshold) {
      // Swiped Right
      _triggerSwipeRight();
    } else if (_dx < -swipeThreshold) {
      // Swiped Left
      _triggerSwipeLeft();
    } else {
      // Snap back to center
      _resetPosition();
    }
  }

  void _triggerSwipeLeft() {
    _animateOffScreen(false, widget.onSwipeLeft);
    final int restaurantId = widget.restaurant.id!;
    Provider.of<RestaurantViewModel>(context, listen: false).setRestuarantViewedById(restaurantId, 1);
  }

  void _triggerSwipeRight() {
    _animateOffScreen(true, widget.onSwipeRight);

    final int restaurantId = widget.restaurant.id!;
    final restaurantVM = Provider.of<RestaurantViewModel>(context, listen: false);
    restaurantVM.setRestuarantViewedById(restaurantId, 1);
    addToTypeListTemp();
  }

  Future<void> addToTypeListTemp() async {
    final listVM = Provider.of<ListViewModel>(context, listen: false);
    await listVM.getListByName(widget.restaurant.type);

    final allListsVM = Provider.of<ListsViewModel>(context, listen: false);
    allListsVM.addRestaurantToList(listVM.id!, widget.restaurant.id!);
    allListsVM.fetchLists();
  }

  void _triggerIndulged() {
    _animateDownward(widget.onSkip);
    final int restaurantId = widget.restaurant.id!;
    final restaurantVM = Provider.of<RestaurantViewModel>(context, listen: false);
    final allListsVM = Provider.of<ListsViewModel>(context, listen: false);
    allListsVM.addRestaurantToList(1, restaurantId);
    restaurantVM.setRestuarantIndulgedById(restaurantId, 1);
    addToTypeListTemp();
  }

  void _animateOffScreen(bool toRight, VoidCallback onComplete) {
    setState(() {
      _isAnimating = true;
      _dx = toRight ? 500 : -500; // Move off-screen
      _dy = 0;
      _rotation = toRight ? 0.2 : -0.2; // Slight rotation
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      onComplete();
      setState(() {
        _resetPosition();
        _isAnimating = false;
      });
    });
  }

  void _animateDownward(VoidCallback onComplete) {
    setState(() {
      _isAnimating = true;
      _dx = 0;
      _dy = 500; // Move downward
      _rotation = 0;
    });

    Future.delayed(const Duration(milliseconds: 300), () {
      onComplete();
      setState(() {
        _resetPosition();
        _isAnimating = false;
      });
    });
  }

  void _resetPosition() {
    setState(() {
      _dx = 0;
      _dy = 0;
      _rotation = 0;
    });
  }

  double _calculateOpacity() {
    return (_dx.abs() / swipeThreshold).clamp(0.0, 1.0);
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      transform: Matrix4.identity()
        ..translate(_dx, _dy)
        ..rotateZ(_rotation),
      child: GestureDetector(
        onPanUpdate: _onDragUpdate,
        onPanEnd: _onDragEnd,
        child: Stack(
          children: [
            // Background color overlay for swipes
            Positioned.fill(
              child: Stack(
                children: [
                  // Red hue on the left
                  if (_dx < 0)
                    Positioned.fill(
                      child: Opacity(
                        opacity: _calculateOpacity(),
                        child: Container(
                          color: CupertinoColors.destructiveRed.withOpacity(0.3),
                        ),
                      ),
                    ),
                  // Green hue on the right
                  if (_dx > 0)
                    Positioned.fill(
                      child: Opacity(
                        opacity: _calculateOpacity(),
                        child: Container(
                          color: CupertinoColors.activeGreen.withOpacity(0.3),
                        ),
                      ),
                    ),
                ],
              ),
            ),

            // The card itself
            Container(
              margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: CupertinoColors.systemGrey.withOpacity(0.4),
                    blurRadius: 10,
                    offset: Offset(0, 4),
                  ),
                ],
              ),
              child: Stack(
                children: [
                  // Background image
                  Positioned.fill(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(16),
                      child: Image.network(
                        widget.restaurant.imageUrl,
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),

                  // Top overlay with restaurant details
                  Positioned(
                    top: 16,
                    left: 16,
                    right: 16,
                    child: Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: CupertinoColors.black.withOpacity(0.6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            widget.restaurant.name,
                            style: const TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "${widget.restaurant.globalRating} ★ | ${widget.restaurant.distance}",
                            style: const TextStyle(
                              color: CupertinoColors.white,
                              fontSize: 16,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                            decoration: BoxDecoration(
                              color: CupertinoColors.systemGrey2.withOpacity(0.8),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: Text(
                              widget.restaurant.type,
                              style: const TextStyle(
                                color: CupertinoColors.white,
                                fontSize: 14,
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Bottom buttons (Dislike, Indulged, Like)
                  Positioned(
                    bottom: 16,
                    left: 16,
                    right: 16,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        // Dislike Button
                        CupertinoButton(
                          padding: const EdgeInsets.all(16),
                          borderRadius: BorderRadius.circular(30),
                          color: CupertinoColors.destructiveRed,
                          child: const Icon(CupertinoIcons.xmark, color: CupertinoColors.white, size: 24),
                          onPressed: _triggerSwipeLeft,
                        ),
                        // Indulged Button
                        GestureDetector(
                          onTap: _triggerIndulged,
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                            decoration: BoxDecoration(
                              color: CupertinoColors.black.withOpacity(0.6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Text(
                              "Indulged",
                              style: TextStyle(
                                color: CupertinoColors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                        // Like Button
                        CupertinoButton(
                          padding: const EdgeInsets.all(16),
                          borderRadius: BorderRadius.circular(30),
                          color: CupertinoColors.activeGreen,
                          child: const Icon(CupertinoIcons.checkmark, color: CupertinoColors.white, size: 24),
                          onPressed: _triggerSwipeRight,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
