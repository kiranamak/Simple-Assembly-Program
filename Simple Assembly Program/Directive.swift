//
//  Directive.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 5/6/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

protocol AssemblyInstruction: CustomStringConvertible {
    var argCount: Int { get }
    var name: String { get }
    
    var parameterTypes: [ParameterType?] { get }
}

class AssemblyDirective: AssemblyInstruction {
    let argCount: Int
    let name: String
    
    init (_ argCount: Int) {
        self.argCount = argCount
        
        let thisType = type(of: self)
        if thisType == Instruction.self { self.name = "Abstract" }
        else { self.name = "." + String(describing: thisType) }
    }
    
    var parameterTypes: [ParameterType?] {
        return [nil]
    }
    
    var description: String {
        return name
    }
}

class start: AssemblyDirective {
    
    init() { super.init(1) }
    override var parameterTypes: [ParameterType?] {
        return [.label]
    }
    
}

class end: AssemblyDirective {
    init() { super.init(0) }
    override var parameterTypes: [ParameterType?] {
        return [nil]
    }
}

class integer: AssemblyDirective {
    init() { super.init(1) }
    override var parameterTypes: [ParameterType?] {
        return [.int]
    }
}

class string: AssemblyDirective {
    init() { super.init(1) }
    override var parameterTypes: [ParameterType?] {
        return [.string]
    }
}

class tuple: AssemblyDirective {
    init() { super.init(1) }
    override var parameterTypes: [ParameterType?] {
        return [.tuple]
    }
}

class allocate: AssemblyDirective {
    init() { super.init(1) }
    override var parameterTypes: [ParameterType?] {
        return [.int]
    }
}
