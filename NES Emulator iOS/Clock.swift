//
//  Clock.swift
//  NES Emulator iOS
//
//  Created by James Kauten on 5/26/19.
//  Copyright © 2019 Kautenja. All rights reserved.
//

import Foundation

/// A clock for limiting the framerate of a loop
class Clock {

    /// The framerate to run the clock at.
    var spf: Double

    var previousTime = Date().timeIntervalSinceReferenceDate
    var currentTime = Date().timeIntervalSinceReferenceDate
    
    /// Initialize a new clock with given framerate.
    /// @param fps the framerate to run the clock at
    init(fps: Double) {
        spf = 1 / fps
    }

    var fps: Double {
        return 1 / spf
    }

    /// Perform a tick of the clock.
    func tick(function: () -> ()) {
        previousTime = currentTime
        currentTime = Date.timeIntervalSinceReferenceDate
        let dTime = currentTime - previousTime
//        print(1 / dTime)


//
//        if dTime < spf {
//            usleep(UInt32(1e6 * (spf - dTime)))
//        }

        function()

//        usleep(UInt32(1 * 1e3))
    }

}
