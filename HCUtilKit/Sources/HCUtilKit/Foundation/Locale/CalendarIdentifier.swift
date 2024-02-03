//
//  CalendarIdentifier.swift
//
//
//  Created by Nemo on 2023/10/27.
//

import Foundation

public enum CalendarIdentifier: Int, CaseIterable {
    case gregorian = 0
    case buddhist
    case chinese
    case coptic
    case ethiopicAmeteMihret
    case ethiopicAmeteAlem
    case hebrew
    case iso8601
    case indian
    case islamic
    case islamicCivil
    case japanese
    case persian
    case republicOfChina
    case islamicTabular
    case islamicUmmAlQura
    
    public static var current: Self {
        // prioritize selected calendar identifier
        if let selectedCalendarIdentifier = CalendarIdentifier(rawValue: UserPreferences.shared.selectedCalendarIdentifier) {
            return selectedCalendarIdentifier
        }
        
        // if non founded, map from system's Calendar identifier
        // otherwise, return Gregorian calendar
        return defaultCalendarIdentifier
    }
    
    public static var defaultCalendarIdentifier: CalendarIdentifier {
        let currentSystemIdentifier = Calendar.autoupdatingCurrent.identifier
        let mapIdentifiers = CalendarIdentifier.allCases.map(\.identifier)
        if let matched = mapIdentifiers.first(where: { $0 == currentSystemIdentifier }) {
            return CalendarIdentifier.mapFromNativeCalendarIdentifier(matched)
        }
        return .gregorian
    }
    
    // swiftlint:disable:next cyclomatic_complexity
    static func mapFromNativeCalendarIdentifier(_ identifier: Calendar.Identifier) -> CalendarIdentifier {
        switch identifier {
        case .gregorian: return .gregorian
        case .buddhist: return .buddhist
        case .chinese: return .chinese
        case .coptic: return .coptic
        case .ethiopicAmeteMihret: return .ethiopicAmeteMihret
        case .ethiopicAmeteAlem: return .ethiopicAmeteAlem
        case .hebrew: return .hebrew
        case .iso8601: return .iso8601
        case .indian: return .indian
        case .islamic: return .islamic
        case .islamicCivil: return .islamicCivil
        case .japanese: return .japanese
        case .persian: return .persian
        case .republicOfChina: return .republicOfChina
        case .islamicTabular: return .islamicTabular
        case .islamicUmmAlQura: return .islamicUmmAlQura
        @unknown default: return .gregorian
        }
    }
    
    public var calendar: Calendar {
        var instance = Calendar(identifier: identifier)
        instance.locale = Locale.autoupdatingCurrent // IMPORTANT
        
        let userSetFirstWeekDay = "\(UserPreferences.shared.firstWeekDay)"
        if let firstWeekDayIndex = instance.weekdaySymbols.firstIndex(of: userSetFirstWeekDay),
           firstWeekDayIndex != NSNotFound {
            // IMPORTANT: The weekday units are one-based. For Gregorian and ISO 8601 calendars, 1 is Sunday.
            instance.firstWeekday = firstWeekDayIndex + 1
        }
        
        return instance
    }
    
    public var identifier: Calendar.Identifier {
        switch self {
        case .gregorian: return .gregorian
        case .buddhist: return .buddhist
        case .chinese: return .chinese
        case .coptic: return .coptic
        case .ethiopicAmeteMihret: return .ethiopicAmeteMihret
        case .ethiopicAmeteAlem: return .ethiopicAmeteAlem
        case .hebrew: return .hebrew
        case .iso8601: return .iso8601
        case .indian: return .indian
        case .islamic: return .islamic
        case .islamicCivil: return .islamicCivil
        case .japanese: return .japanese
        case .persian: return .persian
        case .republicOfChina: return .republicOfChina
        case .islamicTabular: return .islamicTabular
        case .islamicUmmAlQura: return .islamicUmmAlQura
        }
    }
    
    public var shortDescription: String {
        switch self {
        case .gregorian: return "Gregorian"
        case .buddhist: return "Buddhist"
        case .chinese: return "Lunar calendar (Chinese calendar)"
        case .coptic: return "Coptic"
        case .ethiopicAmeteMihret: return "Ethiopic (Amete Mihret)"
        case .ethiopicAmeteAlem: return "Ethiopic (Amete Alem)"
        case .hebrew: return "Hebrew"
        case .iso8601: return "ISO8601"
        case .indian: return "Indian"
        case .islamic: return "Islamic"
        case .islamicCivil: return "Islamic civil"
        case .japanese: return "Japanese"
        case .persian: return "Persian"
        case .republicOfChina: return "Republic of China"
        case .islamicTabular: return "tabular Islamic"
        case .islamicUmmAlQura: return "Islamic Umm al-Qura"
        }
    }
}
