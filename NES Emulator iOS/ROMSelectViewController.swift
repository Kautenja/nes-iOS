//
//  ROMSelectViewController.swift
//  NES Emulator iOS
//
//  Created by James Kauten on 6/4/19.
//  Copyright © 2019 Kautenja. All rights reserved.
//

import UIKit

/// A view controller for selecting NES ROMs
class ROMSelectViewController: UITableViewController {

    /// the list of available NES files
    var _files: [String]!

    /// the list of available NES files
    var files: [String] {
        get {
            guard let files = _files else {
                _files = loadNESFilenames()
                return _files!
            }
            return files
        }
    }

    /// Load a list of NES files included in the app's bundle
    private func loadNESFilenames() -> [String] {
        // create a file manager with the default bundle path
        let path = Bundle.main.resourcePath!
        let fileManager = FileManager.default
        // try to load the contents of the default bundle
        do {
            var files = try fileManager.contentsOfDirectory(atPath: path)
            // filter out non-NES files
            files = files.filter { (filename) -> Bool in
                return filename.contains(".nes")
            }
            return files
        } catch {
            // TODO: handle error or ignore entirely
            print(error)
        }
        return []
    }

    /// Respond to the view loading initially
    override func viewDidLoad() {
        super.viewDidLoad()
        print(files)
    }

//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print("selected {indexPath}")
//    }

//    override func numberOfSections(in tableView: UITableView) -> Int {
//        return 1
//    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return files.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
