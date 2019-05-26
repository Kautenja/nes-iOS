//
//  emulator_wrapper.h
//  nesSwift
//
//  Created by James Kauten on 5/26/19.
//  Copyright © 2019 Kautenja. All rights reserved.
//  Attribution to: https://stackoverflow.com/questions/37804467/include-c-header-file-in-swift
//

#ifndef emulator_wrapper_h
#define emulator_wrapper_h

#import <Foundation/Foundation.h>

/// An NES emulator.
@interface NESEmulator : NSObject

/// The width of the screen
@property (readonly, nonatomic) double width;
/// The height of the screen
@property (readonly, nonatomic) double height;

/// Disable the default initializer for the object
- (instancetype)init NS_UNAVAILABLE;

/// Initialize a new NES Emulator with given ROM.
/// @param rom_path the path to the ROM to initialize the emulator with
- (instancetype)initWithRomPath:(NSString *)rom_path;

/// Return a 32-bit pointer to the screen buffer's first address.
///
/// @return a 32-bit pointer to the screen buffer's first address
///
- (UInt32*)getScreenBuffer;

/// Return a 8-bit pointer to the RAM buffer's first address.
///
/// @return a 8-bit pointer to the RAM buffer's first address
///
- (UInt8*)getMemoryBuffer;

/// Return a pointer to a controller port
///
/// @param port the port of the controller to return the pointer to
/// @return a pointer to the byte buffer for the controller state
///
- (UInt8*)getController:(int)port;

/// Reset the emulator to its default state
- (void)reset;

/// Perform a step on the emulator.
- (void)step;

/// Backup the current emulator state.
- (void)backup;

/// Restore the emulator to the backup state.
- (void)restore;

@end

#endif /* emulator_wrapper_h */
