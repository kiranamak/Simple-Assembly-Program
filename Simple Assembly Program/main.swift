//
//  main.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/26/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

let path = "/Users/kmak/Desktop/doubles.bin.txt"
let path2 = "/Users/kmak/Desktop/Dbls.txt"
let path3 = "/Users/kmak/Desktop/Turing.txt"
let fileContents = readTextFile(path3).1!
let binary = splitStringIntoInts(readTextFile(path).1!)
var m = Memory(binary: binary)


print("hello world")
/*let a = VM(memory: m)
a.run()
let b = Tokenizer(fileText: fileContents)
b.createChunks()
b.createTokens()
for i in 0..<b.lines.count {
    print("\(b.lines[i]) \(b.chunks[i])", terminator: " ")
    for t in b.tokens[i] {
        print(t.type.rawValue, terminator: " ")
    }
    print("\n")
}*/
/*let b = Assembler(fileContents)
print(b.run())
print(b.symbols)
print(b.lst)
*/

let x = UI()
x.run()

