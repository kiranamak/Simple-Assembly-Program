//
//  VM.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/26/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation


class VM {
    var commands: [Instruction]
    static var halt = false
    static var pointer = 0
    var memory: Memory
    
    init(commands: [Instruction], memory: Memory) {
        self.commands = [Instruction](repeating: Instruction(memory, 0, -1), count: 58)
        for c in commands {
            self.commands[c.code] = c
        }
        VM.pointer = binary[1]
        self.memory = memory
    }
    
    static func setHalt(_ halt: Bool) {
        VM.halt = halt
    }
    
    static func setPointer(_ pointer: Int) {
        VM.pointer = pointer
    }
    
    func run(){
        let startPointer = binary[1]
        VM.pointer = startPointer
        
        while !VM.halt {
            let command = commands[memory[VM.pointer]]
            VM.pointer += 1
            var args = ""
            for _ in 0..<command.argCount {
                args += String(memory[VM.pointer]) + " "
                VM.pointer += 1
            }
            command.run(args)
        }
    }
}
