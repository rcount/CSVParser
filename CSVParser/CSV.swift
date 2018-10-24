//
// Created by Stephen Vickers on 10/23/18.
// Copyright (c) 2018 Stephen Vickers. All rights reserved.
//

import Foundation

/*:
    Public class to get data from a CSV file.
*/
public class CSV {

    //MARK: - Public variables for the class -

    public var header: [String]!
    public var text: String
    public var delimiter: Delimiter

    /*: List of dictionaries that contains the CSV data */
    public var rows: [[String: String]] {
        if self._rows == nil {
            self.parse()
        }
        return _rows!
    }

    /*:
        Dictionary of header name to list of values in that column
         Will not be loaded if loadColumns in init is false
    */
    public var columns: [String: [String]] {
        if !self.loadColumns {
            return [:]
        } else if _columns == nil {
            parse()
        }
        return _columns!
    }

    //MARK: - Private Variables for the class -

    private var _rows: [[String: String]]? = nil
    private var _columns: [String: [String]]? = nil
    private let loadColumns: Bool

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

        self.enumerate(asArray: createHeader, limitTo: 1, startAt: 0)
    }

    //MARK: - Public functions for the class -

    /*:
        Turn the CSV data into [Data](Data) using a given encoding

        -Parameter using: A String.Encoding to encode the data to

        -Return: An optional Data representation
    */
    public func data(using encoding: String.Encoding = .utf8) -> Data?{
        return self.description.data(using: encoding)
    }

    /*:
        Parse the file and call a block on each row, passing it in as a list of fields
        limitTo will limit the result to a certain number of lines
    */
    public func enumerate(asArray block: @escaping ([String]) -> (), limitTo: Int?, startAt: Int = 0) {
        var currentIndex = text.startIndex
        let endIndex = text.endIndex

        var atStart = true
        var parsingField = false
        var parsingQuotes = false
        var innerQuotes = false

        var fields = [String]()
        var field = [Character]()

        var count = 0
        let doLimit = limitTo != nil

        let callBlock: () -> () = {
            fields.append(String(field))
            if count >= startAt {
                block(fields)
            }
            count += 1
            fields = [String]()
            field = [Character]()
        }

        let changeState: (Character) -> (Bool) = { char in
            if atStart {
                if char == "\"" {
                    atStart = false
                    parsingQuotes = true
                } else if char == self.delimiter {
                    fields.append(String(field))
                    field = [Character]()
                } else if CSV.isNewline(char: char) {
                    callBlock()
                } else {
                    parsingField = true
                    atStart = false
                    field.append(char)
                }
            } else if parsingField {
                if innerQuotes {
                    if char == "\"" {
                        field.append(char)
                        innerQuotes = false
                    } else {
                        fatalError("Can't have non-quote here: \(char)")
                    }
                } else {
                    if char == "\"" {
                        innerQuotes = true
                    } else if char == self.delimiter {
                        atStart = true
                        parsingField = false
                        innerQuotes = false
                        fields.append(String(field))
                        field = [Character]()
                    } else if CSV.isNewline(char: char) {
                        atStart = true
                        parsingField = false
                        innerQuotes = false
                        callBlock()
                    } else {
                        field.append(char)
                    }
                }
            } else if parsingQuotes {
                if innerQuotes {
                    if char == "\"" {
                        field.append(char)
                        innerQuotes = false
                    } else if char == self.delimiter {
                        atStart = true
                        parsingField = false
                        innerQuotes = false
                        fields.append(String(field))
                        field = [Character]()
                    } else if CSV.isNewline(char: char) {
                        atStart = true
                        parsingQuotes = false
                        innerQuotes = false
                        callBlock()
                    } else {
                        fatalError("Can't have non-quote here: \(char)")
                    }
                } else {
                    if char == "\"" {
                        innerQuotes = true
                    } else {
                        field.append(char)
                    }
                }
            } else {
                fatalError("me_irl")
            }
            return doLimit && count >= limitTo!
        }

        while currentIndex < endIndex {
            let char = text[currentIndex]
            if changeState(char) {
                break
            }
            currentIndex = text.index(after: currentIndex)
        }

        if fields.count != 0 || field.count != 0 || (doLimit && count < limitTo!) {
            fields.append(String(field))
            block(fields)
        }
    }



    /// Parse the file and call a block for each row, passing it as a dictionary
    public func enumerate( asDict block: @escaping ([String: String]) -> ()) {
        let enumeratedHeader = self.header.enumerated()

        self.enumerate(asArray: { fields in
            var dict = [String: String]()
            for (index, head) in enumeratedHeader {
                dict[head] = index < fields.count ? fields[index] : ""
            }
            block(dict)
        })
    }

    /// Parse the file and call a block on each row, passing it in as a list of fields
    public func enumerate(asArray block: @escaping ([String]) -> ()) {
        self.enumerate(asArray: block, limitTo: nil, startAt: 1)
    }

    /*:
        Private function to parse the data from the CSVObject
    */
    private func parse() {
        var rows = [[String: String]]()
        var columns = [String: [String]]()

        self.enumerate(asDict:  { dict in
            rows.append(dict)
        })

        if self.loadColumns {
            for field in header {
                columns[field] = rows.map { $0[field] ?? "" }
            }
        }

        self._columns = columns
        self._rows = rows
    }

    /*:
        Private static function to check if a character is a newLine character

        -Returns: A [Bool](Bool) Representing whether or not a character is a newLine character;
                    true if it is, false otherwise.
    */
    private static func isNewline(char: Character) -> Bool {
        return char == "\n" || char == "\r\n"
    }

}

extension CSV{
    /*:
       Load a CSV file from a URL

       -Parameters:
            - path: String url pointing to the file (will be passed to String(contentsOfURL:encoding:) to load)
            - delimiter: character to split row and header fields by (default is ',')
            - encoding: encoding used to read file (default is String.Encoding.utf8)
            - loadColumns: whether to populate the columns dictionary (default is true)

    */
    public convenience init(path: String, delimiter: Delimiter = .comma, encoding: String.Encoding = .utf8, loadColumns: Bool = true) throws {
        let text = try FileReader.read(path: path, encoding: encoding)

        self.init(text: text, delimiter: delimiter, loadColumns: loadColumns)
    }
}

extension CSV: CustomStringConvertible {

    /*:
        Public calculated variable to get a CustomStringConvertible representation of A CSV object

        -Returns: A [String](String) representation of the object

        -Important: This is so we can call print(csvObject) and have it print on the screen
    */
    public var description: String {
        let head = self.header.joined(separator: self.delimiter.rawValue)

        let cont = rows.map { row in
            header.map { row[$0]! }.joined(separator: self.delimiter.rawValue)
        }.joined(separator: "\n")

        return "\(head)\(cont)"
    }
}
