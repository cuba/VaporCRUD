//
//  CrudRequestHandler.swift
//  App
//
//  Created by Jacob Sikorski on 2018-11-28.
//

import Foundation
import Vapor

public class CrudRequestHandler: Responder {
    
    public let operation: CrudOperation
    public let path: [PathComponent]
    public let type: CrudControllerInterface.Type
    
    public init(operation: CrudOperation, path: [PathComponent], type: CrudControllerInterface.Type) {
        self.operation = operation
        self.path = path
        self.type = type
    }
    
    public func respond(to request: Request) throws -> Future<Response> {
        let handler = try type.init(request: request, handler: self)
        return try handler.response(from: request, with: operation)
    }
}
