//
//  movmr.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/28/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

class movmr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 8, name: "movmr")
    }
    
    override func run(_ args: [Int]) {
        let label = memory[args[0]]
        let r = Register(rawValue: args[1])
        
        memory[r!] = label

    }
}
