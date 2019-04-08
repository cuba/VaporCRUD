//
//  Request+Extensions.swift
//  Async
//
//  Created by Jacob Sikorski on 2019-03-03.
//

import Foundation
import Vapor

public extension Request {
    func response<T: Encodable>(from encodable: T, status: HTTPResponseStatus = .ok, headers: HTTPHeaders = .jsonDefault, dateEncodingStrategy: JSONEncoder.DateEncodingStrategy = .default) throws -> Response {
        let body = try HTTPBody(json: encodable, dateEncodingStrategy: dateEncodingStrategy)
        let http = HTTPResponse(status: status, headers: headers, body: body)
        
        return self.response(http: http)
    }
    
    func responseFuture<T: Encodable>(from encodable: T, status: HTTPResponseStatus = .ok, headers: HTTPHeaders = .jsonDefault, dateEncodingStrategy: JSONEncoder.DateEncodingStrategy = .default) throws -> EventLoopFuture<Response> {
        let response = try self.response(from: encodable, status: status, headers: headers, dateEncodingStrategy: dateEncodingStrategy)
        return self.future(response)
    }
    
    func body<T: Decodable>(_ type: T.Type, dateDecodingStrategy: JSONDecoder.DateDecodingStrategy = .default) throws -> T? {
        return try http.body.object(type, dateDecodingStrategy: dateDecodingStrategy)
    }
    
    func noContentResponse() -> Response {
        let http = HTTPResponse(status: .noContent)
        return self.response(http: http)
    }
}

public extension HTTPHeaders {
    static var jsonDefault: HTTPHeaders {
        var headers = HTTPHeaders()
        headers.add(name: .contentType, value: "application/json")
        return headers
    }
}
