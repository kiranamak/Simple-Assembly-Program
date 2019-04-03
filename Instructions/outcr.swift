//
//  outcr.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/28/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

//Instructions: 45, 55

class outcr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 45)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        let charVal = memory[r1!]
        print(unicodeValueToCharacter(charVal), terminator: "")    }
}

class outs: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 55)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.label]
    }
    
    override func run(_ args: [Int]){
        super.run(args)
        var str = ""
        for i in 1...memory[label] {
            let charVal = memory[label + i]
            str += String(unicodeValueToCharacter(charVal))
        }
        print(str, terminator: "")
    }
}

