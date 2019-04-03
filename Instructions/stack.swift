//
//  stack.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 4/2/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

//Instructions: 41-43

class push: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 41)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.register]
    }
    
    override func run(_ args: [Int]){
        super.run(args)
        if memory.stack.isFull() {
            memory[.rST] = 1
            print("Stack overflow, attempted push in push instruction to full stack")
            fatalError("Stack Overflow")
        }
        memory.stack.push(memory[r1!])
    }
}

class pop: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 42)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.register]
    }
    
    override func run(_ args: [Int]){
        super.run(args)
        if memory.stack.isEmpty() {
            memory[.rST] = 2
            print("Stack empty, attempted pop in pop instruction on empty stack")
            fatalError("Stack Empty")
        }
        memory[r1!] = memory.stack.pop()!
    }
}

class stackc: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 43)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.register]
    }
    
    override func run(_ args: [Int]){
        super.run(args)
        if memory.stack.isFull() { memory[.rST] = 1 }
        else if memory.stack.isEmpty() { memory[.rST] = 2 }
        else { memory[.rST] = 0 }
    }
}



