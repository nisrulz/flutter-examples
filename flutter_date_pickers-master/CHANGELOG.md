## [0.0.6] - 21 November 2019
Added support for custom day decoration.
Added support for custom disabled days.

## [0.1.0] - 31 May 2020
Fixed i18n issue for MonthPicker in case no locale was set.
Fixed selection periods with unselectable dates issue in RangePicker.
Minor changes and fixes.

## [0.1.1] - 20 June 2020
Added scrollPhysics property to DatePickerLayoutSettings.

## [0.1.3] - 23 June 2020
Added day headers style customization.
Added prev/next icon customization.
Added selected period text styles customization.

## [0.1.4] - 2 July 2020
Added firstDayOfWeekIndex customization.

## [0.1.5] - 29 July 2020
Added support of the CupertinoApp ancestor (fixed #29).

## [0.1.6] - 21 August 2020
Added two customizable fields to DatePickerLayoutSettings: showNextMonthStart, showPrevMonthEnd (implemented #28).

## [0.1.7] - 25 August 2020
Added onMonthChange callback for all day based pickers.
Added newPeriod field to UnselectablePeriodError class.

## [0.1.8] - 26 October 2020
Fixed selection in RangePicker which is on the edge of date when time changes (#44).

## [0.1.9] - 23 December 2020
Increased intl dependency version.
Minor changes.

## [0.1.10] - 23 December 2020
Increased intl dependency version according to one used on pub.dev.

## [0.2.0] - 7 March 2021
Migrated to null-safety.
Added DatePickerLayoutSettings.hideMonthNavigationRow option.

## [0.2.1] - 16 March 2021
Used intl for getting short month name for MonthPicker (fixed #54)

## [0.2.2] - 20 March 2021
Added **initiallyShowDate** optional property for DayPicker, WeekPicker and RangePicker.

## [0.2.3] - 05 April 2021
Fixed nextTooltip initializing (#57).

## [0.2.3+1] - 11 April 2021
Fixed defining DayHeaderStyle in DatePickerStyles.fulfillWithTheme.

## [0.2.4] - 29 April 2021
Fixed incorrect new month calculations (#56).