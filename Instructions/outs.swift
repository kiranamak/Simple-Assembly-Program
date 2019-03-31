//
//  outs.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/28/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

class outs: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 55, name: "outs")
    }
    
    override func run(_ args: [Int]){
        let label = args[0]
        var str = ""
        for i in 1...memory[label] {
            let charVal = memory[label + i]
            str += String(unicodeValueToCharacter(charVal))
        }
        print(str, terminator: "")
    }
}
