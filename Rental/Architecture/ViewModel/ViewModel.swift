//
//  ViewModel.swift
//  Rental
//
//  Created by Куат Оралбеков on 27.11.2025.
//

import Foundation
import Combine

open class ViewModelInterface <State: StateType, Action: ActionType, Segue: SegueType, Context, Localization>: ObservableObject {
    
    public typealias Routing = (Segue) -> Void
    
    @Published public var state: State
    public let routing: Routing
    public let localization: Localization
    public var context: Context?
    
    public init(state: State = .initial, routing: @escaping Routing, localization: Localization) {
        self.state = state
        self.routing = routing
        self.localization = localization
    }
    
    open func dispatch(action: Action) { }
    
    open func apply(context: Context?) {
        self.context = context
    }
    
    open func reload() { }
    
    public func updateState(_ update: @escaping (inout State) -> Void) {
        DispatchQueue.main.async { [weak self] in
            guard let self else { return }
            var newState = self.state
            update(&newState)
            self.state = newState
        }
    }
}

extension ViewModelInterface: Equatable {
    public static func ==(
        lhs: ViewModelInterface<State, Action, Segue, Context, Localization>,
        rhs: ViewModelInterface<State, Action, Segue, Context, Localization>
    ) -> Bool {
        lhs.state == rhs.state
    }
}
