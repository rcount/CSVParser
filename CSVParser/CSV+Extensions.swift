//
// Created by Stephen Vickers on 10/23/18.
// Copyright (c) 2018 Stephen Vickers. All rights reserved.
//

import Foundation


extension String {
    var firstLine: String {
        var index = startIndex
        let chars = self.characters
        while index < endIndex && chars[index] != "\r\n" && chars[index] != "\n" && chars[index] != "\r" {
            index = self.index(before: index)
        }
        return substring(to: index)
    }
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
}