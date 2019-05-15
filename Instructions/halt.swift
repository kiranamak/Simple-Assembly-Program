//
//  halt.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/28/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

//Instructions: 0

class halt: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 0, 0)
    }
    
    init() {
        super.init(0, 0)
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        VM.setHalt(true)
    }
}
