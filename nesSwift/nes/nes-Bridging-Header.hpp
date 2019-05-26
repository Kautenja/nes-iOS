//
//  nes-Bridging-Header.h
//  nesSwift
//
//  Created by James Kauten on 5/26/19.
//  Copyright © 2019 Kautenja. All rights reserved.
//

#ifndef nes_Bridging_Header_h
#define nes_Bridging_Header_h

#import "emulator_wrapper.h"

//#include "common.hpp"
//#include "emulator.hpp"
//#include <string>

//// definitions of functions for the Python interface to access
//#ifdef __cplusplus
//extern "C" {
//#endif
//    /// Return the width of the NES.
//    int Width() {
//        return Emulator::WIDTH;
//    }
//
//    /// Return the height of the NES.
//    int Height() {
//        return Emulator::HEIGHT;
//    }
//
//    /// Initialize a new emulator and return a pointer to it
//    Emulator* Initialize(wchar_t* path) {
//        // convert the c string to a c++ std string data structure
//        std::wstring ws_rom_path(path);
//        std::string rom_path(ws_rom_path.begin(), ws_rom_path.end());
//        // create a new emulator with the given ROM path
//        return new Emulator(rom_path);
//    }
//
//    /// Return a pointer to a controller on the machine
//    NES_Byte* Controller(Emulator* emu, int port) {
//        return emu->get_controller(port);
//    }
//
//    /// Return the pointer to the screen buffer
//    NES_Pixel* Screen(Emulator* emu) {
//        return emu->get_screen_buffer();
//    }
//
//    /// Return the pointer to the memory buffer
//    NES_Byte* Memory(Emulator* emu) {
//        return emu->get_memory_buffer();
//    }
//
//    /// Reset the emulator
//    void Reset(Emulator* emu) {
//        emu->reset();
//    }
//
//    /// Perform a discrete step in the emulator (i.e., 1 frame)
//    void Step(Emulator* emu) {
//        emu->step();
//    }
//
//    /// Create a deep copy (i.e., a clone) of the given emulator
//    void Backup(Emulator* emu) {
//        emu->backup();
//    }
//
//    /// Create a deep copy (i.e., a clone) of the given emulator
//    void Restore(Emulator* emu) {
//        emu->restore();
//    }
//
//    /// Close the emulator, i.e., purge it from memory
//    void Close(Emulator* emu) {
//        delete emu;
//    }
//
//#ifdef __cplusplus
//}
//#endif

#endif /* nes_Bridging_Header_h */
