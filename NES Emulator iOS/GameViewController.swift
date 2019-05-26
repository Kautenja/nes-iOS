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

    /// the reference to the image view that's acting as the virtual screen
    @IBOutlet weak var screen: UIImageView!

    /// the context for drawing the screen
    var context: CGContext!

    /// The NES emulator associated with this view controller
    var emulator: NESEmulator!

    /// Respond to the view loading initially
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGame()

        for i in 0..<50 {
            emulator.step()
            renderScreen()
        }

    }

    /// Load a new game into the system from a ROM file.
    func loadGame() {
        // try to load the dummy ROM from the bundle
        if let romPath = Bundle.main.path(forResource: "super-mario-bros", ofType: "nes") {
            emulator = NESEmulator(romPath: romPath)
        } else {
            print("ROM path broken")
            return
        }
        emulator.reset()
        // try to create a CGContext wrapped around the NES screen buffer
        guard let _context = CGContext(data: emulator.getScreenBuffer()!,
                                      width: Int(emulator.width),
                                      height: Int(emulator.height),
                                      bitsPerComponent: 8,
                                      bytesPerRow: Int(emulator.bytesPerRow),
                                      space: CGColorSpaceCreateDeviceRGB(),
                                      bitmapInfo: CGImageAlphaInfo.noneSkipLast.rawValue) else {
            print("context failed")
            return
        }
        context = _context
    }

    /// Draw the screen
    func renderScreen() {
        screen.startAnimating()
        screen.image = UIImage(cgImage: context.makeImage()!)
        screen.stopAnimating()
    }
}
