//
// Created by Stephen Vickers on 10/23/18.
// Copyright (c) 2018 Stephen Vickers. All rights reserved.
//

import Foundation

public class CSV {

    public var header: [String]!

    var _rows: [[String: String]]? = nil
    var _columns: [String: [String]]? = nil

    public var text: String
    public var delimiter: Delimiter

    let loadColumns: Bool

    //MARK: - Constructors for the class -

    /*:
        Load a CSV file from a string

        -Parameters:
            - text: string data of the CSV file
            - delimiter: character to split row and header fields by (default is ',')
            - loadColumns: whether to populate the columns dictionary (default is true)
    */
    public init(text: String, delimiter: Delimiter = .comma, loadColumns: Bool = true){
        self.text = text
        self.delimiter = delimiter
        self.loadColumns = loadColumns

        let createHeader: ([String]) -> () = { head in
            self.header = head
        }

        self.enumerateAsArray(block: createHeader, limitTo: 1, startAt: 0)
    }

    /*:
       Load a CSV file from a URL

       -Parameters:
            - path: String url pointing to the file (will be passed to String(contentsOfURL:encoding:) to load)
            - delimiter: character to split row and header fields by (default is ',')
            - encoding: encoding used to read file (default is NSUTF8StringEncoding)
            - loadColumns: whether to populate the columns dictionary (default is true)

    */
    public convenience init(path: String, delimiter: Delimiter = .comma, encoding: String.Encoding = .utf8, loadColumns: Bool = true) throws {
        let text = FileReader.read(path: path, encoding: encoding)

        self.init(text: text, delimiter: delimiter, loadColumns: loadColumns)
    }

    /*:
        Turn the CSV data into NSData using a given encoding

        -Parameter using: A String.Encoding to encode the data to

        -Return: An optional Data representation
    */
    public func data(using encoding: String.Encoding) -> Data?{
        return self.description.data(using: encoding)
    }

}

extension CSV: CustomStringConvertible {

    public var description: String {
        let head = self.header.joined(separator: self.delimiter.rawValue)

        let cont = rows.map { row in
            header.map { row[$0]! }.joined(separator: self.delimiter.rawValue)
        }.joined(separator: "\n")

        return "\(head)\(cont)"
    }
}
