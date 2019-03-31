//
//  Instructions.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/28/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation


class Instruction: CustomStringConvertible {
    let argCount: Int
    let code: Int
    let memory: Memory
    let name: String
    
    init (_ memory: Memory, _ argCount: Int, _ code: Int, name: String = "abstract") {
        self.memory = memory
        self.argCount = argCount
        self.code = code
        self.name = name
    }

    func splitStringIntoParts(_ expression: String) -> [Int] {
        return expression.split{$0 == " "}.map{ Int($0)! }
    }
    
    func run(_ args: String) {
        let argsArray = splitStringIntoParts(args)
        run(argsArray)
    }
    
    func run(_ args: [Int]) {
        fatalError("Instructions is an Abstract Class")
    }
    
    var description: String {
        return name
    }
}
