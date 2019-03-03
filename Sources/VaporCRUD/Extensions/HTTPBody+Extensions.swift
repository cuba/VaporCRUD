//
//  HTTPBody+Extensions.swift
//  Async
//
//  Created by Jacob Sikorski on 2019-03-03.
//

import Foundation
import HTTP

public extension HTTPBody {
    public init<T: Encodable>(json: T) throws {
        let encoder = JSONEncoder()
        encoder.dateEncodingStrategy = .default
        
        if #available(OSX 10.13, *) {
            encoder.outputFormatting = [.sortedKeys, .prettyPrinted]
        } else {
            encoder.outputFormatting = [.prettyPrinted]
        }
        
        let data = try encoder.encode(json)
        self.init(data: data)
    }
    
    public func object<T: Decodable>(_ type: T.Type) throws -> T? {
        guard let data = self.data else { return nil }
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .default
        
        return try decoder.decode(type, from: data)
    }
}
