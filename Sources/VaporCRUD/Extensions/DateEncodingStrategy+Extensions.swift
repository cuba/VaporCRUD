//
//  DateEncodingStrategy+Extensions.swift
//  Async
//
//  Created by Jacob Sikorski on 2019-03-03.
//

import Foundation

public extension JSONEncoder.DateEncodingStrategy {
    public static let `default`: JSONEncoder.DateEncodingStrategy = {
        if #available(OSX 10.12, *) {
            return .iso8601
        } else {
            return .rfc3339
        }
    }()
    
    public static let rfc3339: JSONEncoder.DateEncodingStrategy = {
        return JSONEncoder.DateEncodingStrategy.formatted(DateFormatter.rfc3339)
    }()
}

public extension JSONDecoder.DateDecodingStrategy {
    public static let `default`: JSONDecoder.DateDecodingStrategy = {
        if #available(OSX 10.12, *) {
            return .iso8601
        } else {
            return .rfc3339
        }
    }()
    
    public static let rfc3339: JSONDecoder.DateDecodingStrategy = {
        return JSONDecoder.DateDecodingStrategy.formatted(DateFormatter.rfc3339)
    }()
}
