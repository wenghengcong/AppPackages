
# Souce
https://github.com/vinhnx/Clendar   SwiftUI 实现，有很多功能可以参考
 https://github.com/AllanJuenemann/CalendarView UICalendar包装
 https://github.com/leekurg/SimpleCalendar swifui实现，简单的视图
 https://github.com/ucargiray/Custom-Calendar swifui实现，太过简单
 https://github.com/airbnb/HorizonCalendar uikit实现，支持swiftui
 https://github.com/iletai/SwiftUICalendarView swifui实现
 
  https://github.com/Mijick/CalendarView  可能采用这个
 https://github.com/ThasianX/ElegantCalendar 也可能采用这个，效果比较好
 https://github.com/Rminsh/JalaliCalendar 完整的jalali日历app
 https://github.com/ZzzM/CalendarX  完整的mac app，可以借鉴的有很多
 
 https://github.com/shohe/InfiniteCalendar swifui实现，day/3day/week 支持显示日程
 
#CalendarView

 CalendarView makes UIKit's [UICalendarView](https://developer.apple.com/documentation/uikit/uicalendarview) with all its features available to SwiftUI.

 Please note that `UICalendarView` uses [DateComponents](https://developer.apple.com/documentation/foundation/datecomponents) rather than [Date](https://developer.apple.com/documentation/foundation/date). CalendarView uses the same convention for consistency but might add support for `Date` in the future.

 ## Usage

 ### Displaying the calendar

 ```swift
 import SwiftUI
 import CalendarView

 var body: some View {
   CalendarView()
 }
 ```

 ### Configuring the calendar

 CalendarView uses the [calendar](https://developer.apple.com/documentation/swiftui/environmentvalues/calendar), [time zone](https://developer.apple.com/documentation/swiftui/environmentvalues/timezone) and [locale](https://developer.apple.com/documentation/swiftui/environmentvalues/locale) from the environment.

 ```swift
 CalendarView()
   .environment(\.locale, .init(identifier: "de"))
 ```

 The [font design](https://developer.apple.com/documentation/uikit/uifontdescriptor/systemdesign) can be configured by using the `fontDesign` modifier.

 ```swift
 CalendarView()
   .fontDesign(.serif)
 ```

 You can also set the available date range.

 ```swift
 CalendarView(availableDateRange: thisYear)
 ```

 ### Updating visible components

 You can set and update the current components (year, month) that should be visible in the calendar.

 ```swift
 VStack {
   CalendarView(visibleDateComponents: $visibleComponents)
   
   Button("Today") {
     withAnimation {
       visibleComponents = calendar.dateComponents([.year, .month], from: .now)
     }
   }
 }
 ```

 ### Using decorations

 Use the `decorating` modifier to specify which dates should be decorated.

 ```swift
 CalendarView()
   .decorating(datesToDecorate)
 ```

 Decorations can also be customized.

 ```swift
 CalendarView()
   .decorating(datesToDecorate) { dateComponents in
     if dateComponents.day == specialDay {
       return .customView {
         Image(systemName: "star.fill")
           .foregroundColor(.yellow)
       }
     }

     return .default(color: .green, size: .small)
   }
 ```

 ### Handling selections

 CalendarView supports selections of single and multiple dates.

 ```swift
 CalendarView(selection: $selectedDates)
 ```

 You can also configure which dates are selectable and deselectable.

 ```swift
 CalendarView(selection: $selectedDates)
   .selectable { dateComponents in
     dateComponents.day > 15
   }
   .deselectable { dateComponents in
     dateComponents.year == currentYear && dateComponents.month == currentMonth
   }
 ```
