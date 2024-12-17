import 'package:flutter/material.dart';


class AnimatedReorderableList extends StatefulWidget {
  @override
  _AnimatedReorderableListState createState() =>
      _AnimatedReorderableListState();
}

class _AnimatedReorderableListState extends State<AnimatedReorderableList> {
  final List<IconData> _items = [
    Icons.person,
    Icons.message,
    Icons.call,
    Icons.camera,
    Icons.photo,
  ];

  int? hoverIndex;
  int? draggingIndex;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(40.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: List.generate(_items.length, (index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8.0),
                child: DragTarget<int>(
                  onAcceptWithDetails: (draggedIndex) {
                    setState(() {
                      final item = _items.removeAt(draggedIndex.data);
                      _items.insert(index, item);
                      draggingIndex = null;
                    });
                  },
                  onWillAcceptWithDetails: (draggedIndex) {
                    setState(() => draggingIndex = index);
                    return true;
                  },
                  builder: (context, candidateData, rejectedData) {
                    final isHovering = hoverIndex == index;
                    final isDragging = draggingIndex == index;

                    return MouseRegion(
                      onEnter: (_) => setState(() => hoverIndex = index),
                      onExit: (_) => setState(() => hoverIndex = null),
                      child: Draggable<int>(
                        data: index,
                        feedback: Material(
                          elevation: 5,
                          child:
                              _buildListItem(index, 1.4, Colors.grey.shade300),
                        ),
                        childWhenDragging: const SizedBox.shrink(),
                        onDragEnd: (_) => setState(() => draggingIndex = null),
                        child: AnimatedContainer(
                          duration: const Duration(milliseconds: 400),
                          curve: Curves.easeInOut,
                          height: 60,
                          padding:
                              EdgeInsets.fromLTRB(isDragging ? 80 : 0, 0, 0, 0),
                          margin: EdgeInsets.symmetric(
                              vertical: isDragging ? 10 : 5),
                          child: _buildListItem(
                            index,
                            isHovering
                                ? 1.2
                                : (hoverIndex == index - 1 || hoverIndex == index + 1)
                                    ? 1.05
                                    : 1.0,
                            Colors.white,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              );
            }),
          ),
        ),
      ),
    );
  }

  Widget _buildListItem(int index, double scale, Color backgroundColor) {
    return Transform.scale(

      scale: scale,
      child: Container(
        width: 60,
        height: 60,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: BorderRadius.circular(16),
          border: Border.all(color: Colors.grey),
        ),
        child: Center(
          child: Icon(
            _items[index],
            size: 30,
            color: Colors.blueAccent,
          ),
        ),
      ),
    );
  }
}
