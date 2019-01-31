//
//  Router+Extensions.swift
//  App
//
//  Created by Jacob Sikorski on 2018-11-27.
//

import Foundation
import Vapor

public extension Router {
    
    public func register(path: [PathComponent], operation: CrudOperation, type: CrudControllerInterface.Type) {
        for method in operation.methods {
            let adjustedPath: [PathComponent] = [.constant(method.string)] + path
            let requestHandler = CrudRequestHandler(operation: operation, path: adjustedPath, type: type)
            let route = Route<Responder>(path: adjustedPath, output: requestHandler)
            register(route: route)
        }
    }
    
    public func register(path: String, operation: CrudOperation, type: CrudControllerInterface.Type) {
        let pathComponents = path.convertToPathComponents()
        register(path: pathComponents, operation: operation, type: type)
    }
    
    public func register(path: PathComponentsRepresentable, operation: CrudOperation, type: CrudControllerInterface.Type) {
        let pathComponents = path.convertToPathComponents()
        register(path: pathComponents, operation: operation, type: type)
    }
    
    public func register(basePath: [PathComponent], operations: [CrudOperation], type: CrudControllerInterface.Type) {
        for operation in operations {
            let path = operation.path(fromBasePath: basePath)
            register(path: path, operation: operation, type: type)
        }
    }
    
    public func register(basePath: String, operations: [CrudOperation], type: CrudControllerInterface.Type) {
        let pathMatcher = PathMatcher(path: basePath)
        register(basePath: pathMatcher, operations: operations, type: type)
    }
    
    public func register(basePath: PathComponentsRepresentable, operations: [CrudOperation], type: CrudControllerInterface.Type) {
        let pathComponents = basePath.convertToPathComponents()
        register(basePath: pathComponents, operations: operations, type: type)
    }
}
