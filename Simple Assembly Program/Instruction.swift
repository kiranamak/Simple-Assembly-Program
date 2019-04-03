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
    
    var r1: Register? = nil
    var r2: Register? = nil
    var r3: Register? = nil
    var label = 0
    var int = 0
    
    init (_ memory: Memory, _ argCount: Int, _ code: Int) {
        self.memory = memory
        self.argCount = argCount
        self.code = code
        
        let thisType = type(of: self)
        if thisType == Instruction.self { self.name = "Abstract" }
        else { self.name = String(describing: thisType) }
    }
    
    var parameterTypes: [Parameters?] {
        return [nil, nil, nil]
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
    
    private func createLabel(_ label: Int) {
        do {
            try validLabel(label)
            self.label = label
        } catch ( InvalidParameterError.labelOutOfBounds(let l) ) {
            print("Invalid label \(l) is out of bounds of memory (0 - \(memory.getMemory().count - 1)")
            fatalError("Invalid label")
        } catch {
            print("Unexpected Error: \(error)")
            fatalError("Unexpected label error")
        }
    }
    
    private func setRegister(_ reg: Int) {
        let rVal = Register(rawValue: reg)
        if r1 == nil {
            r1 = rVal
            return
        } else if r2 == nil {
            r2 = rVal
            return
        } else {
            r3 = rVal
            return
        }
    }
    
    private func createRegister(_ reg: Int) {
        do {
            try validRegister(reg)
            setRegister(reg)
        } catch ( InvalidParameterError.registerOutOfBounds(let r) ) {
            print("Invalid register \(r), must be 0 - 9")
            fatalError("Invalid register")
        } catch {
            print("Unexpected Error: \(error)")
            fatalError("Unexpected register error")
        }
    }
    
    private func createInt(_ int: Int) {
        self.int = int
    }
    
    private func checkParams(_ param: Int, _ i: Int) {
        switch parameterTypes[i]! {
        case .label: createLabel(param)
        case .register: createRegister(param)
        case .int: createInt(param)
        }
    }
    
    private func reset() {
        r1 = nil
        r2 = nil
        r3 = nil
    }
    
    func run(_ args: [Int]) {
        reset()
        for i in 0..<argCount {
            checkParams(args[i], i)
        }
        
        if name == "abstract" {
            fatalError("Instructions is an Abstract Class")
        }
    }
    
    var description: String {
        return name
    }
}
