part of 'widget.dart';

class WeekView extends StatelessWidget {
  WeekView({
    Key? key,
    required this.dates,
    required this.selectedDate,
    required this.lineHeight,
    this.highlightMonth,
    this.onChanged,
    this.events,
    this.barIndicator = false,
    this.indicatorColor = Colors.black,
  }) : super(key: key);

  final DateTime todayDate = DateTime.now().toZeroTime();
  final List<DateTime> dates;
  final double lineHeight;
  final int? highlightMonth;
  final DateTime selectedDate;
  final ValueChanged<DateTime>? onChanged;
  final List<DateTime>? events;
  final bool barIndicator;
  final Color indicatorColor;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: lineHeight,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: List<Widget>.generate(
              7,
              (dayIndex) {
                final date = dates[dayIndex];
                final isToday = date.isAtSameMomentAs(todayDate);
                final isSelected = date.isAtSameMomentAs(selectedDate);
                final isHighlight = highlightMonth == null
                    ? true
                    : date.month == highlightMonth;
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    DateBox(
                      onPressed:
                          onChanged != null ? () => onChanged!(date) : null,
                      borderRadius: BorderRadius.circular(100),
                      color: barIndicator
                          ? Colors.transparent
                          : isSelected
                              ? theme.accentColor
                              : Colors.transparent,
                      child: Text(
                        '${date.day}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          color: barIndicator
                              ? theme.primaryColor
                              : isSelected
                                  ? theme.colorScheme.onPrimary
                                  : theme.primaryColor,
                        ),
                      ),
                    ),
                    /*
                Column(
                  children: List<Widget>.generate(
                      events != null ? events!.length : 0,
                      (index) => events![index].isSameDate(date)
                          ? Container(
                              height: 6,
                              width: 6,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  color: Theme.of(context).primaryColor))
                          : const SizedBox()),
                )*/
                  ],
                );
              },
              growable: false,
            ),
          ),
          if (barIndicator)
            Padding(
              padding: EdgeInsets.symmetric(vertical: 2),
            ),
          if (barIndicator)
            Stack(
              children: [
                Container(
                  height: 3,
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: List<Widget>.generate(
                    7,
                    (dayIndex) {
                      final date = dates[dayIndex];
                      //final isToday = date.isAtSameMomentAs(todayDate);
                      final isSelected = date.isAtSameMomentAs(selectedDate);
                      return Container(
                        color: isSelected ? indicatorColor : Colors.transparent,
                        width: 30,
                        height: 3,
                      );
                    },
                    growable: false,
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}
