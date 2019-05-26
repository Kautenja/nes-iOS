//
//  main.swift
//  nesSwift
//
//  Created by James Kauten on 5/26/19.
//  Copyright © 2019 Kautenja. All rights reserved.
//

import Foundation

let rom_path = "/Users/jameskauten/Documents/OpenEmu Library/roms/Nintendo (NES)/Zelda 1.nes"
let emu = NESEmulator(romPath: rom_path)!
print(emu.height, emu.width)
let screenBuffer = emu.getScreenBuffer()
print(screenBuffer)
let memoryBuffer = emu.getMemoryBuffer()
print(memoryBuffer)
let controller1 = emu.getController(1)
print(controller1)
let controller2 = emu.getController(2)
print(controller2)
emu.reset()
emu.step()
