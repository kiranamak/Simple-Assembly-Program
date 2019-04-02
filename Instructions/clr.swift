//
//  clr.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 4/1/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

class clrr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 1, name: "clrr")
    }
    
    override var parameterTypes: [Parameters?] {
        return [.register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        
        memory[r1!] = 0
    }
}

class clrx: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 2, name: "clrx")
    }
    
    override var parameterTypes: [Parameters?] {
        return [.register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        
        memory[memory[r1!]] = 0
    }
}

class clrm: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 3, name: "clrm")
    }
    
    override var parameterTypes: [Parameters?] {
        return [.label]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        
        memory[label] = 0
    }
}

class clrb: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 4, name: "clrb")
    }
    
    override var parameterTypes: [Parameters?] {
        return [.register, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        let start = memory[r1!]
        let count = memory[r2!]
        
        for i in start..<(start + count) {
            memory[i] = 0
        }  
    }
}

