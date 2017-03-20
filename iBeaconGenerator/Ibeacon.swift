//
//  iBeacon.swift
//  iBeaconGenerator
//
//  Created by SIN on 2017/03/20.
//  Copyright © 2017年 SIN. All rights reserved.
//

import Cocoa
import CoreLocation
import CoreBluetooth

class Ibeacon: NSObject, CBPeripheralManagerDelegate {
    
    var manager: CBPeripheralManager!
    var uuid: UUID!
    var major: UInt16 = 0
    var minor: UInt16 = 0
    var power: Bool = false
    
    init(uuidString: String, major: UInt16, minor: UInt16){

        super.init()
        
        self.major = major
        self.minor = minor
        uuid = UUID.init(uuidString: uuidString)

        manager = CBPeripheralManager(delegate: self, queue: nil)
    }
    
    func start() {
        let beaconData = BeaconData(proximityUUID: uuid, major: major, minor: minor, measuredPower: -50)
        manager?.startAdvertising(beaconData.advertisement as! [String : Any]?)
    }
    
    func stop() {
        manager?.stopAdvertising()
    }
    
    func peripheralManagerDidUpdateState(_ peripheral: CBPeripheralManager) {
        if peripheral.state == CBPeripheralManagerState.poweredOn {
            // 使用可能なのでボタンを有効にする
            print("power On")
        }
    }
    
    final class BeaconData: NSObject {
        
        var advertisement: NSDictionary!
        
        init(proximityUUID: UUID?, major: UInt16?, minor: UInt16?, measuredPower: Int8?) {
            var buffer = [CUnsignedChar](repeating: 0, count: 21)
            (proximityUUID! as NSUUID).getBytes(&buffer)
            buffer[16] = CUnsignedChar(major! >> 8)
            buffer[17] = CUnsignedChar(major! & 255)
            buffer[18] = CUnsignedChar(minor! >> 8)
            buffer[19] = CUnsignedChar(minor! & 255)
            buffer[20] = CUnsignedChar(bitPattern: measuredPower!)
            let data = NSData(bytes: buffer, length: buffer.count)
            advertisement = NSDictionary(object: data, forKey: "kCBAdvDataAppleBeaconKey" as NSCopying)
        }
    }
}
