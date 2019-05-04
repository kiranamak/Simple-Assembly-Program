//
//  jsr-ret.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 4/2/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

//Instructions: 39-40
//TODO: check stack condition

class jsr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 39)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.label]
    }
    
    override func run(_ args: [Int]){
        super.run(args)
        for i in 5...9 {
            memory.stack.push(memory[Register(rawValue: i)!])
        }
        memory.stack.push(memory[.rPC])

        memory[.rPC] = label
    }
}

class ret: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 0, 40)
    }
    
    override var parameterTypes: [Parameters?] {
        return [nil]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[.rPC] = memory.stack.pop()!
        for i in stride(from: 9, through: 5, by: -1) {
            memory[Register(rawValue: i)!] = memory.stack.pop()!
        }
    }
}
