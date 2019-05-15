//
//  Tuple.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 5/8/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

struct Tuple: CustomStringConvertible {
    let cs: Int
    let ic: Int
    let ns: Int
    let oc: Int
    let dir: Int
    var iterableTuple = Stack<Int>(size: 5, initial: 0)
    
    init(_ cs: Int, _ ic: Int, _ ns: Int, _ oc: Int, _ dir: Int) {
        self.cs = cs
        self.ic = ic
        self.ns = ns
        self.oc = oc
        self.dir = dir
        iterableTuple.push(dir)
        iterableTuple.push(oc)
        iterableTuple.push(ns)
        iterableTuple.push(ic)
        iterableTuple.push(cs)
    }
    
    var description: String {
        var d = "R"
        if dir == -1 { d = "L" }
        return "\\\(cs) \(unicodeValueToCharacter(ic)) \(ns) \(unicodeValueToCharacter(oc)) \(d)\\"
    }
}
