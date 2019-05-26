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

/// Perform a step on the emulator.
//- (void)step;

/// Backup the current emulator state.
- (void)backup;

/// Restore the emulator to the backup state.
- (void)restore;

@end

#endif /* emulator_wrapper_h */
