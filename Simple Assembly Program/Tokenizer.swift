//
//  Tokenizer.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 4/24/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

class Tokenizer {
    let fileText: String
    var lines: [String]
    var chunks = [[String]]()
    var tokens = [[TokenType]]()
    let commands: [Instruction]
    
    
    init(fileText: String, commands: [Instruction]) {
        self.fileText = fileText
        self.lines = splitStringIntoLines(fileText)
        self.commands = commands
    }
    
    func createChunks() {
        chunks = [[String]](repeating: [""], count: lines.count)
        for i in 0..<lines.count {
            chunks[i] = chunker(lines[i])
        }
        populateTokens()
    }
    
    func populateTokens() {
        tokens = [[TokenType]](repeating: [TokenType.InvalidToken], count: chunks.count)
        for i in 0..<tokens.count {
            var count = 1
            if chunks[i].count > 1 { count = chunks[i].count }
            tokens[i] = [TokenType](repeating: TokenType.InvalidToken, count: count)
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
                chunk += "\""
                i += 1
                while chars[i] != "\"" && chars[i] != "\n" {
                    chunk += String(chars[i])
                    i += 1
                }
                chunk += "\""
                i += 1
            }
            // creates tuple
            else if chars[i] == "\\" {
                chunk += "\\"
                i += 1
                while chars[i] != "\\" && chars[i] != "\n" {
                    chunk += String(chars[i])
                    i += 1
                }
                chunk += "\\"
                i += 1
            }
            else if chars[i] == " " || chars[i] == "\t" { i += 1 }
            else {
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
   
    private func isLabelDefinition(_ chunk: String) -> Bool {
        if chunk.last! == ":" && isLabel(chunk.substring(to: chunk.count - 1)) { return true }
        return false
    }
    
    private func isDirective(_ chunk: String) -> Bool {
        if chunk.first! == "." {return true}
        return false
    }
    
    private func isEmpty(_ chunk: [String]) -> Bool {
        if chunk.count == 0 {
           print("isEmpty")
            return true
            
        }
        return false
    }
    private func isInstruction(_ chunk: String) -> Bool {
        for c in commands {
            if chunk == c.name { return true }
        }
        return false
    }
    private func isRegister(_ chunk: String) -> Bool {
        if chunk.count == 2 && chunk.first == "r" {
            if let n = Int(String(chunk.last!)) {
                if n >= 0 && n <= 9 { return true }
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
        return true
    }
    private func isLetter(_ char: Character) -> Bool {
        let unicode = characterToUnicode(char)
        if unicode >= 97 && unicode <= 122 { return true }
        return false
    }
    private func isImmediateString(_ chunk: String) -> Bool {
        if chunk.first! == "\"" { return true }
        return false
    }
    private func isImmediateInteger(_ chunk: String) -> Bool {
        if chunk.first! == "#" { return true }
        return false
    }
    private func isImmediateTuple(_ chunk: String) -> Bool {
        if chunk.first! == "\\" { return true }
        return false
    }
    
    func createTokens() {
        for l in 0..<chunks.count {
            if isEmpty(chunks[l]) { tokens[l][0] = .Empty }
            for c in 0..<chunks[l].count {
                let chunk = chunks[l][c]
                if isRegister(chunk) { tokens[l][c] = .Register }
                else if isDirective(chunk) { tokens[l][c] = .Directive }
                else if isInstruction(chunk) { tokens[l][c] = .Instruction }
                else if isImmediateString(chunk) { tokens[l][c] = .ImmediateString }
                else if isImmediateInteger(chunk) { tokens[l][c] = .ImmediateInteger }
                else if isImmediateTuple(chunk) { tokens[l][c] = .ImmediateTuple }
                else if isLabelDefinition(chunk) { tokens[l][c] = .LabelDefinition }
                else if isLabel(chunk) { tokens[l][c] = .Label }
                else { tokens[l][c] = .InvalidToken }
            }
        }
    }
    func matchTokens()->[[Token]]{
        var matchedTokens = [[Token]]()
        for line in 0..<chunks.count{
            matchedTokens.append([Token]())
            
            for i in 0..<chunks[line].count{
                let tokenType = tokens[line][i]
                
                if tokenType == .ImmediateTuple{
                    matchedTokens[line].append(Token(type: .ImmediateTuple, intValue: nil, stringValue: nil, tupleValue: parseTuple(tuple: chunks[line][i])))
                }
                else if tokenType == .ImmediateInteger{
                    var intValue = chunks[line][i]
                    intValue.removeFirst()
                    matchedTokens[line].append(Token(type: .ImmediateInteger, intValue: Int(intValue), stringValue: nil, tupleValue: nil))
                }
                else{
                    matchedTokens[line].append(Token(type: tokenType, intValue: nil, stringValue: chunks[line][i], tupleValue: nil))
                }
            }
        }
        return matchedTokens
        
    }
    
    func parseTuple(tuple: String)->Tuple?{
        let chars = Array(tuple)
        var parts = splitStringIntoParts(tuple)
        if !(parts.count == 5){ return nil}
        if (chars[0] == "\\" && chars.last == "\\"){
            parts[0].removeFirst()
            parts[4].removeLast()
        }else{ return nil}
        if Int(parts[0]) == nil  || Int(parts[2]) == nil{ return nil}
        if !Set(["r", "l"]).contains(parts[4]){ return nil}
        
        return Tuple(cs: Int(parts[0])!, ic: Character(parts[1]), ns: Int(parts[2])!, oc: Character(parts[3]), d: Character(parts[4]))
        
    }

}

struct Token: CustomStringConvertible{
    let type:  TokenType
    let intValue: Int?
    let stringValue: String?
    let tupleValue: Tuple?
    
    init(type: TokenType, intValue: Int?, stringValue: String?, tupleValue: Tuple?){
        self.type = type
        self.intValue = intValue
        self.stringValue = stringValue
        self.tupleValue = tupleValue
    }
    var description: String{
        var data = ""
        if let i = intValue{ data += String(i)}
        if let s = stringValue{ data += s}
        if let t = tupleValue{data += t.description}
        return type.rawValue + " data: " + data
    }
    
}

struct Tuple: CustomStringConvertible{
    let currentState: Int
    let inputCharacter : Character
    let newState: Int
    let outputCharacter: Character
    let direction: Character
    init(cs: Int, ic: Character, ns: Int, oc: Character, d: Character){
        currentState = cs
        inputCharacter = ic
        newState = ns
        outputCharacter = oc
        direction = d
    }
    var description: String{
        return "\(currentState) \(inputCharacter) \(newState) \(outputCharacter) \(direction)"
    }
}


enum TokenType: String {
    case Register = "Register" //
    case LabelDefinition = "LabelDefinition"//
    case Label = "Label"//
    case ImmediateString = "String" //
    case ImmediateInteger = "Integer" //
    case ImmediateTuple = "Tuple" //
    case Instruction = "Instruction"//
    case Directive = "Directive" 
    case InvalidToken = "Invalid"
    case Empty = "Empty"
}
