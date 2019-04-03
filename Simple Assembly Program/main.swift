//
//  main.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/26/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

func readTextFile(_ path: String) -> (message: String?, fileText: String?) {
    let text: String
    do {
        text = try String(contentsOfFile: path, encoding: String.Encoding.utf8)
    } catch {
        return ("\(error)", nil)
    }
    return (nil, text)
}


let path = "/Users/kmak/Desktop/doubles.txt"
let binary = splitStringIntoParts(readTextFile(path).1!)
var m = Memory(binary: binary)

let commands = [halt(m),
                movrr(m),
                movmr(m),
                addir(m),
                addrr(m),
                cmprr(m),
                outcr(m),
                printi(m),
                outs(m),
                jmpne(m)
]

let a = VM(commands: commands, memory: m)
a.run()
