//
//  halt.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/28/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

class halt: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 0, 0, name: "halt")
    }
    
    override func run(_ args: [Int]) {
        VM.setHalt(true)
    }
}
