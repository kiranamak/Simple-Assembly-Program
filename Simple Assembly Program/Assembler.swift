//
//  Assembler.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 5/4/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

class Assembler {
    var lst = ""
    var binFile = ""
    var stFile = ""
    var binary = [Int](repeating: 0, count: 10000)
    var pointer = 0
    var start = ""
    let fileText: String
    let commands: [Instruction]
    let directives: [AssemblyDirective]
    let tokens: [[Token]]
    let lines: [String]
    var symbols = [String: Int]()
    var numberErrors = 0
    let maxBinary = 23
    
    init(_ fileText: String) {
        self.fileText = fileText
        self.commands = Constants.rawCommands
        self.directives = Constants.directives
        let tk = Tokenizer(fileText: fileText)
        self.lines = tk.lines
        tk.createTokens()
        self.tokens = tk.tokens
    }
    
    func pass(secondPass: Bool = false) {
        lst = ""
        binary = [Int](repeating: 0, count: 10000)
        pointer = 0
        for l in 0..<tokens.count {
            if !secondPass {
                lst += lines[l] + "\n"
                checkLineFormat(l)
            } else {
                var bin = ""
                let p = pointer
                checkLineFormat(l)
                bin += "\(p): "
                var i = 1
                while i <= 4 && i <= (pointer - p) {
                    bin += "\(binary[p + i - 1]) "
                    i += 1
                }
                lst += fit(bin, maxBinary) + lines[l] + "\n"
            }
        }
    }
    
    func run() -> Int {
        pass()
        for (s, l) in symbols {
            if l == -1 {
                lst += String.addError(AssemblyError.NoSymbol.rawValue + String(l))
                numberErrors += 1
            }
            stFile += "\(s) \(l)\n"
        }
        if numberErrors != 0 {return numberErrors }
        
        pass(secondPass: true)
        binFile += String(pointer) + "\n" + String(symbols[start]!) + "\n"
        for b in 0..<pointer {
            binFile += String(binary[b]) + "\n"
        }
        return numberErrors
    }
    
    func checkLineFormat(_ line: Int ) {
        let tLine = tokens[line]
        if tLine[0].type == .Empty { return }
        if tLine[0].type == .LabelDefinition {
            defineLabel(tLine[0].string!)
            if tLine[1].type == .Directive || tLine[1].type == .Instruction {
                identifyAssemblyInstruction(Array(tLine[1...]))
            } else {
                lst += String.addError(AssemblyError.NoInstructionDirective.rawValue)
                numberErrors += 1
            }
        } else if tLine[0].type == .Directive || tLine[0].type == .Instruction {
            identifyAssemblyInstruction(tLine)
        } else {
            lst += String.addError(AssemblyError.NoInstructionDirective.rawValue)
            numberErrors += 1
        }
    }
    
    func identifyAssemblyInstruction(_ tLine: [Token]) {
        let name = tLine[0].string!
        for c in commands {
            if name == c.name {
                binary[pointer] = c.code
                pointer += 1
                checkParams(c, tLine)
            }
        }
        for d in directives {
            if name == d.name {
                checkParams(d, tLine)
            }
        }
    }
    
    func checkParams(_ c: AssemblyInstruction, _ tLine: [Token]) {
        let params = c.parameterTypes
        //has right number of arguments on line
        if (tLine.count - 1) != c.argCount {
            lst += String.addError(AssemblyError.InvalidLine.rawValue)
            numberErrors += 1
        }
        for i in 1..<tLine.count{
            if let p = params[i - 1] {
        // has correct parameter types
            if tLine[i].type.rawValue != p.rawValue {
                lst += String.addError(AssemblyError.InvalidInstructionParams.rawValue + c.name)
                numberErrors += 1
                pointer += 1
            } else {
        // fills in binary
                switch p {
                case .register: binary[pointer] = tLine[i].int!
                    pointer += 1
                case .int: handleInt(token: tLine[i], asmInst: c)
                case .label: handleLabel(token: tLine[i], asmInst: c)
                case .string: handleString(tLine[i])
                case .tuple: handleTuple(tLine[i])
                }
            }
        }
        }
    }
    
    private func handleString(_ token: Token) {
        binary[pointer] = token.string!.count
        pointer += 1
        for c in token.string! {
            binary[pointer] = characterToUnicode(c)
            pointer += 1
        }
    }
    
    private func handleTuple(_ token: Token) {
        for e in token.tuple!.iterableTuple {
            binary[pointer] = e
            pointer += 1
        }
    }
    
    private func handleLabel(token: Token, asmInst c: AssemblyInstruction) {
        if c.name == ".start" {
            start = token.string!
            return
        }
        binary[pointer] = (symbols[token.string!] != nil ? symbols[token.string!]! : -1)
        pointer += 1
    }
    
    private func handleInt(token: Token, asmInst c: AssemblyInstruction) {
        if c.name == ".allocate" {
            pointer += token.int!
            return
        }
        binary[pointer] = token.int!
        pointer += 1
    }
    
    private func defineLabel(_ label: String) {
        symbols[label] = pointer
    }
}

extension String {
    static func addError(_ error: String) -> String{
        let errorString = ".................."
        return "\n" + errorString + error + "\n"
    }
}

enum AssemblyError: String  {
    case NoInstructionDirective = "No instruction or directive on line"
    case InvalidLine = "Invalid line"
    case InvalidInstructionParams = "Invalid parameter type for instruction "
    case InvalidDirectiveParams = "Invalid parameter type for directive "
    case InvalidToken = "Invalid token"
    case InvalidTuple = "Invalid tuple"
    case NoSymbol = "No definition for symbol "
    case InvalidDirective = "Invalid directive "
    case InvalidInstruction = "Invalid instruction "
}

