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
    var pointer: Int {
        return memory[Register.rPC]
    }
    var memory: Memory
    
    init(commands: [Instruction], memory: Memory) {
        self.commands = [Instruction](repeating: Instruction(memory, 0, -1), count: 58)
        for c in commands {
            self.commands[c.code] = c
        }
        self.memory = memory
    }
    
    static func setHalt(_ halt: Bool) {
        VM.halt = halt
    }
    
    func run(){
        
        while !VM.halt {
            let command = commands[memory[pointer]]
            memory[.rPC] += 1
            var args = ""
            for _ in 0..<command.argCount {
                args += String(memory[pointer]) + " "
                memory[.rPC] += 1
            }
            command.run(args)
        }
    }
}
