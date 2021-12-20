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
    this.eventColor = Colors.black,
    this.weekNames,
    this.showWeekNameOnWeek = false,
  }) : super(key: key);

  final DateTime todayDate = DateTime.now().toZeroTime();
  final List<DateTime> dates;
  final double lineHeight;
  final int? highlightMonth;
  final DateTime selectedDate;
  final ValueChanged<DateTime>? onChanged;
  //final List<DateTime>? events;
  final Map<int, int>? events;
  final bool barIndicator;
  final Color indicatorColor;
  final Color eventColor;
  List<String>? weekNames;
  final bool showWeekNameOnWeek;

  int _getEventCount(DateTime date) {
    if (events != null) {
      return events![date.millisecondsSinceEpoch] ?? 0;
    } else {
      return 0;
    }
  }

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
                int eventCount = _getEventCount(date);
                return Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Container(
                      height: 10,
                      width: 10,
                      alignment: Alignment.center,
                      decoration: (eventCount > 0)
                          ? (BoxDecoration(
                              borderRadius: BorderRadius.circular(50),
                              color: eventColor))
                          : null,
                      child: (eventCount > 0)
                          ? Text(
                              eventCount.toString(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.bold,
                              ),
                            )
                          : null,
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 3),
                    ),
                    if (showWeekNameOnWeek &&
                        (weekNames != null) &&
                        (weekNames!.length == 7))
                      Text(
                        weekNames![dayIndex],
                        style: theme.textTheme.bodyText1!.copyWith(
                          color: theme.hintColor,
                          fontSize: 12,
                        ),
                      ),
                    DateBox(
                      onPressed: () {
                        if (onChanged != null) {
                          onChanged!(date);
                        }
                      },
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
