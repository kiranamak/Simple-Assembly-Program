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
    case zero = 0, one, two, three, four, five, six, seven, eight, nine
    case compare = 10
}

class Memory {
    var memory: [Int]
    var registers = [Int](repeating: 0, count: 11)
    var program = [Int]()
    
    init(binary: [Int]) {
        self.memory = binary
        for i in 2..<(binary[0] + 2) {
            program.append(binary[i])
        }
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
    
    subscript(_ i: Int, binary: Bool) -> Int {
        get { return memory[i] }
        set(v) { memory[i] = v }
    }
    
    subscript(_ r: Register) -> Int {
        get { return registers[r.rawValue] }
        set(v) { registers[r.rawValue] = v }
    }
}
