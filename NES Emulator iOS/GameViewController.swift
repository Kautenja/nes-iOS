//
//  GameViewController.swift
//  NES Emulator iOS
//
//  Created by James Kauten on 5/26/19.
//  Copyright © 2019 Kautenja. All rights reserved.
//

import UIKit
import CoreGraphics

// Bitmaps for controller actions

let CONTROLLER_RIGHT: UInt8 =  0b10000000
let CONTROLLER_LEFT: UInt8 =   0b01000000
let CONTROLLER_DOWN: UInt8 =   0b00100000
let CONTROLLER_UP: UInt8 =     0b00010000
let CONTROLLER_START: UInt8 =  0b00001000
let CONTROLLER_SELECT: UInt8 = 0b00000100
let CONTROLLER_B: UInt8 =      0b00000010
let CONTROLLER_A: UInt8 =      0b00000001

// Our iOS specific view controller
class GameViewController: UIViewController {

    /// the reference to the image view that's acting as the virtual screen
    @IBOutlet weak var screen: UIImageView!

    /// the context for drawing the screen
    var context: CGContext!

    /// The buffer for writing controller actions
    var controller: UnsafeMutablePointer<UInt8>!

    /// The NES emulator associated with this view controller
    var emulator: NESEmulator!

    // event handlers for button presses

    @IBAction func didPressStart()  { controller[0] |= CONTROLLER_START }
    @IBAction func didPressSelect() { controller[0] |= CONTROLLER_SELECT }
    @IBAction func didPressUp()     { controller[0] |= CONTROLLER_UP }
    @IBAction func didPressDown()   { controller[0] |= CONTROLLER_DOWN }
    @IBAction func didPressLeft()   { controller[0] |= CONTROLLER_LEFT }
    @IBAction func didPressRight()  { controller[0] |= CONTROLLER_RIGHT }
    @IBAction func didPressA()      { controller[0] |= CONTROLLER_A }
    @IBAction func didPressB()      { controller[0] |= CONTROLLER_B }

    // event handlers for button releases

    @IBAction func didReleaseStart()  { controller[0] &= ~CONTROLLER_START }
    @IBAction func didReleaseSelect() { controller[0] &= ~CONTROLLER_SELECT }
    @IBAction func didReleaseUp()     { controller[0] &= ~CONTROLLER_UP }
    @IBAction func didReleaseDown()   { controller[0] &= ~CONTROLLER_DOWN }
    @IBAction func didReleaseLeft()   { controller[0] &= ~CONTROLLER_LEFT }
    @IBAction func didReleaseRight()  { controller[0] &= ~CONTROLLER_RIGHT }
    @IBAction func didReleaseA()      { controller[0] &= ~CONTROLLER_A }
    @IBAction func didReleaseB()      { controller[0] &= ~CONTROLLER_B }

    /// Respond to the view loading initially
    override func viewDidLoad() {
        super.viewDidLoad()
        loadGame()
        // start the game loop in the background
        DispatchQueue.global(qos: .userInteractive).async {
            let timer = Timer(timeInterval: 1.0 / 60.0,
                              target: self,
                              selector: #selector(self.step),
                              userInfo: nil,
                              repeats: true)
            RunLoop.current.add(timer, forMode: .common)
            RunLoop.current.run()
        }
    }

    /// Perform a step on the emulator and render the screen
    @objc func step() {
        self.emulator.step()
        // render the screen on the UI thread
        DispatchQueue.main.async {
            self.renderScreen()
        }
    }

    /// Load a new game into the system from a ROM file.
    func loadGame() {
        // try to load the dummy ROM from the bundle
        if let romPath = Bundle.main.path(forResource: "zelda1", ofType: "nes") {
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
                                      bitmapInfo: CGBitmapInfo.byteOrder32Little.rawValue | CGImageAlphaInfo.noneSkipFirst.rawValue) else {
            // TODO: handle this error more gracefully
            print("context failed")
            return
        }
        context = _context
        // get the buffer for the controller
        controller = emulator.getController(0)
    }

    /// Draw the screen
    @objc func renderScreen() {
        screen.image = UIImage(cgImage: context.makeImage()!)
    }

}
