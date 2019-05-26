//
//  GameViewController.swift
//  NES Emulator iOS
//
//  Created by James Kauten on 5/26/19.
//  Copyright © 2019 Kautenja. All rights reserved.
//

import UIKit
import CoreGraphics

// Our iOS specific view controller
class GameViewController: UIViewController {

    @IBOutlet weak var screen: UIImageView!

    /// The NES emulator associated with this view controller
    var emulator: NESEmulator!

    /// Respond to the view loading initially
    override func viewDidLoad() {
        super.viewDidLoad()
        loadROM()
        for i in 0..<50 {
            emulator.step()
        }
        renderScreen()

    }

    func loadROM() {
        if let romPath = Bundle.main.path(forResource: "super-mario-bros", ofType: "nes") {
            emulator = NESEmulator(romPath: romPath)
        } else {
            print("ROM path broken")
        }
        emulator.reset()
    }

    func renderScreen() {
        let screenPointer = emulator.getScreenBuffer()!
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let height = Int(emulator.height)
        let width = Int(emulator.width)
        guard let context = CGContext(data: screenPointer, width: width, height: height, bitsPerComponent: 8, bytesPerRow: 4 * width, space: colorSpace, bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue) else {
            print("context failed")
            return
        }
        screen.image = UIImage(cgImage: context.makeImage()!)
    }
}
