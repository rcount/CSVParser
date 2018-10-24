//
// Created by Stephen Vickers on 10/23/18.
// Copyright (c) 2018 Stephen Vickers. All rights reserved.
//

import Foundation

/*:
    Open Class to read data from a text file. (i.e. .txt, .csv, .dat, etc)
    This file reads the "Swift" way of reading the whole file and then returning it as one string
*/
open class FileReader {

    //MARK: - Public variables for the class -

    /*:
        Public var to hold the text from the file.
    */
    public var text = ""

    /*:
        Public variable to hold the path of the file
    */
    public var path = ""

    /*:
        Public variable to hold the encoding for the file
    */
    public var encoding: String.Encoding = .utf8

    //MARK: - Constructors for the class -

    /*:
        Public constructor for the class

        -Parameters:
            - path: A [String](String) containing the path to the file to read from
            - encoding: A [String.Encoding](String.Encoding) that is the encoding of the file we want to read from
    */
    public init(path: String = "", encoding: String.Encoding = .utf8) {
        self.path = path
        self.encoding = encoding
        self.text = try! String(contentsOfFile: self.path, encoding: self.encoding)
    }

    //MARK: - Public methods for the class -

    /*:
        Public function to read from a text file

        -Returns: A [String](String) Containing the contents of the file

        -throws: An Error if Reading from the String throws an error
    */
    public func read() throws -> String {
        return try String(contentsOfFile: self.path, encoding: self.encoding)
    }

}

extension FileReader{

    /*:
        Public static function to read from a text file

       -Parameters:
            - path: A [String](String) containing the path to the file to read from
            - encoding: A [String.Encoding](String.Encoding) that is the encoding of the file we want to read from

        -Returns: A [String](String) Containing the contents of the file

        -throws: An Error if Reading from the String throws an error
    */
    public static func read(path: String, encoding: String.Encoding = .utf8) throws -> String{
            return try String(contentsOfFile: path, encoding: encoding)
    }
}
