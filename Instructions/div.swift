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
    
    override var parameterTypes: [Parameters?] {
        return [.int, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[r1!] /= int
        
    }
}

class divrr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 25)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.register, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[r2!] /= memory[r1!]
    }
}

class divmr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 26)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.label, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[r1!] /= memory[label]
    }
}

class divxr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 27)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.register, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        memory[r2!] /= memory[memory[r1!]]
    }
}
