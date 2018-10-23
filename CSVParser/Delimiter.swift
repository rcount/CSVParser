//
// Created by Stephen Vickers on 10/23/18.
// Copyright (c) 2018 Stephen Vickers. All rights reserved.
//

import Foundation

public enum Delimiter{
    case comma
    case tab
    case newLine
    case pipe

}

extension Delimiter: RawRepresentable{
    public init?(rawValue: Character) {
        switch rawValue{
            case ",":
                self = .comma
            case "\t":
                self = .tab
            case "\n":
                self = .newLine
            case "|":
                self = .pipe
            default:
                self = .comma
        }
    }

    public var rawValue: Character {
        switch self{
            case .comma:
                return ","
            case .tab:
                return "\t"
            case .newLine:
                return "\n"
            case .pipe:
                return "|"
        }
    }
}


extension Delimiter: Equatable{

    public static func ==(lhs: Delimiter, rhs: Delimiter) -> Bool {
        return lhs.rawValue == rhs.rawValue
    }

    public static func ==(lhs: Delimiter, rhs: String) -> Bool{
        return  lhs.rawValue.string == rhs
    }

    public static func ==(lhs: String, rhs: Delimiter) -> Bool{
        return rhs == lhs
    }

    public static func ==(lhs: Character, rhs: Delimiter) -> Bool {
        return lhs.string == rhs
    }

    public static func ==(lhs: Delimiter, rhs: Character) -> Bool{
        return rhs == lhs
    }
}
