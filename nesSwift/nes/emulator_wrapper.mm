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

- (double)width {
    return emulator->WIDTH;
}

- (double)height {
    return emulator->HEIGHT;
}

- (instancetype)initWithRomPath:(NSString *)rom_path {
    self = [super init];
    if (self) {
        emulator = new Emulator(std::string([rom_path UTF8String]));
    }
    return self;
}

- (void)backup {
    emulator->backup();
}

- (void)restore {
    emulator->restore();
}

@end
