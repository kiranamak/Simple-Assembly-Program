//
//  printi.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/28/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

class printi: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 49, name: "printi")
    }
    
    override var parameterTypes: [Parameters?] {
        return [.int, nil]
    }
    
    override func run(_ args: [Int]){
        super.run(args)
        let r = Register(rawValue: args[0])
        print(memory[r!], terminator: "")
    }
}

