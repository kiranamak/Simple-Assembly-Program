//
//  constants.swift
//  Simple Assembly Program
//
//  Created by Kiran Mak on 5/14/19.
//  Copyright © 2019 Kiran Mak. All rights reserved.
//

import Foundation

class Constants {
    let m: Memory
    let commands: [Instruction]
    static let directives = [start(), end(), integer(), string(), tuple(), allocate()]
    
    init(memory: Memory) {
        self.m = memory
        self.commands = [halt(m),
                        clrr(m),
                        clrx(m),
                        clrm(m),
                        clrb(m),
                        movir(m),
                        movrr(m),
                        movmr(m),
                        movxr(m),
                        movar(m),
                        movb(m),
                        addir(m),
                        addrr(m),
                        addmr(m),
                        addxr(m),
                        subir(m),
                        subrr(m),
                        submr(m),
                        subxr(m),
                        mulir(m),
                        mulrr(m),
                        mulmr(m),
                        mulxr(m),
                        divir(m),
                        divrr(m),
                        divmr(m),
                        divxr(m),
                        jmp(m),
                        sojz(m),
                        sojnz(m),
                        aojz(m),
                        aojnz(m),
                        cmpir(m),
                        cmprr(m),
                        cmpmr(m),
                        jmpn(m),
                        jmpz(m),
                        jmpp(m),
                        jsr(m),
                        ret(m),
                        push(m),
                        pop(m),
                        stackc(m),
                        outci(m),
                        outcr(m),
                        outcx(m),
                        outcb(m),
                        readi(m),
                        printi(m),
                        readc(m),
                        readln(m),
                        brk(m),
                        movrx(m),
                        movxx(m),
                        outs(m),
                        nop(m),
                        jmpne(m)
        ]
    }
    
    init() {
        self.m = Memory(binary: [Int](repeating: 0, count: 2))
        self.commands = [Instruction]()
    }
    
    static let rawCommands = [halt(),
                clrr(),
                clrx(),
                clrm(),
                clrb(),
                movir(),
                movrr(),
                movmr(),
                movxr(),
                movar(),
                movb(),
                addir(),
                addrr(),
                addmr(),
                addxr(),
                subir(),
                subrr(),
                submr(),
                subxr(),
                mulir(),
                mulrr(),
                mulmr(),
                mulxr(),
                divir(),
                divrr(),
                divmr(),
                divxr(),
                jmp(),
                sojz(),
                sojnz(),
                aojz(),
                aojnz(),
                cmpir(),
                cmprr(),
                cmpmr(),
                jmpn(),
                jmpz(),
                jmpp(),
                jsr(),
                ret(),
                push(),
                pop(),
                stackc(),
                outci(),
                outcr(),
                outcx(),
                outcb(),
                readi(),
                printi(),
                readc(),
                readln(),
                brk(),
                movrx(),
                movxx(),
                outs(),
                nop(),
                jmpne()
    ]
}
