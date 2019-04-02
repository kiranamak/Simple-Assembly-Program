//
//  Instructions.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/28/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

enum Parameters {
    case int, register, label
}

enum InvalidParameterError: Error {
    case labelOutOfBounds(label: Int)
    case registerOutOfBounds(reg: Int)
}

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
    
    var parameterTypes: [Parameters?] {
        return [nil, nil]
    }
    
    func run(_ args: String) {
        let argsArray = splitStringIntoParts(args)
        run(argsArray)
    }
    
    private func validLabel(_ label: Int) throws {
        if label < 0 || label >= memory.getMemory().count  {
            throw InvalidParameterError.labelOutOfBounds(label: label)
        }
    }
    
    private func validRegister(_ reg: Int) throws {
        if reg < 0 || reg > 9 {
            throw InvalidParameterError.registerOutOfBounds(reg: reg)
        }
    }
    
    private func checkParams(_ params: [Int]) {
        for i in 0..<argCount {
            if parameterTypes[i] == .label {
                do {
                    try validLabel(params[i])
                } catch ( InvalidParameterError.labelOutOfBounds(let label) ) {
                    print("Invalid label \(label) is out of bounds of memory (0 - \(memory.getMemory().count - 1)")
                    fatalError("Invalid label")
                } catch {
                    print("Unexpected Error: \(error)")
                    fatalError("Unexpected label error")
                }
            }
            if parameterTypes[i] == .register {
                do {
                    try validRegister(params[i])
                } catch ( InvalidParameterError.registerOutOfBounds(let reg) ) {
                    print("Invalid register \(reg), must be 0 - 9")
                    fatalError("Invalid register")
                } catch {
                    print("Unexpected Error: \(error)")
                    fatalError("Unexpected register error")
                }
            }
        }
    }
    
    func run(_ args: [Int]) {
        checkParams(args)
        if name == "abstract" {
            fatalError("Instructions is an Abstract Class")
        }
    }
    
    var description: String {
        return name
    }
}
