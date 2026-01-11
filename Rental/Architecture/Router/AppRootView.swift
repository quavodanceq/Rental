//
//  AppRootView.swift
//  Rental
//
//  Created by Куат Оралбеков on 11.01.2026.
//

import SwiftUI

struct AppRootView: View {
    @StateObject private var router = Router()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            ContentView()
                .navigationDestination(for: AppSegue.self) { route in
                    switch route {
                    case .details(let id):
                        Text("Details: \(id)")
                        
                    case .home:
                        ContentView()
                        
                    default:
                        EmptyView()
                    }
                }
                .sheet(item: $router.sheet) { route in
                    switch route {
                    case .sheetSettings:
                        Text("Settings")
                    default:
                        EmptyView()
                    }
                }
        }
    }
}
