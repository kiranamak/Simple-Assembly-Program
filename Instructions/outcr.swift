//
//  outcr.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/28/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

class outcr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 45, name: "outcr")
    }
    
    override func run(_ args: [Int]) {
        let charVal = memory[Register(rawValue: args[0])!]
        print(unicodeValueToCharacter(charVal), terminator: "")    }
}
