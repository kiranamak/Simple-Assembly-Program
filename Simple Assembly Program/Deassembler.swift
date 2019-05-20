//
//  Deassembler.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 5/15/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

class Deassembler {
    var commands: [Instruction]
    var pointer: Int
    var memory: Memory
    let st:[Int: String]
    
    init(memory: Memory, st: [Int: String]) {
        self.commands = [Instruction](repeating: Instruction(memory, 0, -1), count: 58)
        self.memory = memory
        let constants = Constants(memory: memory)
        for c in constants.commands {
            commands[c.code] = c
        }
        self.st = st
        self.pointer = memory[.rPC]
    }
    
    private func validCommand(_ code: Int) -> Bool {
        if code < 0 || code > commands.count {
            return false
        }
        return true
    }
    
    func run(start: Int, end: Int){
        pointer = start
        while pointer <= end { step() }
    }
    
    func step() {
        if !validCommand(memory[pointer]) {
            print("Invalid command code \(memory[pointer]) at location \(pointer)")
        }
        
        var result = "\t"
        
        if let ld = st[pointer] {
            print(ld, terminator: ": ")
            result = ""
        }
        
        let command = commands[memory[pointer]]
        pointer += 1
        result += command.name + " "
        
        for i in 0..<command.argCount {
            switch command.parameterTypes[i]! {
            case .int: result += String(memory[pointer]) + " "
            case .register: result += "r" + String(memory[pointer]) + " "
            case .label: result += st[memory[pointer]]! + " "
            default: print("Instruction requested invalid parameter type")
            }
            pointer += 1
        }
        print(result)
    }
}
