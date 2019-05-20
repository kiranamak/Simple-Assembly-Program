//
//  Tokenizer.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 4/24/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

enum TokenType: String {
    case Register = "Register"
    case LabelDefinition = "Label Definition"
    case Label = "Label"
    case ImmediateString = "String"
    case ImmediateInteger = "Integer"
    case ImmediateTuple = "Tuple"
    case Instruction = "Instruction"
    case Directive = "Directive"
    case InvalidToken = "Invalid"
    case Empty = "Empty"
}

class Tokenizer {
    let fileText: String
    var lines: [String]
    var chunks = [[String]]()
    var tokens = [[Token]]()
    let commands: [Instruction]
    var tokenValue: (Int?, String?, Tuple?) = (nil, nil, nil)
    
    init(fileText: String) {
        self.fileText = fileText
        self.lines = splitStringIntoLines(fileText)
        self.commands = Constants.rawCommands
    }
    
    func createChunks() {
        chunks = [[String]](repeating: [""], count: lines.count)
        for i in 0..<lines.count {
            chunks[i] = chunker(lines[i])
        }
        populateTokens()
    }
    
    func populateTokens() {
        tokens = [[Token]](repeating: [Token(.InvalidToken)], count: chunks.count)
        for i in 0..<tokens.count {
            var count = 1
            if chunks[i].count > 1 { count = chunks[i].count }
            tokens[i] = [Token](repeating: Token(.InvalidToken), count: count)
        }
    }
    
    func chunker(_ line: String) -> [String] {
        let chars = Array(line)
        var result = [String]()
        var chunk = ""
        var i = 0
        while i < chars.count {
            if chars[i] == ";" { return result }
            // creates string
            if chars[i] == "\"" {
                let result = handleGroup(chars: chars, index: i, isString: true)
                chunk += result.0
                i = result.1
            }
                // creates tuple
            else if chars[i] == "\\" {
                let result = handleGroup(chars: chars, index: i, isTuple: true)
                chunk += result.0
                i = result.1
            }
            else if chars[i] == " " || chars[i] == "\t" { i += 1 }
            else { //lowercase everything else
                while i < chars.count && chars[i] != " " {
                    chunk += String(chars[i]).lowercased()
                    i += 1
                }
            }
            if chunk != "" { result.append(chunk) }
            chunk = ""
        }
        return result
    }
    
    private func handleGroup(chars: [Character], index: Int, isString: Bool = false, isTuple: Bool = false) -> (String, Int) {
        var escapeKey: Character = "\""
        if isTuple { escapeKey = "\\" }
        var chunk = String(escapeKey)
        var i = index + 1
        while chars[i] != escapeKey && chars[i] != "\n" && chars[i] != ";" {
            chunk += String(chars[i])
            i += 1
        }
        i += 1
        return (chunk, i)
    }
    
    private func isLabelDefinition(_ chunk: String) -> Bool {
        if chunk.last! == ":" && isLabel(chunk.substring(to: chunk.count - 1)) { return true }
        return false
    }
    
    private func isDirective(_ chunk: String) -> Bool {
        if chunk.first! == "." {
            tokenValue.1 = chunk
            return true
        }
        return false
    }
    
    private func isEmpty(_ chunk: [String]) -> Bool {
        if chunk.count == 0 {
            return true
            
        }
        return false
    }
    private func isInstruction(_ chunk: String) -> Bool {
        for c in commands {
            if chunk == c.name {
                tokenValue.1 = c.name
                return true
            }
        }
        return false
    }
    private func isRegister(_ chunk: String) -> Bool {
        if chunk.count == 2 && chunk.first == "r" {
            if let n = Int(String(chunk.last!)) {
                if n >= 0 && n <= 9 {
                    tokenValue.0 = n
                    return true
                }
            }
        }
        return false
    }
    private func isLabel(_ chunk: String) -> Bool {
        let chars = Array(chunk)
        if !isLetter(chars[0]) {
            return false
        }
        for c in 1..<chars.count {
            if !isLetter(chars[c]) && Int(String(chars[c])) == nil {
                return false
            }
        }
        tokenValue.1 = chunk
        return true
    }
    private func isLetter(_ char: Character) -> Bool {
        let unicode = characterToUnicode(char)
        if unicode >= 97 && unicode <= 122 { return true }
        return false
    }
    private func isImmediateString(_ chunk: String) -> Bool {
        if chunk.first! == "\"" {
            tokenValue.1 = chunk.substring(from: 1)
            return true
        }
        return false
    }
    private func isImmediateInteger(_ chunk: String) -> Bool {
        if chunk.first! == "#", let i = Int(chunk.substring(from: 1)){
            tokenValue.0 = i
            return true
        }
        return false
    }
    private func isImmediateTuple(_ chunk: String) -> Bool {
        let tuple = splitStringIntoParts(chunk.substring(from: 1))
        if chunk.first! == "\\", let t = makeTuple(tuple) {
            tokenValue.2 = t
            return true
        }
        return false
    }
    
    func createTokens() {
        createChunks()
        for l in 0..<chunks.count {
            if isEmpty(chunks[l]) { tokens[l][0] = Token(.Empty) }
            for c in 0..<chunks[l].count {
                let chunk = chunks[l][c]
                if isRegister(chunk) { tokens[l][c] = Token(.Register, int: tokenValue.0) }
                else if isDirective(chunk) { tokens[l][c] = Token(.Directive, string: tokenValue.1) }
                else if isInstruction(chunk) { tokens[l][c] = Token(.Instruction, string: tokenValue.1) }
                else if isImmediateString(chunk) { tokens[l][c] = Token(.ImmediateString, string: tokenValue.1) }
                else if isImmediateInteger(chunk) { tokens[l][c] = Token(.ImmediateInteger, int: tokenValue.0) }
                else if isImmediateTuple(chunk) { tokens[l][c] = Token(.ImmediateTuple, tuple: tokenValue.2) }
                else if isLabelDefinition(chunk) { tokens[l][c] = Token(.LabelDefinition, string: tokenValue.1) }
                else if isLabel(chunk) { tokens[l][c] = Token(.Label, string: tokenValue.1) }
                else { tokens[l][c] = Token(.InvalidToken) }
            }
        }
    }
    
}
