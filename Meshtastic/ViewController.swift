//
//  ViewController.swift
//  M-iOS_test
//
//  Created by Evgeny Yagrushkin on 2020-09-25.
//

import UIKit
import CoreBluetooth

class ViewController: UIViewController {

    var manager : MeshtasticManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        manager = MeshtasticManager()
        manager.delegate = self
    }

}

extension ViewController: MeshtasticManagerUpdating {
    func didReceiveConfig() {
    }
    
    func didDiscoverDevice(name: String?, peripheral: CBPeripheral, RSSI: NSNumber) {
        Log("\(RSSI): \(String(describing: name)); \(peripheral)")
        manager.connect(peripheral: peripheral)
    }
    
    func didConnect(to peripheral: CBPeripheral) {
        print(peripheral)
    }
    
    func didDisconnect(to peripheral: CBPeripheral) {
        print(peripheral)
    }
    
}
