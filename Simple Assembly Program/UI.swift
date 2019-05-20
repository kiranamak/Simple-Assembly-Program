//
//  UI.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 5/8/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

class UI {
    var path = ""
    
    func getHelpMessage() -> String {
        return """
        SAP Help:
        asm <program name> - assemble the specified program
        run <program name> - run the specified program
        path <path specification> - set the path for the SAP program directory
        include final / but not name of file. SAP file must have an extension of .txt
        printlst <program name> - print listing file for the specified program
        printbin <program name> - print binary file for the specified program
        printsym <program name> - print symbol table for the specified program
        quit  - terminate SAP program
        help  - print help table\n
        """
    }
    
    func run() {
        print("Welcome to SAP!\n\n")
        print(getHelpMessage())
        print("Enter option...", terminator: "")
        var input = splitStringIntoParts(readLine()!)
        if input.count == 0 { input.append("empty") }
        while input[0] != "quit" {
            switch input[0] {
            case "asm": asm(input)
            case "run": run(input)
            case "path": setPath(input)
            case "printlst": printlst(input)
            case "printbin": printbin(input)
            case "printsym": printsym(input)
            case "help": print(getHelpMessage())
            default: print("Invalid command, type help for a list of commands")
            }
            print("\nEnter option...", terminator: "")
            input = splitStringIntoParts(readLine()!)
        }
    }
    
    func asm(_ line: [String]) {
        if line.count != 2 { print("Error: incorrect parameters for asm") }
        let filePath = path + line[1]
        print("Assembling file: \(filePath)")
        let fileText = readTextFile(filePath + ".txt")
        if let e = fileText.0 { print(e); return }
        let assembler = Assembler(fileText.1!)
        let result = assembler.run()
        
        writeTextFile(filePath + ".lst", data: assembler.lst)
        writeTextFile(filePath + ".sym", data: assembler.stFile)
        if result != 0 {
            print("Assembled with \(result) errors, see lst file for more information")
        } else {
            print("Assembly successful")
        }
        writeTextFile(filePath + ".bin", data: assembler.binFile)
    }
    
    func run(_ line: [String]) {
        if line.count != 2 { print("Error: incorrect parameters for asm") }
        let filePath = path + line[1]
        print("Running file: \(filePath)")
        let e = readTextFile(filePath + ".bin")
        if e.0 != nil { print(e.0!); return }
        else {
            let binary = splitStringIntoInts(e.1!)
            let vm = VM(memory: Memory(binary: binary), filePath: filePath)
            vm.run()
        }
    }
    
    func setPath(_ line: [String]) {
        if line.count != 2 { print("Error: incorrect parameters for path") }
        path = line[1]
    }
    
    func printlst(_ line: [String]) {
        if line.count != 2 { print("Error: incorrect parameters for printlst") }
        let e = readTextFile(path + line[1] + ".lst")
        if e.0 != nil { print(e.0!); return }
        else { print(e.1!) }
    }
    
    func printbin(_ line: [String]) {
        if line.count != 2 { print("Error: incorrect parameters for printbin") }
        let e = readTextFile(path + line[1] + ".bin")
        if e.0 != nil { print(e.0!); return }
        else { print(e.1!) }
    }
    
    func printsym(_ line: [String]) {
        if line.count != 2 { print("Error: incorrect parameters for printsym") }
        let e = readTextFile(path + line[1] + ".sym")
        if e.0 != nil { print(e); return }
        else { print(e.1!) }
    }
}
