//
// Created by Stephen Vickers on 10/23/18.
// Copyright (c) 2018 Stephen Vickers. All rights reserved.
//

import Foundation


extension CSV {
    /// List of dictionaries that contains the CSV data
    public var rows: [[String: String]] {
        if self._rows == nil {
            self.parse()
        }
        return _rows!
    }

    /// Dictionary of header name to list of values in that column
    /// Will not be loaded if loadColumns in init is false
    public var columns: [String: [String]] {
        if !self.loadColumns {
            return [:]
        } else if _columns == nil {
            parse()
        }
        return _columns!
    }

    /// Parse the file and call a block for each row, passing it as a dictionary
    public func enumerateAsDict(block: @escaping ([String: String]) -> ()) {
        let enumeratedHeader = self.header.enumerated()

        self.enumerateAsArray { fields in
            var dict = [String: String]()
            for (index, head) in enumeratedHeader {
                dict[head] = index < fields.count ? fields[index] : ""
            }
            block(dict)
        }
    }

    /// Parse the file and call a block on each row, passing it in as a list of fields
    public func enumerateAsArray(block: @escaping ([String]) -> ()) {
        self.enumerateAsArray(block: block, limitTo: nil, startAt: 1)
    }

    private func parse() {
        var rows = [[String: String]]()
        var columns = [String: [String]]()

        self.enumerateAsDict { dict in
            rows.append(dict)
        }

        if self.loadColumns {
            for field in header {
                columns[field] = rows.map { $0[field] ?? "" }
            }
        }

        self._columns = columns
        self._rows = rows
    }
}
