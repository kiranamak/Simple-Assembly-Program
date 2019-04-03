//
//  soj.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 4/2/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

//Instructions: 29-32

class sojz: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 29)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.register, .label]
    }
    
    override func run(_ args: [Int]){
        super.run(args)
        let subirInstruction = subir(memory)
        subirInstruction.run([1, r1!.rawValue])
        if memory[Register.rCP] == 0 {
            memory[.rPC] = label
        }
    }
}

class sojnz: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 30)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.register, .label]
    }
    
    override func run(_ args: [Int]){
        super.run(args)
        let subirInstruction = subir(memory)
        subirInstruction.run([1, r1!.rawValue])
        if memory[Register.rCP] != 0 {
            memory[.rPC] = label
        }
    }
}

class aojz: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 31)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.register, .label]
    }
    
    override func run(_ args: [Int]){
        super.run(args)
        let addirInstruction = addir(memory)
        addirInstruction.run([1, r1!.rawValue])
        if memory[Register.rCP] == 0 {
            memory[.rPC] = label
        }
    }
}

class aojnz: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 32)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.register, .label]
    }
    
    override func run(_ args: [Int]){
        super.run(args)
        let addirInstruction = addir(memory)
        addirInstruction.run([1, r1!.rawValue])
        if memory[Register.rCP] != 0 {
            memory[.rPC] = label
        }
    }
}
