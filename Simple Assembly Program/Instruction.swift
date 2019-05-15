//
//  Instructions.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/28/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

enum ParameterType: String {
    case int = "Integer", register = "Register", label = "Label", string = "String", tuple = "Tuple"
}

class Instruction: AssemblyInstruction {
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
    
    init (_ argCount: Int, _ code: Int) {
        self.memory = Memory(binary: [0])
        self.argCount = argCount
        self.code = code
        
        let thisType = type(of: self)
        if thisType == Instruction.self { self.name = "Abstract" }
        else { self.name = String(describing: thisType) }
    }
    
    /*func setMemory(_ memory: Memory) {
        self.memory = memory
    }*/
    
    var parameterTypes: [ParameterType?] {
        return [nil, nil, nil]
    }
    
    func run(_ args: String) {
        let argsArray = splitStringIntoInts(args)
        run(argsArray)
    }
    
    private func validLabel(_ label: Int) -> Bool {
        if label < 0 || label >= memory.getMemory().count  {
            return false
        }
        return true
    }
    
    private func validRegister(_ reg: Int) -> Bool {
        if reg < 0 || reg > 9 {
            return false
        }
        return true
    }
    
    private func createLabel(_ label: Int) {
        if !validLabel(label) {
            print("Invalid label \(label) is out of bounds of memory (0 - \(memory.getMemory().count - 1)")
            fatalError("Invalid label")
        }
        self.label = label
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
        if !validRegister(reg) {
            print("Invalid register \(reg), must be 0 - 9")
            fatalError("Invalid register")
        }
        setRegister(reg)
    }
    
    private func createInt(_ int: Int) {
        self.int = int
    }
    
    private func checkParams(_ param: Int, _ i: Int) {
        switch parameterTypes[i]! {
        case .label: createLabel(param)
        case .register: createRegister(param)
        case .int: createInt(param)
        default: print("An incorrect parameter type was reached in Instruction checkParams")
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
    
    func checkDivisionByZero(_ i: Int) {
        if i == 0 {
            print("Attempted division by zero")
            fatalError("Division by zero")
        }
    }
    
    var description: String {
        return name
    }
}
