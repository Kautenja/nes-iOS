//
//  emulator_wrapper.mm
//  nesSwift
//
//  Created by James Kauten on 5/26/19.
//  Copyright © 2019 Kautenja. All rights reserved.
//  Attribution to: https://stackoverflow.com/questions/37804467/include-c-header-file-in-swift
//

#import <Foundation/Foundation.h>
#import "emulator_wrapper.h"
#import "emulator.hpp"

// Use an extension on NESEmulator because we need to use Emulator,
// but we couldn't do it in mywrapper.h, which is visible from Swift and thus
// can't contain C++ stuff.
@interface NESEmulator () {
    /// a pointer to the C++ emulator
    Emulator* emulator;
}
@end

@implementation NESEmulator

- (instancetype)initWithRomPath:(NSString *)romPath {
    self = [super init];
    if (self) {
        emulator = new Emulator(std::string([romPath UTF8String]));
    }
    return self;
}

- (double)width {
    return emulator->WIDTH;
}

- (double)height {
    return emulator->HEIGHT;
}

- (UInt32*)getScreenBuffer {
    return emulator->get_screen_buffer();
}

- (UInt8*)getMemoryBuffer {
    return emulator->get_memory_buffer();
}

- (UInt8*)getController:(int)port {
    return emulator->get_controller(port);
}

- (void)reset {
    emulator->reset();
}

- (void)step {
    emulator->step();
}

- (void)backup {
    emulator->backup();
}

- (void)restore {
    emulator->restore();
}

@end
