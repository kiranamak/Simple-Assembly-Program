//
//  cmp.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/28/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

//Instructions: 33-35

class cmpir: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 33)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.int, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[Register.rCP] = (memory[r1!] - int)
    }
}

class cmprr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 34)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.register, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[Register.rCP] = (memory[r1!] - memory[r2!])
    }
}

class cmpmr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 35)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.label, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[Register.rCP] = (memory[r1!] - memory[label])
    }
}
