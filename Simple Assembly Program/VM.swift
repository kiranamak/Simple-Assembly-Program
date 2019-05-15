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
    
    init(memory: Memory) {
        self.commands = [Instruction](repeating: Instruction(memory, 0, -1), count: 58)
        self.memory = memory
        let constants = Constants(memory: memory)
        for c in constants.commands {
            self.commands[c.code] = c
        }
    }
    
    static func setHalt(_ halt: Bool) {
        VM.halt = halt
    }
    
    private func validCommand(_ code: Int) -> Bool {
        if code < 0 || code > commands.count {
            return false
        }
        return true
    }
    
    func run(){
        while !VM.halt {
            if !validCommand(memory[pointer]) {
                print("Invalid command code \(memory[pointer]) at location \(pointer)")
            }
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
