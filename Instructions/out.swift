//
//  out.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/28/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

//Instructions: 44-47, 55

class outci: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 44)
    }
    
    init() {
        super.init(1, 44)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.int]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        print(unicodeValueToCharacter(int), terminator: "")
    }
}

class outcr: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 45)
    }
    
    init() {
        super.init(1, 45)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        let charVal = memory[r1!]
        print(unicodeValueToCharacter(charVal), terminator: "")
    }
}

class outcx: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 46)
    }
    
    init() {
        super.init(1, 46)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        let charVal = memory[memory[r1!]]
        print(unicodeValueToCharacter(charVal), terminator: "")
    }
}

class outcb: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 47)
    }
    
    init() {
        super.init(2, 47)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.register, .register]
    }
    
    override func run(_ args: [Int]) {
        super.run(args)
        for i in 0..<memory[r2!] {
            let charVal = memory[memory[r1!] + i]
            print(unicodeValueToCharacter(charVal), terminator: "")
        }
    }
}

class outs: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 55)
    }
    
    init() {
        super.init(1, 55)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.label]
    }
    
    override func run(_ args: [Int]){
        super.run(args)
        var str = ""
        for i in 1...memory[label] {
            let charVal = memory[label + i]
            str += String(unicodeValueToCharacter(charVal))
        }
        print(str, terminator: "")
    }
}

