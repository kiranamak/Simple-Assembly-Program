//
//  read.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 4/3/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

//Instructions: 48, 50-51

class readi: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 48)
    }
    
    init() {
        super.init(2, 48)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.register, .register]
    }
    
    override func run(_ args: [Int]){
        super.run(args)
        let read = readLine()
        if let line = read {
            let input = splitStringIntoParts(line)
            guard input.count == 1 else {
                print("Expected one int but received \(input.count) instead")
                memory[r2!] = -1
                return
            }
            guard let int = Int(input[0]) else {
                print("Expected an int but received \(input[0]) instead")
                memory[r2!] = -2
                return
            }
            memory[r1!] = int
            memory[r2!] = 0
            return
        }
        print("No input given")
        return
    }
}

class readc: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 50)
    }
    
    init() {
        super.init(1, 50)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.register]
    }
    
    override func run(_ args: [Int]){
        super.run(args)
        let read = readLine()
        if let line = read {
            let input = Array(splitStringIntoParts(line))
            guard input.count == 1 && input[0].count == 1 else {
                print("Expected one character but received \(line) instead")
                return
            }
            memory[r1!] = characterToUnicode(Character(line))
            return
        }
        print("No input given")
        return
    }
}

class readln: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 51)
    }
    
    init() {
        super.init(2, 51)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.label, .register]
    }
    
    override func run(_ args: [Int]){
        super.run(args)
        let read = readLine()
        if let line = read {
            for i in 0..<line.count {
                memory[label + i] = characterToUnicode(Character(line.substring(with: i..<i + 2)))
            }
            memory[r1!] = line.count
            return
        }
        print("No input given")
        return
    }
}

