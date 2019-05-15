//
//  clr.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 4/1/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

//Instructions: 1 - 4

class clrr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 1)
    }
    
    init() {
        super.init(1, 1)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        
        memory[r1!] = 0
    }
}

class clrx: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 2)
    }
    
    init() {
        super.init(1, 2)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        
        memory[memory[r1!]] = 0
    }
}

class clrm: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 3)
    }
    
    init() {
        super.init(1, 3)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.label]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        
        memory[label] = 0
    }
}

class clrb: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 4)
    }
    
    init() {
        super.init(2, 4)
    }
    
    override var parameterTypes: [ParameterType?] {
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

