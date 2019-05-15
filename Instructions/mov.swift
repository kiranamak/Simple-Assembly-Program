//
//  mov.swift
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
    
    init() {
        super.init(2, 5)
    }
    
    override var parameterTypes: [ParameterType?] {
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
    
    init() {
        super.init(2, 6)
    }
    
    override var parameterTypes: [ParameterType?] {
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
    
    init() {
        super.init(2, 7)
    }
    
    override var parameterTypes: [ParameterType?] {
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
    
    init() {
        super.init(2, 8)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.label, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[r1!] = memory[label]
    }
}

class movxr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 9)
    }
    
    init() {
        super.init(2, 9)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.register, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[r2!] = memory[memory[r1!]]
    }
}

class movar: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 10)
    }
    
    init() {
        super.init(2, 10)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.label, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[r1!] = label
    }
}

class movb: Instruction {
    init(_ memory: Memory) {
        super.init(memory, 2, 11)
    }
    
    init() {
        super.init(2, 11)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.register, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        for i in 0..<memory[r3!] {
            memory[memory[r2!] + i] = memory[memory[r1!] + i]
        }
    }
}

class movrx: Instruction {
    init(_ memory: Memory) {
        super.init(memory, 2, 53)
    }
    
    init() {
        super.init(2, 53)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.register, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[memory[r2!]] = memory[r1!]
    }
}


class movxx: Instruction {
    init(_ memory: Memory) {
        super.init(memory, 2, 54)
    }
    
    init() {
        super.init(2, 54)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.register, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[memory[r2!]] = memory[memory[r1!]]
    }
}


