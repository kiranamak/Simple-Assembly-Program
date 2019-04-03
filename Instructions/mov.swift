//
//  movrr.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/30/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

//Instructions: 5-11

class movir: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 5)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.int, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[r1!] = int
    }
}


class movrr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 6)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.register, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[r2!] = memory[r1!]

    }
}

class movrm: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 7)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.register, .label]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[label] = memory[r1!]
        
    }
}

class movmr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 8)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.label, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[r1!] = memory[label]
    }
}

class movxr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 8)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.register, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[r2!] = memory[r1!]
    }
}

class movar: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 8)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.label, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[r1!] = label
    }
}

