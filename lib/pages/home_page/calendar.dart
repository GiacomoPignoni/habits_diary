import 'package:flutter/material.dart';
import 'package:project_habits/pages/home_page/home_page_controller.dart';
import 'package:provider/provider.dart';

class Calendar extends StatelessWidget {
  static const double cellSpacing = 10;
  static const double padding = 20;

  @override
  Widget build(BuildContext context) {
    final controller = Provider.of<HomePageController>(context);
    final cellDimension = (MediaQuery.of(context).size.width - (cellSpacing * 6) - (padding * 2)) / 7;

    return StreamBuilder<DateTime>(
      stream: controller.selectedMonth.stream,
      initialData: controller.selectedMonth.value,
      builder: (context, snapshot) {
        final initialWhites = snapshot.data!.weekday - 1;
        final daysNumber = DateUtils.getDaysInMonth(snapshot.data!.year, snapshot.data!.month);
  
        return Stack(
          children: [
            GestureDetector(
              onHorizontalDragEnd: controller.onSwipeCalendar,
              child: GridView.count(
                crossAxisCount: 7,
                mainAxisSpacing: cellSpacing,
                crossAxisSpacing: cellSpacing,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: const EdgeInsets.all(padding),
                children: List.generate(daysNumber + initialWhites, (index) {
                  if(index < initialWhites) {
                    return SizedBox.shrink();
                  }

                  return GestureDetector(
                    onTap: () => controller.selectNewDay(index - initialWhites),
                    child: AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      decoration: BoxDecoration(
                        color: Color.lerp(
                          Theme.of(context).shadowColor,
                          Theme.of(context).primaryColor,
                          controller.countHabitsDone(index - initialWhites) / controller.countAllHabits(index - initialWhites)
                        ),
                        borderRadius: BorderRadius.circular(10)
                      )
                    ),
                  );
                }),
              ),
            ),
            StreamBuilder<int>(
              stream: controller.selectedDayindex.stream,
              initialData: controller.selectedDayindex.value,
              builder: (context, snapshot) {
                final selectedDayIndex = snapshot.data!;

                return AnimatedPositioned(
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeOutQuad,
                  left: padding + (cellDimension + cellSpacing) * ((selectedDayIndex + initialWhites) % 7),
                  top: padding + (cellDimension + cellSpacing) * ((selectedDayIndex + initialWhites) / 7).floor(),
                  child: SizedBox(
                    width: cellDimension,
                    height: cellDimension,
                    child: CustomPaint(
                      painter: SelectionPainer(color: Theme.of(context).accentColor),
                    )
                  ),
                );
              }
            )
          ],
        );
      }
    );
  }
}

class SelectionPainer extends CustomPainter {
  static const double CURVE = 10;
  static const double LENGTH = 10;
  static const double OFFSET = 3;

  late final basePaint;

  SelectionPainer({
    required Color color
  }) {
    basePaint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4;
  }

  @override
  void paint(Canvas canvas, Size size) {
    final path = Path();

    //TOP LEFT
    path.moveTo(-OFFSET, LENGTH);
    path.lineTo(-OFFSET, CURVE);
    path.quadraticBezierTo(-OFFSET, -OFFSET, CURVE, -OFFSET);
    path.lineTo(LENGTH, -OFFSET);

    //TOP RIGHT
    path.moveTo(size.width + OFFSET, LENGTH);
    path.lineTo(size.width  + OFFSET, CURVE);
    path.quadraticBezierTo(size.width + OFFSET, -OFFSET, size.width - CURVE, -OFFSET);
    path.lineTo(size.width - LENGTH, -OFFSET);

    //BOTTOM LEFT
    path.moveTo(-OFFSET, size.height - LENGTH);
    path.lineTo(-OFFSET, size.height - CURVE);
    path.quadraticBezierTo(-OFFSET, size.height + OFFSET, CURVE, size.height + OFFSET);
    path.lineTo(LENGTH, size.height + OFFSET);

    //BOTTOM RIGHT
    path.moveTo(size.width + OFFSET, size.height - LENGTH);
    path.lineTo(size.width + OFFSET, size.height - CURVE);
    path.quadraticBezierTo(size.width + OFFSET, size.height + OFFSET, size.width - CURVE, size.height + OFFSET);
    path.lineTo(size.width - LENGTH, size.height + OFFSET);
  
    canvas.drawPath(path, basePaint);
  }
  
  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}