//
//  addir.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/28/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

class addir: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 12, name: "addir")
    }
    
    override func run(_ args: [Int]) {
        
        let int = args[0]
        let r = Register(rawValue: args[1])
        memory[r!] += int

    }
}