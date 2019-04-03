//
//  jsr-ret.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 4/2/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

//Instructions: 39-40

class jsr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 39)
    }
    
    override var parameterTypes: [Parameters?] {
        return [.register]
    }
    
    override func run(_ args: [Int]){
        super.run(args)
        for i in 5...9 {
            let push1 = push(memory)
            push1.run([Register(rawValue: i)!.rawValue])
        }
        let push2 = push(memory)
        push2.run([Register.rPC.rawValue])

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
    
    override func run(_ args: [Int]){
        super.run(args)
        let pop1 = pop(memory)
        pop1.run([Register.rPC.rawValue])
        for i in 5...9 {
            let pop2 = pop(memory)
            pop2.run([Register(rawValue: i)!.rawValue])
        }
    }
}
