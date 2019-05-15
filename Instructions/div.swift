//
//  div.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 4/2/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

//Instructions: 24-27

class divir: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 24)
    }
    
    init() {
        super.init(2, 24)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.int, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        checkDivisionByZero(int)
        memory[r1!] /= int
        
    }
}

class divrr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 25)
    }
    
    init() {
        super.init(2, 25)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.register, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        checkDivisionByZero(memory[r1!])
        memory[r2!] /= memory[r1!]
    }
}

class divmr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 26)
    }
    
    init() {
        super.init(2, 26)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.label, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        checkDivisionByZero(memory[label])
        memory[r1!] /= memory[label]
    }
}

class divxr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 27)
    }
    
    init() {
        super.init(2, 27)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.register, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        checkDivisionByZero(memory[memory[r1!]])
        memory[r2!] /= memory[memory[r1!]]
    }
}
