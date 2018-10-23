//
// Created by Stephen Vickers on 10/23/18.
// Copyright (c) 2018 Stephen Vickers. All rights reserved.
//

import Foundation

open class FileReader {

    public var text = ""

    init(path: String, encoding: String.Encoding = .utf8){
        self.text = try! String(contentsOfFile: path, encoding: encoding)
    }

    static public func read(path: String, encoding: String.Encoding = .utf8) -> String{
        return try! String(contentsOfFile: path, encoding: encoding)
    }
}
