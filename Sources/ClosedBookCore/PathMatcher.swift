//
//  PathMatcher.swift
//  App
//
//  Created by Jacob Sikorski on 2018-11-26.
//

import Foundation
import Vapor

public struct PathMatcher: RawRepresentable {
    
    public init?(rawValue: String) {
        self.init(path: rawValue)
    }
    
    public var rawValue: String {
        return components.map({ $0.rawValue }).joined(separator: "/")
    }
    
    public var components: [PathComponent]
    
    public init(path: String) {
        let stringComponents = path.replacingOccurrences(of: " ", with: "").components(separatedBy: "/")
        
        let components: [PathComponent] = stringComponents.compactMap({
            guard !$0.isEmpty else { return nil }
            return PathComponent(rawValue: $0)
        })
        
        self.components = components
    }
    
    public func isMatched(byPath path: String) -> Bool {
        let stringComponents = path.components(separatedBy: "/").filter({ !$0.isEmpty })
        guard stringComponents.count >= components.count else { return false }
        
        for (index, component) in components.enumerated() {
            let stringComponent = stringComponents[index]
            
            switch component {
            case .constant(let name):
                guard stringComponent == name else { return false }
                continue
            case .parameter:
                continue
            case .anything:
                continue
            case .catchall:
                return true
            }
        }
        
        return true
    }
}

extension PathMatcher: PathComponentsRepresentable {
    public func convertToPathComponents() -> [PathComponent] {
        return components
    }
}
