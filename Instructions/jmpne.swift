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
    
    override var parameterTypes: [Parameters?] {
        return [.label, nil]
    }
    
    override func run(_ args: [Int]){
        super.run(args)
        if memory[Register.rCP] != 0 {
            memory[.rPC] = label
        }
    }
}
