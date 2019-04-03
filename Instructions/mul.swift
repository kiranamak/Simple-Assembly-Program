//
//  mul.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 4/2/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

//Instructions: 20-23

class mulir: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 20)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.int, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[r1!] *= int
        
    }
}

class mulrr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 21)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.register, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[r2!] *= memory[r1!]
    }
}

class mulmr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 22)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.label, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[r1!] *= memory[label]
    }
}

class mulxr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 23)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.register, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[r2!] *= memory[memory[r1!]]
    }
}
