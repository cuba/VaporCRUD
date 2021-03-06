//
//  CrudOperation.swift
//  App
//
//  Created by Jacob Sikorski on 2018-11-24.
//

import Vapor

public enum CrudOperation {
    case create
    case show
    case update
    case replace
    case destroy
    case list
    
    public var description: String {
        switch self {
        case .create        : return "CREATE"
        case .show          : return "SHOW"
        case .update        : return "UPDATE"
        case .destroy       : return "DESTROY"
        case .list          : return "LIST"
        case .replace       : return "REPLACE"
        }
    }
    
    public var method: HTTPMethod {
        switch self {
        case .create    : return .POST
        case .show      : return .GET
        case .update    : return .PATCH
        case .destroy   : return .DELETE
        case .list      : return .GET
        case .replace   : return .PUT
        }
    }
    
    public func path(fromBasePath basePath: [PathComponent]) -> [PathComponent] {
        var path = basePath
        
        switch self {
        case .destroy, .show, .update, .replace:
            path.append(String.parameter)
        default:
            break
        }
        
        return path
    }
}
