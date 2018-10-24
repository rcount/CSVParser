//
// Created by Stephen Vickers on 10/23/18.
// Copyright (c) 2018 Stephen Vickers. All rights reserved.
//

import Foundation

/*:
    Public Enum to for a Delimiter for a CSV file
*/
public enum Delimiter{
    case comma
    case tab
    case colon
    case semicolon
    case pipe

}

//MARK: - Extension to make Delimiter conform to RawRepresentable
extension Delimiter: RawRepresentable{
    public init?(rawValue: String) {
        switch rawValue{
            case ",":
                self = .comma
            case "\t":
                self = .tab
            case ":":
                self = .colon
            case ";":
                self = .semicolon
            case "|":
                self = .pipe
            default:
                self = .comma
        }
    }

    public var rawValue: String {
        switch self{
            case .comma:
                return ","
            case .tab:
                return "\t"
            case .colon:
                return ":"
            case .semicolon:
                return ";"
            case .pipe:
                return "|"
        }
    }
}

//MARK: - Extension to make Delimiter conform to CustomStringConvertible
extension Delimiter: CustomStringConvertible{
    public var description: String {
        return self.rawValue
    }
}

//MARK: - Extension to make Delimiter conform to Equatable
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
