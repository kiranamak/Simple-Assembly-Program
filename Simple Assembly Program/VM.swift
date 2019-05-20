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
    var debugger: Debugger? = nil
    var breakPointsEnabled = true
    let filePath: String
    var breakPoints = Set<Int>()
    
    init(memory: Memory, filePath: String) {
        self.filePath = filePath
        self.commands = [Instruction](repeating: Instruction(memory, 0, -1), count: 58)
        self.memory = memory
        let constants = Constants(memory: memory)
        for c in constants.commands {
            commands[c.code] = c
        }
        setBreakPoints()
        debugger = Debugger(filePath: filePath, vm: self)
        
    }
    
    private func setBreakPoints() {
        breakPoints.insert(memory.getProgramStart())
        for i in 0..<memory.program.count {
            if memory[i] == 52 { breakPoints.insert(i)}
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
    
    func enableBreakPoints() { breakPointsEnabled = true }
    
    func disableBreakPoints() { breakPointsEnabled = false }
    
    func run(){
        if breakPointsEnabled {
            debugger!.enterDebugger()
        }
        execute()
    }
    
    func execute() {
        while !VM.halt {
            step()
        }
    }
    
    func step(){
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
        
        if breakPointsEnabled && breakPoints.contains(memory[.rPC]) {
            debugger!.enterDebugger()
        }
    }
}
