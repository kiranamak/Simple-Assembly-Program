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


let path = "/Users/kmak/Desktop/TuringEBin.txt"
let path2 = "/Users/kmak/Desktop/Dbls.txt"
let fileContents = readTextFile(path2).1!
let binary = splitStringIntoInts(readTextFile(path).1!)
var m = Memory(binary: binary)

let commands = [halt(m),
                clrr(m),
                clrx(m),
                clrm(m),
                clrb(m),
                movir(m),
                movrr(m),
                movmr(m),
                movxr(m),
                movar(m),
                movb(m),
                addir(m),
                addrr(m),
                addmr(m),
                addxr(m),
                subir(m),
                subrr(m),
                submr(m),
                subxr(m),
                mulir(m),
                mulrr(m),
                mulmr(m),
                mulxr(m),
                divir(m),
                divrr(m),
                divmr(m),
                divxr(m),
                jmp(m),
                sojz(m),
                sojnz(m),
                aojz(m),
                aojnz(m),
                cmpir(m),
                cmprr(m),
                cmpmr(m),
                jmpn(m),
                jmpz(m),
                jmpp(m),
                jsr(m),
                ret(m),
                push(m),
                pop(m),
                stackc(m),
                outci(m),
                outcr(m),
                outcx(m),
                outcb(m),
                printi(m),
                movrx(m),
                movxx(m),
                outs(m),
                nop(m),
                jmpne(m)
]
print("hello world")
let a = VM(commands: commands, memory: m)
a.run()
let b = Tokenizer(fileText: fileContents, commands: commands)
b.createChunks()
b.createTokens()
for i in 0..<b.lines.count {
    print("\(b.lines[i]) \(b.chunks[i])", terminator: " ")
    for t in b.tokens[i] {
        print(t.rawValue, terminator: " ")
    }
    print("\n")
}
