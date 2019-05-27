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

    @IBAction func didPressStart() {
        print("did press start")
    }

    @IBAction func didReleaseStart() {
        print("did release start")
    }

    @IBAction func didPressSelect() {
        print("did press select")
    }

    @IBAction func didReleaseSelect() {
        print("did release select")
    }

    @IBAction func didPressUp() {
        print("did press up")
    }

    @IBAction func didReleaseUp() {
        print("did release up")
    }

    @IBAction func didPressDown() {
        print("did press down")
    }

    @IBAction func didReleaseDown() {
        print("did release down")
    }

    @IBAction func didPressLeft() {
        print("did press left")
    }

    @IBAction func didReleaseLeft() {
        print("did release left")
    }

    @IBAction func didPressRight() {
        print("did press right")
    }

    @IBAction func didReleaseRight() {
        print("did release right")
    }

    @IBAction func didPressA() {
        print("did press A")
    }

    @IBAction func didReleaseA() {
        print("did release A")
    }

    @IBAction func didPressB() {
        print("did press B")
    }

    @IBAction func didReleaseB() {
        print("did release B")
    }

    /// Respond to the view loading initially
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGame()

        DispatchQueue.global(qos: .background).async {
            var now = Date().timeIntervalSinceReferenceDate
            var fps = 0.0
            while true {
                self.emulator.step()
                let dTime = Date().timeIntervalSinceReferenceDate - now
                now = Date().timeIntervalSinceReferenceDate
                fps = 1 / dTime
                print(fps)

                DispatchQueue.main.async {
                    self.renderScreen()
                }
            }
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
        screen.image = UIImage(cgImage: context.makeImage()!)
    }
}
