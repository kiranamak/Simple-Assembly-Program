//
//  read.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 4/3/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

class readi: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 2, 48)
    }
    
    override var parameterTypes: [Parameters?] {
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
