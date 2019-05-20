//
//  Debugger.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 5/15/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

class Debugger{
    var st = [String: Int]()
    var it = [Int: String]()
    var vm: VM
    let filePath: String
    
    init(filePath: String, vm: VM) {
        self.vm = vm
        self.filePath = filePath
        let binary = readTextFile(filePath + ".bin")
        if binary.0 != nil {
            print(binary.0!)
            return
        }
        
        let symFile = readTextFile(filePath + ".sym")
        if symFile.0 != nil { print(symFile.0!); return }
        let symbols = splitStringIntoLines(symFile.1!)
        for sym in symbols {
            let s = splitStringIntoParts(sym)
            st[s[0]] = Int(s[1])!
            it[Int(s[1])!] = s[0]
        }
    }
    
    func enterDebugger() {
        print("Sdb (\(vm.pointer), \(vm.memory[vm.pointer]))> ", terminator: "")
        var input = splitStringIntoParts(readLine()!)
        if input.count == 0 { input.append("empty") }
        while input[0] != "exit"{
            let params = (input.count > 1 ? Array(input[1...]) : [String]())
            switch input[0] {
            case "setbk": setbk(params)
            case "rmbk": rmbk(params)
            case "clrbk": clrbk(params)
            case "disbk": disbk(params)
            case "enbk": enbk(params)
            case "pbk": pbk(params)
            case "preg": preg(params)
            case "wreg": wreg(params)
            case "wpc": wpc(params)
            case "pmem": pmem(params)
            case "deas": deas(params)
            case "wmem": wmem(params)
            case "pst": pst(params)
            case "g": g(params)
            case "s": s(params)
            case "help": helpMessage()
            default: print("Invalid command, type help for a list of commands")
            }
            if !VM.halt {
                print("Sdb (\(vm.pointer), \(vm.memory[vm.pointer]))> ", terminator: "")
                input = splitStringIntoParts(readLine()!)
            } else { return }
        }
    }
    
    private func setbk(_ input: [String]) {
        if input.count != 1 { print("Incorrect parameters for rmbk"); return }
        if let a = parseAddress(input[0]) {
            vm.breakPoints.insert(a)
        }
    }
    
    private func rmbk(_ input: [String]) {
        if input.count != 1 { print("Incorrect parameters for rmbk"); return }
        if let a = parseAddress(input[0]) {
            vm.breakPoints.remove(a)
        }
    }
    
    private func clrbk(_ input: [String]) {
        if input.count != 0 { print("Incorrect parameters for clrbk"); return }
        vm.breakPoints.removeAll()
    }
    
    private func enbk(_ input: [String]) {
        if input.count != 0 { print("Incorrect parameters for enbk"); return }
        vm.enableBreakPoints()
    }
    
    private func disbk(_ input: [String]) {
        if input.count != 0 { print("Incorrect parameters for disbk"); return }
        vm.disableBreakPoints()
    }
    
    private func pbk(_ input: [String]) {
        if input.count != 0 { print("Incorrect parameters for pbk"); return }
        print("Break points:")
        for i in vm.breakPoints {
            let label: String = (it[i] != nil ? it[i]! : "")
            print("\t\(i):  \(label)")
        }
    }
    
    private func preg(_ input: [String]) {
        if input.count != 0 { print("Incorrect parameters for preg"); return }
        print("Registers: ")
        for reg in 0..<vm.memory.registers.count {
            if reg >= 0 && reg <= 9 {
                print("r\(reg):\t\(vm.memory[Register(rawValue: reg)!])")
            }
            if reg == 11 {
                print(".rPC:\t\(vm.memory[Register(rawValue: reg)!])")
            }
        }
    }
    
    private func wreg(_ input: [String]) {
        if input.count != 2 { print("Incorrect parameters for wreg"); return }
        if let reg = parseRegister(input[0]), let value = parseInt(input[1]) {
            vm.memory[reg] = value
        }
    }
    
    private func wpc(_ input: [String]) {
        if input.count != 1 { print("Incorrect parameters for wpc"); return }
        if let i = parseInt(input[0]) {
            vm.memory[.rPC] = i
        }
    }
    
    private func pmem(_ input: [String]) {
        if input.count != 2 { print("Incorrect parameters for pmem"); return }
        print("Memory dump: ")
        if let start = parseAddress(input[0]), let end = parseAddress(input[1]) {
            for m in start..<end { print("\t\(m):  \(vm.memory[m])") }
        }
    }
    
    private func deas(_ input: [String]) {
        if input.count != 2 { print("Incorrect parameters for wmem"); return }
        let deassembler = Deassembler(memory: vm.memory, st: it)
        if let start = parseAddress(input[0]), let end = parseAddress(input[1]) {
            deassembler.run(start: start, end: end)
        }
    }
    
    private func wmem(_ input: [String]) {
        if input.count != 2 { print("Incorrect parameters for wmem"); return }
        if let a = parseAddress(input[0]), let i = parseInt(input[1]) {
            vm.memory[a] = i
        }
    }
    
    private func pst(_ input: [String]) {
        if input.count != 0 { print("Incorrect parameters for pst"); return }
        print("Symbol table:")
        for (s, v) in st {
            print("\t\(s):  \(v)")
        }
    }
    
    private func g(_ input: [String]) {
        if input.count != 0 { print("Incorrect parameters for g"); return }
        vm.execute()
    }
    
    private func s(_ input: [String]) {
        if input.count != 0 { print("Incorrect parameters for s"); return }
        vm.step()
    }
    
    private func helpMessage() {
        print("help table needs to be typed")
    }
    
    private func parseInt(_ int: String) -> Int? {
        if let i = Int(int) { return i }
        print("Invalid int \(int)")
        return nil
    }
    
    private func parseRegister(_ int: String) -> Register? {
        if let  reg = parseInt(int) {
            if reg < 0 || reg > 9 { print("Invalid register \(reg)"); return nil }
            return Register(rawValue: reg)
        }
        return nil
    }
    
    private func parseAddress(_ a: String) -> Int? {
        if let i = Int(a) { return i }
        if let i = st[a] { return i }
        print("Invalid address \(a)")
        return nil
    }
}
