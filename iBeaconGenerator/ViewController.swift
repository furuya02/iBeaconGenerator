//
//  ViewController.swift
//  iBeaconGenerator
//
//  Created by SIN on 2017/03/20.
//  Copyright © 2017年 SIN. All rights reserved.
//

import Cocoa

class ViewController: NSViewController, NSTableViewDelegate, NSTableViewDataSource {

    @IBOutlet weak var label: NSTextField!
    var iBeacons: [Ibeacon] = []
    var timer: Timer!

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //iBeacons.append(Ibeacon(uuidString: "48534442-4C45-4144-80C0-1800FFFFFFFF",major: 1,minor: 1))
        iBeacons.append(Ibeacon(uuidString: "9297D8AC-DA28-47F8-AC3D-FEC26012CCC0",major: 1,minor: 1))
        iBeacons.append(Ibeacon(uuidString: "9297D8AC-DA28-47F8-AC3D-FEC26012CCC0",major: 1,minor: 2))
        iBeacons.append(Ibeacon(uuidString: "9297D8AC-DA28-47F8-AC3D-FEC26012CCC0",major: 1,minor: 3))
        iBeacons.append(Ibeacon(uuidString: "9297D8AC-DA28-47F8-AC3D-FEC26012CCC0",major: 1,minor: 4))
        iBeacons.append(Ibeacon(uuidString: "9297D8AC-DA28-47F8-AC3D-FEC26012CCC0",major: 1,minor: 5))
        iBeacons.append(Ibeacon(uuidString: "F0BD940B-A408-4DAA-BD26-ACC848E63DDD",major: 200,minor: 1))
        iBeacons.append(Ibeacon(uuidString: "F0BD940B-A408-4DAA-BD26-ACC848E63DDD",major: 201,minor: 1))
        iBeacons.append(Ibeacon(uuidString: "7456723A-BE65-4559-9BC7-AE3E2F54656B",major: 1,minor: 1))
        iBeacons.append(Ibeacon(uuidString: "93270F50-8CEA-4AFA-8C2C-92EE3C5468E1",major: 1,minor: 1))
        iBeacons.append(Ibeacon(uuidString: "8476551A-ADB3-400C-B221-4D033BAE7660",major: 1,minor: 1))
        
        timer = Timer.scheduledTimer(timeInterval: 0.01, target: self, selector: #selector(self.update), userInfo: nil, repeats: true)
        timer.fire()
        
    }
    
    func update(tm: Timer) {
        self.iBeacons.forEach {
            if $0.power {
                $0.start()
                usleep(20000) // 20ミリ秒
                $0.stop()
            }
        }
    }

    //MARK: - NSTableViewDataSource
    
    func numberOfRows(in tableView: NSTableView) -> Int {
        return iBeacons.count
    }

    func tableView(_ tableView: NSTableView, objectValueFor tableColumn: NSTableColumn?, row: Int) -> Any? {
        switch (tableColumn?.identifier)! as String {
        case "power":
            return iBeacons[row].power ? 1 : 0
        case "uuid":
            return iBeacons[row].uuid.description
        case "major":
            return String(iBeacons[row].major)
        case "minor":
            return String(iBeacons[row].minor)
        default:
            return ""
        }
    }
    
    func tableView(_ tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        iBeacons[row].power = !iBeacons[row].power
        return true
    }
    
}

