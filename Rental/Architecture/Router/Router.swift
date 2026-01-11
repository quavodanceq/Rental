//
//  Router.swift
//  Rental
//
//  Created by Куат Оралбеков on 11.01.2026.
//

import SwiftUI
import Combine

@MainActor
final class Router: ObservableObject {
    
    @Published var path: [AppSegue] = []
    
    @Published var sheet: AppSegue? = nil
    
    func handle(_ segue: AppSegue) {
        switch segue {
        case .home:
            popToRoot()
            
        case .details:
            path.append(segue)
            
        case .sheetSettings:
            sheet = segue
            
        case .dismissSheet:
            sheet = nil
            
        case .pop:
            _ = path.popLast()
            
        case .popToRoot:
            popToRoot()
        }
    }
    
    private func popToRoot() {
        path.removeAll()
        sheet = nil
    }
}
