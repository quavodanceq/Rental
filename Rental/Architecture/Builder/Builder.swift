//
//  Builder.swift
//  Rental
//
//  Created by Куат Оралбеков on 28.11.2025.
//

public protocol BuilderType {
    
    associatedtype Localization
    associatedtype Segue: SegueType
    associatedtype Context
    associatedtype Product
    
    var container: Container { get }
    
    init(parent: Container)
    
    func register(localization: Localization, routing: @escaping (Segue) -> Void)
    
    func make(context: Context) -> Product
    
}

public extension BuilderType {
    func register(localization: Localization, routing: @escaping (Segue) -> Void) { }
}

public extension BuilderType where Context == Void {
    func make() -> Product { make(context: ()) }
}
