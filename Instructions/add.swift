//
//  addir.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/28/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

//Instructions: 12-15

class addir: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 12)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.int, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[r1!] += int

    }
}

class addrr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 13)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.register, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[r2!] += memory[r1!]
    }
}

class addmr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 14)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.label, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[r1!] += memory[label]
    }
}

class addxr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 15)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.register, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[r2!] += memory[memory[r1!]]
    }
}

