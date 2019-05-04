//
//  jmp.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/28/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

//Instructions: 28, 36-38, 57

class jmp: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 28)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.label]
    }
    
    override func run(_ args: [Int]){
        super.run(args)
        memory[.rPC] = label
    }
}

class jmpn: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 36)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.label]
    }
    
    override func run(_ args: [Int]){
        super.run(args)
        if memory[Register.rCP] < 0 {
            memory[.rPC] = label
        }
    }
}

class jmpz: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 37)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.label]
    }
    
    override func run(_ args: [Int]){
        super.run(args)
        if memory[Register.rCP] == 0 {
            memory[.rPC] = label
        }
    }
}

class jmpp: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 38)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.label]
    }
    
    override func run(_ args: [Int]){
        super.run(args)
        if memory[Register.rCP] > 0 {
            memory[.rPC] = label
        }
    }
}


class jmpne: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 57)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.label]
    }
    
    override func run(_ args: [Int]){
        super.run(args)
        if memory[Register.rCP] != 0 {
            memory[.rPC] = label
        }
    }
}
