//
//  jmpne.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/28/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

class jmpne: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 57, name: "jmpne")
    }
    
    override func run(_ args: [Int]){
        let label = args[0]
        if memory[Register.compare] != 0 {
            VM.setPointer(label)
        }
    }
}
