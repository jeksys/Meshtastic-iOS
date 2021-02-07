//
//  MConnector.swift
//  M-iOS_test
//
//  Created by Evgeny Yagrushkin on 2020-10-13.
//

import Foundation
import SwiftProtobuf

protocol MConnectorProtocol: class {
    func startConfig()
    func didReceive(data: Data, char: String)
    var bleManager: MeshtasticBlueConnecting {get set}
}

class MConnector: MConnectorProtocol {

    struct Chars {
        static let meshtasticServiceUUID = "6ba1b218-15a8-461f-9fa8-5dcae273eafd"
        static let fromradio_CharacteristicUUID = "8ba2bcc2-ee02-4a55-a531-c525c5e454d5".uppercased() // read
        static let toradio_CharacteristicUUID = "f75c76d2-129e-4dad-a1dd-7866124401e7".uppercased() // write
        static let fromnum_CharacteristicUUID = "ed9da18c-a800-4f66-a670-aa7547e34453".uppercased() // read,notify,write
        static let GATT_UUID_SW_VERSION_STR = "2a28".uppercased() // read,notify,write
        static let GATT_UUID_MANU_NAME = "2a29".uppercased() // read,notify,write
        static let GATT_UUID_HW_VERSION_STR = "2a27".uppercased() // read,notify,write
    }
    
    var bleManager: MeshtasticBlueConnecting
    var my_info: MyNodeInfo?
    var radioConfig: RadioConfig?
    var node_info: NodeInfo?

    init(bleManager: MeshtasticBlueConnecting) {
        self.bleManager = bleManager
    }
    
    func startConfig() {
        // read data from the from radio
        var toRadio = ToRadio()
        toRadio.wantConfigID = 0
        let data = try? toRadio.serializedData()
        bleManager.peripheralWrite(data: data, characteristicID: Chars.toradio_CharacteristicUUID)
        bleManager.readValue(for: Chars.fromradio_CharacteristicUUID)
    }

    func readFromRadio() {
        bleManager.readValue(for: Chars.fromradio_CharacteristicUUID)
    }

    func getAllNodeInfo() {
        let packet = NodeInfo()
        let packetData = try? packet.serializedData()
        bleManager.peripheralWrite(data: packetData, characteristicID: Chars.toradio_CharacteristicUUID)
    }
    
    func didReceive(data: Data, char: String) {
        
        switch char {
        case Chars.fromradio_CharacteristicUUID:
            
            if data.count != 0 {
                do {
                    let fromRadio = try FromRadio(serializedData: data)
                    bleManager.readValue(for: Chars.fromradio_CharacteristicUUID)
                    
                    switch fromRadio.variant {
                    case .radio(let value):
                        radioConfig = value
                        print(fromRadio)
                        
                    case .myInfo(let value):
                        my_info = value
                        print(fromRadio)
                        
                    case .nodeInfo(let value):
                        node_info = value
                        print(fromRadio)
                        getAllNodeInfo()
                        
                    default:
                        print("**** another data:   n\(fromRadio)")
                        break
                    }
                } catch let error {
                    print(error)
                }
            } else {
            }
            
        case Chars.fromnum_CharacteristicUUID:
            readFromRadio()
//            if let fromRadio = try? FromRadio(serializedData: data) {
//                print(fromRadio)
//            }

        default:
            break
        }
        
    }
    
}
