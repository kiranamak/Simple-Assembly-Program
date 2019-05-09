//
//  Assembler.swift
//  Simple Assembly Program
//
//  Created by Mattew Yao on 5/6/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

class Assembler{
    let text: String
    var tokens = [[Token]]()
    var errors = [String]()
    var symbolTable = [String : Int]()
    let paramDict: [Parameters : TokenType] = [.register : .Register, .int : .ImmediateInteger, .label : .Label]
    var bin = ""
    var startLn = 0
    var start = ""
    
    
    init(text: String){
        self.text = text
    }
    
    func tokenize(){
        let t = Tokenizer(fileText: text, commands: commands)
        t.createChunks()
        t.createTokens()
        tokens = t.matchTokens()
        //print(tokens)
    }
    
    func pass(){
        tokenize()
        var count = 0
        var line = 0
        while line < tokens.count{
            var i = 0
            while i < tokens[line].count{
                let token = tokens[line][i]
                switch token.type{
                case .LabelDefinition:
                    if token.stringValue! == start{
                        startLn = count
                    }else{
                        print("\(token.stringValue!) != \(start)")
                        var symbol = token.stringValue!
                        symbol.removeLast()
                        symbolTable[symbol] = count
                    }
                case .Instruction: count += 1
                case .Label:
                    if start == ""{start = token.stringValue! + ":"}
                    else{ count += 1  }
                case .Register: count += 1
                case .ImmediateString: count += token.stringValue!.count - 1
                case .ImmediateInteger: count  += 1
                case .ImmediateTuple: count += 5
                default: count += 0
                }
                i += 1
            }
            line += 1
        }
    }
    
    func assemble(){
        pass()
        var count = 0
        tokenize()
        var line = 0
        while line < tokens.count{
            var i = 0
            //print(tokens[line])
            while i < tokens[line].count{
                let token = tokens[line][i]
                switch token.type{
                case .Instruction: //Instruction
                    if !checkParams(command: getCommand(token.stringValue!)!, line: tokens[line], index: i){
                        errors.append("invalid parameters on line \(line)")
                    }
                    bin += String(getCommandCode(token.stringValue!)!) + " "
                    count += 1
                case .Label: //label
                    if token.stringValue! != start{
                        if let n = symbolTable[token.stringValue!]{
                            bin += String(n) + " "
                            count += 1
                        }else{ errors.append("invalid label on line \(line), label: \(token.stringValue!)")}
                    }
                    
                case .Register:  //Register
                    bin += String(token.stringValue!.last!) + " "
                    count += 1
                case .ImmediateString: //String
                    var stringValue = token.stringValue!
                    stringValue.removeFirst()
                    stringValue.removeLast()
                    bin += handleString(line: stringValue) + " "
                    count += stringValue.count + 1
                    print(token.stringValue! + "  " + handleString(line: stringValue))
                case .ImmediateInteger: //Integer
                    bin += String(token.intValue!) + " "
                    count += 1
                case .ImmediateTuple: //Tuple
                    bin += handleTuple(tuple: token.tupleValue!)
                    count += 5
                default: count += 0
                }
                
                i += 1
            }
            line += 1
        }
        bin = "\(count) \(startLn) \(bin)"
    }
    
    func checkParams(command: Instruction, line: [Token], index: Int)->Bool{
        for i in 0..<command.parameterTypes.count{
            if command.parameterTypes[i] == nil{ return true}
            if line[index + 1 + i].type != paramDict[command.parameterTypes[i]!]!{
                return false
            }
        }
        return true
    }
    
    func getCommand(_ command: String)-> Instruction?{
        for c in commands{
            if command == c.name{
                return c
            }
        }
        return nil
    }
    
    func getCommandCode(_ command:  String)-> Int?{
        if let c = getCommand(command){
            return c.code
        }else{
            return nil
        }
    }
    
    func handleString(line: String)->String{
        var bin = String(line.count)
        for c in line{
            //print(c)
            bin += " " + String(characterToUnicode(c))
        }
        return bin
    }
    
    func handleTuple(tuple : Tuple)-> String{
        var bin = ""
        bin += String(tuple.currentState) + " "
        bin += String(characterToUnicode(tuple.inputCharacter)) + " "
        bin += String(tuple.newState) + " "
        bin += String(characterToUnicode(tuple.outputCharacter)) + " "
        bin += tuple.direction == "r" ? "1 " : "0 "
        return bin
    }

    
}
