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

    /// Initialize a new clock with given framerate.
    /// @param fps the framerate to run the clock at
    init(fps: Double) {
        spf = 1 / fps
        let timer = Timer.init(timeInterval: 1.0 / 60.0, repeats: true) { (timer) in
            print("plopt")
        }
        timer.fire()
    }

    var fps: Double {
        return 1 / spf
    }

    /// Perform a tick of the clock.
    /// TODO: fix
    func tick(function: () -> ()) {
        let beforeWork = Date().timeIntervalSinceReferenceDate
        function()
        let afterWork = Date().timeIntervalSinceReferenceDate
        let dTime = afterWork - beforeWork

        if dTime < spf {
            let sleepFor = spf - dTime
            usleep(UInt32(sleepFor * 1e5))
        }
        let afterThrottle = Date().timeIntervalSinceReferenceDate
        print(1 / (afterThrottle - beforeWork))

    }

}
