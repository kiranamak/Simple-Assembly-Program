//
//  helper.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 3/28/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

func unicodeValueToCharacter(_ n: Int) -> Character {
    return Character(UnicodeScalar(n)!)
}

func characterToUnicode(_ c: Character) -> Int {
    let s = String(c)
    return Int(s.unicodeScalars[s.unicodeScalars.startIndex].value)
}

func splitStringIntoParts(_ expression: String) -> [String] {
    return expression.split{$0 == " " || $0 == "\n"  || $0 == "\t" }.map{ String($0) }
}
/*
func splitStringIntoChunks(_ expression: String) -> [String] {
    let partialSplit = splitStringIntoParts(expression)
    return partialSplit.split{$0 == "\"" || $0 == "#" || $0 == "\\" }.map{ String($0) }
}
*/
func splitStringIntoLines(_ expression: String) -> [String] {
    return expression.split{ $0 == "\r" || $0 == "\n" }.map { String($0) }
}

func stringPartsIntoInts(_ parts: [String]) -> [Int] {
    return parts.map{ Int($0)! }
}

func splitStringIntoInts(_ expression: String) -> [Int] {
    return expression.split{$0 == " " || $0 == "\n"  || $0 == "\t" }.map{ Int($0)! }
}

func fitI(_ i: Int, _ size: Int, right: Bool = false) -> String {
    let iAsString = "\(i)"
    let newLength = iAsString.count
    return fit(iAsString, newLength > size ? newLength : size, right: right)
}

func fit(_ s: String, _ size: Int, right: Bool = true) -> String {
    var result = ""
    let sSize = s.count
    if sSize == size { return s }
    var count = 0
    if size < sSize {
        for c in s {
            if count < size { result.append(c) }
            count += 1
        }
        return result
    }
    result = s
    var addon = ""
    let num = size - sSize
    for _ in 0..<num { addon.append(" ") }
    if right { return result + addon }
    return addon + result
}

extension String {
    func index(from: Int) -> Index {
        return self.index(startIndex, offsetBy: from)
    }
    func substring(from: Int) -> String {
        let fromIndex = index(from: from)
        return substring(from: fromIndex)
    }
    func substring(to: Int) -> String {
        let toIndex = index(from: to)
        return substring(to: toIndex)
    }
    
    func substring(with r: Range<Int>) -> String {
        let startIndex = index(from: r.lowerBound)
        let endIndex = index(from: r.upperBound)
        return substring(with: startIndex..<endIndex)
    }
}
