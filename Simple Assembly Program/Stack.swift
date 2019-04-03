//
//  Stack.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 4/2/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

struct Stack<Element> : CustomStringConvertible, Sequence {
    var top = 0
    var s: Int
    var stack: Array<Element>
    init(size: Int, initial: Element) {
        stack = Array(repeating: initial, count: size)
        s = size
    }
    func isEmpty() -> Bool {
        if top == 0 {return true}
        return false
    }
    func isFull() -> Bool {
        if top == s {return true}
        return false
    }
    mutating func push(_ element: Element) {
        assert(!isFull(), "Tried to push element \(element) onto full stack")
        stack[top] = element
        top += 1
    }
    mutating func pop() -> Element? {
        if !isEmpty() {
            top -= 1
            return stack[top]
        }
        return nil
    }
    subscript(index: Int) -> Element {
        get {
            return stack[index]
        }
        set(newValue) {
            stack[index] = newValue
        }
    }
    
    func makeIterator() -> StackIterator<Element> {
        return StackIterator(stack: self)
    }
    
    var description: String {
        var visual = ""
        if !isEmpty() {
            for i in stride(from: top - 1, through: 0, by: -1) {
                visual += "\(stack[i])\n"
            }
        }else {
            visual = "empty"
        }
        return "Stack of \(Element.self) of size \(s):\n\(visual)"
    }
    
}

struct StackIterator<Element>: IteratorProtocol {
    var stack: Stack<Element>
    mutating func next() -> Element? {
        return stack.pop()
    }
}
