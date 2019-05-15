//
//  File.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/26/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

//TODO: check register enum

import Foundation

enum Register: Int {
    case r0 = 0, r1, r2, r3, r4, r5, r6, r7, r8, r9
    case rCP = 10
    case rPC = 11
    case rST = 12
}

class Memory {
    var memory = [Int](repeating: 0, count: 10000)
    var registers = [Int](repeating: 0, count: 13)
    var program = [Int]()
    var stack = Stack(size: 200, initial: 0)
    
    
    init(binary: [Int]) {
        self.memory = binary
        //print(binary.count)
        for i in 2..<(binary[0] + 2) {
            program.append(binary[i])
        }
        registers[Register.rPC.rawValue] = getProgramStart()
    }
    
    func getMemory() -> [Int] {
        return memory
    }
    
    func getRegisters() -> [Int] {
        return registers
    }
    
    subscript(_ i: Int) -> Int {
        get { return program[i] }
        set(v) { program[i] = v }
    }
    
    func getProgramLength() -> Int {
        return memory[0]
    }
    
    func getProgramStart() -> Int {
        return memory.count >= 2 ? memory[1] : 0
    }
    
    subscript(_ r: Register) -> Int {
        get { return registers[r.rawValue] }
        set(v) { registers[r.rawValue] = v }
    }
}
