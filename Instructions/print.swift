//
//  print.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/28/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

//Instructions: 49

class printi: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 1, 49)
    }
    
    init() {
        super.init(1, 49)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [.register]
    }
    
    override func run(_ args: [Int]){
        super.run(args)
        print(memory[r1!], terminator: "")
    }
}

