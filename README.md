# CSVParser

Module to parse either a comma, tab, newLine, or pipe ("|") separated file.

## Usage

```Swift 
//from String
let csv = CSV(text: "id,name,age\n1,Alice,18")

//With a custom Delimiter
let tsv = CSV(text: "id\tname\tage\n1\tAlice\t18", delimiter = .tab)```

//From a file with errors
do{
  let csv = CSV(path: "pathToFile")
}catch{
  //Handle errors
}

```

if you don't need the headers you can set the loadHeaders to false and it will be discarded

## ReadData

```swift
let csv = CSV(string: "id,name,age\n1,Alice,18\n2,Bob,19")
csv.header    //=> ["id", "name", "age"]
csv.rows      //=> [["id": "1", "name": "Alice", "age": "18"], ["id": "2", "name": "Bob", "age": "19"]]
csv.columns   //=> ["id": ["1", "2"], "name": ["Alice", "Bob"], "age": ["18", "19"]]
```
