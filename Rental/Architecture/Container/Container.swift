//
//  Container.swift
//  Rental
//
//  Created by Куат Оралбеков on 28.11.2025.
//
import Swinject
    
public class Container {
    /*
     Coordinator.Container — тонкая обёртка над конкретным DI (Swinject).
     
     Зачем:
     - Изоляция DI: фичи/координаторы/билдеры завязаны на наш API, а не на Swinject → можно заменить DI без правок модулей.
     - Иерархия: child(parent:, defaultObjectScope:) с предсказуемым fallback к родителю при resolve.
     - Скоупы жизни: .container для координаторов (долгоживущие сервисы), .graph для билдеров (VM/View/локальные параметры).
     - Типобезопасность: register<T>/resolve<T> без Any/кастов.
     - Параметризация узла: удобная передача routing/localization/context на уровне контейнера билдера, использование их в фабриках.
     - Контроль политики: единая точка для логов, метрик, ассертов скоупов/переопределений, фичефлагов.
     - Тестируемость: легко подменять контейнер/зависимости в тестах.
     - Чистота зависимостей: фабрики принимают наш Container (не Swinject.Resolver) → нельзя обойти правила иерархии/скоупов.
     
     Ключевая идея: вся сборка идёт через наш контейнер; он адаптирует вызовы к реальному DI под капотом и удерживает контроль.
     */
    public let raw: Swinject.Container
    public let parent: Container?
    public let defaultObjectScope: ObjectScope
    
    public init(parent: Container? = nil, scope: ObjectScope = .container) {
        self.parent = parent
        self.defaultObjectScope = scope
        raw = Swinject.Container(parent: parent?.raw, defaultObjectScope: defaultObjectScope)
    }
    
    public func child(scope: ObjectScope) -> Container {
        Container(parent: self, scope: scope)
    }
    
    public func register<Service>(_ type: Service.Type, scope: ObjectScope, name: String? = nil, factory: @escaping (Container) -> Service) {
        let entry = raw.register(type, name: name) { _ in
            factory(self)
        }
        entry.inObjectScope(scope)
    }
    
    public func register<Service>(_ type: Service.Type, name: String? = nil, factory: @escaping (Container) -> Service) {
        let entry = raw.register(type, name: name) { _ in
            factory(self)
        }
        entry.inObjectScope(defaultObjectScope)
    }
    
    public func resolve<Service>(_ type: Service.Type, name: String? = nil) -> Service? {
        raw.resolve(type, name: name)
    }
    
}
