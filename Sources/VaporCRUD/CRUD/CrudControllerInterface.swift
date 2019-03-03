//
//  CrudControllerInterface.swift
//  App
//
//  Created by Jacob Sikorski on 2018-11-26.
//

import Foundation
import Vapor

public protocol CrudControllerInterface {
    init(request: Request, handler: CrudRequestHandler) throws
    
    func create(request: Request) throws -> EventLoopFuture<Response>
    func show(request: Request) throws -> EventLoopFuture<Response>
    func update(request: Request) throws -> EventLoopFuture<Response>
    func destroy(request: Request) throws -> EventLoopFuture<Response>
    func list(request: Request) throws -> EventLoopFuture<Response>
    func replace(request: Request) throws -> EventLoopFuture<Response>
}

public extension CrudControllerInterface {
    
    public func response(from request: Request, with operation: CrudOperation) throws -> Future<Response> {
        switch operation {
        case .create    : return try create(request: request)
        case .destroy   : return try destroy(request: request)
        case .show      : return try show(request: request)
        case .update    : return try update(request: request)
        case .list      : return try list(request: request)
        case .replace   : return try replace(request: request)
        }
    }
}
