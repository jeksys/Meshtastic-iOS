//
//  MeshtasticManager.swift
//  Meshtastic-iOS
//
//  Created by Evgeny Yagrushkin on 2020-04-15.
//  Copyright © 2020 Meshtastic. All rights reserved.
//

import Foundation
import CoreBluetooth
import SwiftProtobuf

protocol MeshtasticManagerUpdating {
    func didDiscoverDevice(name: String?, peripheral: CBPeripheral, RSSI: NSNumber)
    func didConnect(to peripheral: CBPeripheral)
    func didDisconnect(to peripheral: CBPeripheral)
    func didReceiveConfig()
}

protocol MeshtasticBlueConnecting: class {
    func readValue(from peripheral: CBPeripheral, characteristicID: String)
    func peripheralWrite(peripheral: CBPeripheral, data: Data?, characteristicID: String)
    func didReceiveConfig()
}

class MeshtasticManager: NSObject, CBCentralManagerDelegate {
    
    private var central: CBCentralManager!
    private var service: CBService?
    private var devices: [String: CBPeripheral] = [:]
    private var chars: [CBUUID: CBCharacteristic] = [:]
    private var connector : MConnectorProtocol!

    var delegate: MeshtasticManagerUpdating?
    
    override init() {
        super.init()
        let options = [CBCentralManagerOptionRestoreIdentifierKey: "com.meshtastic.ble-central"]
        central = CBCentralManager(delegate: self, queue: nil, options: options)
        connector = MConnector(bleManager: self)
    }
    
    func startScan() {
        guard central.state == .poweredOn else {
            Log("Cannot scan, BT is not powered on")
            return
        }
        central.scanForPeripherals(withServices: [CBUUID(string: MConnector.Chars.meshtasticServiceUUID)], options: nil)
    }

    func stopScan(){
        central.stopScan()
    }
    
    func startConfig(peripheral: CBPeripheral) {
        connector.startConfig(peripheral: peripheral)
    }
    
    func centralManagerDidUpdateState(_ central: CBCentralManager) {
        switch central.state {
        case .poweredOn:
            startScan()
        default:
            break
        }
    }

    func centralManager(_ central: CBCentralManager, didDiscover peripheral: CBPeripheral, advertisementData: [String : Any], rssi RSSI: NSNumber) {
        Log("\(peripheral) \(RSSI), \(advertisementData)")
        
        devices[peripheral.identifier.uuidString] = peripheral
        delegate?.didDiscoverDevice(name: peripheral.name, peripheral: peripheral, RSSI: RSSI)
    }
    
    func connect(peripheral: CBPeripheral) {
        central.stopScan()
        peripheral.delegate = self
        central.connect(peripheral)
    }

    func disconnect(peripheral: CBPeripheral) {
        central.stopScan()
        peripheral.delegate = self
        central.cancelPeripheralConnection(peripheral)
    }

    func centralManager(_ central: CBCentralManager, didConnect peripheral: CBPeripheral) {
        delegate?.didConnect(to: peripheral)
        peripheral.discoverServices([CBUUID(string: MConnector.Chars.meshtasticServiceUUID)])
    }
    
    func centralManager(_ central: CBCentralManager, willRestoreState dict: [String : Any]) {
        Log("willRestoreState: \(dict)")
        let restoredPeripherals = dict[CBCentralManagerRestoredStatePeripheralsKey] as? [CBPeripheral]
        Log("restoredPeripherals: \(String(describing: restoredPeripherals))")
        restoredPeripherals?.forEach({delegate?.didDiscoverDevice(name: nil, peripheral: $0, RSSI: 0)})
        restoredPeripherals?.filter({$0.state == .connected}).forEach({delegate?.didConnect(to: $0)})
    }
    
}

extension MeshtasticManager: CBPeripheralDelegate {
    
    func peripheral(_ peripheral: CBPeripheral, didDiscoverServices error: Error?) {
      guard let services = peripheral.services else { return }
      for service in services {
        Log(service)
        self.service = service
        peripheral.discoverCharacteristics(nil, for: service)
      }
    }

    func peripheral(_ peripheral: CBPeripheral, didDiscoverCharacteristicsFor service: CBService, error: Error?) {
        guard let characteristics = service.characteristics else { return }
        
        for characteristic in characteristics {
            Log(characteristic)
            chars[characteristic.uuid] = characteristic
            if characteristic.properties.contains(.write) {
                Log("\(characteristic.uuid): properties contains .write")
            }
            if characteristic.properties.contains(.read) {
                Log("\(characteristic.uuid): properties contains .read")
            }
            if characteristic.properties.contains(.notify) {
                Log("\(characteristic.uuid): properties contains .notify")
                peripheral.setNotifyValue(true, for: characteristic)
            }
        }
        connector.startConfig(peripheral: peripheral)
    }

    func peripheral(_ peripheral: CBPeripheral, didUpdateValueFor characteristic: CBCharacteristic, error: Error?) {
        guard let characteristicData = characteristic.value else { return }
        Log("\(characteristic.uuid): \(characteristicData.toString())")
        connector.didReceive(peripheral: peripheral, data: characteristicData, characteristic: characteristic.uuid.uuidString.uppercased())

        switch characteristic.uuid.uuidString.uppercased() {
        default:
            break
        }
    }

    func peripheral(_ peripheral: CBPeripheral, didWriteValueFor characteristic: CBCharacteristic, error: Error?) {
        Log("\(characteristic.uuid): \(String(describing: error))")
    }
    
}

extension MeshtasticManager: MeshtasticBlueConnecting {
    
    func readValue(from peripheral: CBPeripheral, characteristicID: String) {
        Log("\(peripheral.name): \(characteristicID)")
        
        let charID = CBUUID(string: characteristicID)
//        let char = service?.characteristics
        guard let characteristic = chars[charID] else {
            return
        }
        peripheral.readValue(for: characteristic)
    }
    
    func peripheralWrite(peripheral: CBPeripheral, data: Data?, characteristicID: String) {
        let charID = CBUUID(string: characteristicID)
        Log("\(peripheral.name): \(characteristicID); \(data)")

        guard let data = data else {
            return
        }
        guard let characteristic = chars[charID] else {
            return
        }
        peripheral.writeValue(data, for: characteristic, type: CBCharacteristicWriteType.withResponse)
    }
    
    func didReceiveConfig() {
    }

}
