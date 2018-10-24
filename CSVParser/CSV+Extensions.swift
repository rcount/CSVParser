//
// Created by Stephen Vickers on 10/23/18.
// Copyright (c) 2018 Stephen Vickers. All rights reserved.
//

import Foundation


extension String {

    static var empty: String {
        return ""
    }

    var char: Character{
        return Character(self)
    }

    var firstLine: String {
        var index = startIndex
        while index < self.endIndex && !String.isEndLine(self[index]) {
            index = self.index(before: index)
        }
        return self[..<index].string
    }

    func split(separator: Delimiter) -> [String.SubSequence]{
        return self.split(separator: separator.rawValue.char)
    }

    static func isEndLine(_ char: Character) -> Bool {
        return char == "\r\n" ||
                char == "\n" ||
                char == "\r"
    }
}

extension StringProtocol{
    var string: String {
        return String(self)
    }

    subscript(offset: Int) -> Element{
        return self[self.index(self.startIndex, offsetBy: offset)]
    }

    subscript(_ range: CountableRange<Int>) -> SubSequence{
        return prefix(range.lowerBound + range.count).suffix(range.count)
    }

    subscript(_ range: CountableClosedRange<Int>) -> SubSequence{
        return prefix(range.lowerBound + range.count)
                .suffix(range.count)
    }

    subscript(_ range: PartialRangeThrough<Int>) -> SubSequence {
        return prefix(range.upperBound.advanced(by: 1))
    }

    subscript(_ range: PartialRangeUpTo<Int>) -> SubSequence {
        return prefix(range.upperBound)
    }

    subscript(_ range: PartialRangeFrom<Int>) -> SubSequence {
        return suffix(Swift.max(0, count - range.lowerBound))
    }
}

extension Substring{
    var string: String {return String(self)}
}

extension Character {
    var string: String{
        return String(self)
    }
}


extension Array where Element == String{
    func joined(separator sep: Character) -> Element{
        return self.joined(separator: sep.string)
    }

    func joined(separator sep: Delimiter) -> Element{
        return self.joined(separator: sep.rawValue)
    }
}