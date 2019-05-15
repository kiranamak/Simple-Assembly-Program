//
//  sub.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 4/2/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

//Instructions: 16-19

class subir: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 16)
    }
    
    init() {
        super.init(2, 16)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.int, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[r1!] -= int
        
    }
}

class subrr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 17)
    }
    
    init() {
        super.init(2, 17)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.register, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[r2!] -= memory[r1!]
    }
}

class submr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 18)
    }
    
    init() {
        super.init(2, 18)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.label, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[r1!] -= memory[label]
    }
}

class subxr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 19)
    }
    
    init() {
        super.init(2, 19)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.register, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[r2!] -= memory[memory[r1!]]
    }
}

