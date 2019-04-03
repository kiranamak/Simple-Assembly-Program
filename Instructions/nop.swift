//
//  nop.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 4/2/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

//Instructions: 56

class nop: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 0, 56)
    }
    
    override var parameterTypes: [Parameters?] {
        return [nil]
    }
    
    override func run(_ args: [Int]){
    }
}
