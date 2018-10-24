//
//  main.swift
//  CSVParser
//
//  Created by Stephen Vickers on 10/23/18.
//  Copyright © 2018 Stephen Vickers. All rights reserved.
//

import Foundation

extension Set{
    mutating func append(_ e: Element){
        self.insert(e)
    }
}

let path = "/Users/stephenvickers/Downloads/reviews.csv"


//do{
//    let csv = try FileReader.read(path: path)
//    print(CSVSerialization.isValidCSVObject(csv))
//
//}catch {
//    print(error)
//}

let csv = try CSV(path: path)




//var reviews = [Review]()

//csv.enumerateAsArray(block: {array in
//     print(array[9])
//})
//
//csv.enumerateAsArray(block: {array in
//    let tempReview = Review()
//    tempReview.product = array[0]
//    tempReview.state = array[1]
//    tempReview.rating = Int(array[2])!
//    tempReview.title = array[3]
//    tempReview.author = array[4]
//    tempReview.email = array[5]
//    tempReview.body = array[7]
//    tempReview.created_at = array[9]
//
//    reviews.append(tempReview)
//})

//print()
//
//print(reviews.filter({$0.state != "published"}))



