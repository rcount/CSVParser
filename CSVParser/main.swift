//
//  main.swift
//  CSVParser
//
//  Created by Stephen Vickers on 10/23/18.
//  Copyright © 2018 Stephen Vickers. All rights reserved.
//

import Foundation


let path = "/Users/stephenvickers/Downloads/reviews.csv"

let csv = try CSV(path: path)

print()

print(csv.rows[0])

