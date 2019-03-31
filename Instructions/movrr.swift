//
//  movrr.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/30/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

class movrr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 6, name: "movrr")
    }
    
    override func run(_ args: [Int]) {
        let r1 = Register(rawValue: args[0])
        let r2 = Register(rawValue: args[1])
        
        memory[r2!] = memory[r1!]

    }
}
