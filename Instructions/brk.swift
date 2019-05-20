//
//  brk.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 5/15/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

//Instructions: 52

class brk: Instruction {
    
    init(_ memory: Memory) {
        super.init(memory, 0, 52)
    }
    
    init() {
        super.init(0, 52)
    }
    
    override var parameterTypes: [ParameterType?] {
        return [nil]
    }
    
    override func run(_ args: [Int]){
    }
}
