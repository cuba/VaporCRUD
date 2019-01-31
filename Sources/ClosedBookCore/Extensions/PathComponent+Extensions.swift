//
//  PathComponent.swift
//  App
//
//  Created by Jacob Sikorski on 2018-11-26.
//

import Foundation
import Vapor

extension PathComponent: RawRepresentable {
    public static let parameterPattern = "^\\:[\\w]*\\z"
    
    public var rawValue: String {
        switch self {
        case .anything                  : return ":"
        case .catchall                  : return "*"
        case .constant(let value)       : return value
        case .parameter(let parameter)  : return ":\(parameter)"
        }
    }
    
    public init?(rawValue: String) {
        if rawValue == "*" {
            self = .catchall
            return
        } else if rawValue == ":" {
            self = .anything
            return
        } else if rawValue.hasPrefix(":") {
            let index = rawValue.index(rawValue.startIndex, offsetBy: 1)
            let value = rawValue.suffix(from: index)
            self = .parameter(String(value))
        } else {
            self = .constant(rawValue)
        }
    }
    
    public func matches(string: String) -> Bool {
        switch self {
        case .constant(let name)    : return name == string
        case .parameter             : return true
        case .anything              : return true
        case .catchall              : return true
        }
    }
}
