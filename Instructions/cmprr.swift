//
//  cmprr.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/28/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

class cmprr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 34, name: "cmprr")
    }
    
    override var parameterTypes: [Parameters?] {
        return [.register, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[Register.rCP] = (memory[r1!] - memory[r2!])
    }
}
