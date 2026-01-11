//
//  AppSegue.swift
//  Rental
//
//  Created by Куат Оралбеков on 11.01.2026.
//

enum AppSegue: Hashable, SegueType, Identifiable {
    case home
    case details(id: String)
    
    case sheetSettings
    case dismissSheet
    
    case pop
    case popToRoot
    
    var id: String {
        switch self {
        case .home: return "home"
        case .details(let id): return "details:\(id)"
        case .sheetSettings: return "sheetSettings"
        case .dismissSheet: return "dismissSheet"
        case .pop: return "pop"
        case .popToRoot: return "popToRoot"
        }
    }
}
