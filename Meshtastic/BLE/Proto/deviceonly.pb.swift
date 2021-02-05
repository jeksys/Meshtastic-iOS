// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: deviceonly.proto
//
// For information on using the generated types, please see the documentation:
//   https://github.com/apple/swift-protobuf/

import Foundation
import SwiftProtobuf

// If the compiler emits an error on this type, it is because this file
// was generated by a version of the `protoc` Swift plug-in that is
// incompatible with the version of SwiftProtobuf to which you are linking.
// Please ensure that you are building against the same version of the API
// that was used to generate this file.
fileprivate struct _GeneratedWithProtocGenSwiftVersion: SwiftProtobuf.ProtobufAPIVersionCheck {
  struct _2: SwiftProtobuf.ProtobufAPIVersion_2 {}
  typealias Version = _2
}

///
/// This message is never sent over the wire, but it is used for serializing DB
/// state to flash in the device code
/// FIXME, since we write this each time we enter deep sleep (and have infinite
/// flash) it would be better to use some sort of append only data structure for
/// the receive queue and use the preferences store for the other stuff
struct DeviceState {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  var radio: RadioConfig {
    get {return _storage._radio ?? RadioConfig()}
    set {_uniqueStorage()._radio = newValue}
  }
  /// Returns true if `radio` has been explicitly set.
  var hasRadio: Bool {return _storage._radio != nil}
  /// Clears the value of `radio`. Subsequent reads from it will return its default value.
  mutating func clearRadio() {_uniqueStorage()._radio = nil}

  ///
  /// Read only settings/info about this node
  var myNode: MyNodeInfo {
    get {return _storage._myNode ?? MyNodeInfo()}
    set {_uniqueStorage()._myNode = newValue}
  }
  /// Returns true if `myNode` has been explicitly set.
  var hasMyNode: Bool {return _storage._myNode != nil}
  /// Clears the value of `myNode`. Subsequent reads from it will return its default value.
  mutating func clearMyNode() {_uniqueStorage()._myNode = nil}

  ///
  /// My owner info
  var owner: User {
    get {return _storage._owner ?? User()}
    set {_uniqueStorage()._owner = newValue}
  }
  /// Returns true if `owner` has been explicitly set.
  var hasOwner: Bool {return _storage._owner != nil}
  /// Clears the value of `owner`. Subsequent reads from it will return its default value.
  mutating func clearOwner() {_uniqueStorage()._owner = nil}

  var nodeDb: [NodeInfo] {
    get {return _storage._nodeDb}
    set {_uniqueStorage()._nodeDb = newValue}
  }

  ///
  /// Received packets saved for delivery to the phone
  var receiveQueue: [MeshPacket] {
    get {return _storage._receiveQueue}
    set {_uniqueStorage()._receiveQueue = newValue}
  }

  ///
  /// A version integer used to invalidate old save files when we make
  /// incompatible changes This integer is set at build time and is private to
  /// NodeDB.cpp in the device code.
  var version: UInt32 {
    get {return _storage._version}
    set {_uniqueStorage()._version = newValue}
  }

  ///
  /// We keep the last received text message (only) stored in the device flash,
  /// so we can show it on the screen.
  /// Might be null
  var rxTextMessage: MeshPacket {
    get {return _storage._rxTextMessage ?? MeshPacket()}
    set {_uniqueStorage()._rxTextMessage = newValue}
  }
  /// Returns true if `rxTextMessage` has been explicitly set.
  var hasRxTextMessage: Bool {return _storage._rxTextMessage != nil}
  /// Clears the value of `rxTextMessage`. Subsequent reads from it will return its default value.
  mutating func clearRxTextMessage() {_uniqueStorage()._rxTextMessage = nil}

  ///
  /// Used only during development.  Indicates developer is testing and changes
  /// should never be saved to flash.
  var noSave: Bool {
    get {return _storage._noSave}
    set {_uniqueStorage()._noSave = newValue}
  }

  ///
  /// Some GPSes seem to have bogus settings from the factory, so we always do one factory reset.
  var didGpsReset: Bool {
    get {return _storage._didGpsReset}
    set {_uniqueStorage()._didGpsReset = newValue}
  }

  ///
  /// Secondary channels are only used for encryption/decryption/authentication purposes.  Their radio settings (freq etc)
  /// are ignored, only psk is used.
  /// Note: this is not kept inside of RadioConfig because that would make ToRadio/FromRadio worse case > 512 bytes (to big for BLE)
  var secondaryChannels: [ChannelSettings] {
    get {return _storage._secondaryChannels}
    set {_uniqueStorage()._secondaryChannels = newValue}
  }

  var unknownFields = SwiftProtobuf.UnknownStorage()

  init() {}

  fileprivate var _storage = _StorageClass.defaultInstance
}

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension DeviceState: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "DeviceState"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "radio"),
    2: .standard(proto: "my_node"),
    3: .same(proto: "owner"),
    4: .standard(proto: "node_db"),
    5: .standard(proto: "receive_queue"),
    8: .same(proto: "version"),
    7: .standard(proto: "rx_text_message"),
    9: .standard(proto: "no_save"),
    11: .standard(proto: "did_gps_reset"),
    12: .standard(proto: "secondary_channels"),
  ]

  fileprivate class _StorageClass {
    var _radio: RadioConfig? = nil
    var _myNode: MyNodeInfo? = nil
    var _owner: User? = nil
    var _nodeDb: [NodeInfo] = []
    var _receiveQueue: [MeshPacket] = []
    var _version: UInt32 = 0
    var _rxTextMessage: MeshPacket? = nil
    var _noSave: Bool = false
    var _didGpsReset: Bool = false
    var _secondaryChannels: [ChannelSettings] = []

    static let defaultInstance = _StorageClass()

    private init() {}

    init(copying source: _StorageClass) {
      _radio = source._radio
      _myNode = source._myNode
      _owner = source._owner
      _nodeDb = source._nodeDb
      _receiveQueue = source._receiveQueue
      _version = source._version
      _rxTextMessage = source._rxTextMessage
      _noSave = source._noSave
      _didGpsReset = source._didGpsReset
      _secondaryChannels = source._secondaryChannels
    }
  }

  fileprivate mutating func _uniqueStorage() -> _StorageClass {
    if !isKnownUniquelyReferenced(&_storage) {
      _storage = _StorageClass(copying: _storage)
    }
    return _storage
  }

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    _ = _uniqueStorage()
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      while let fieldNumber = try decoder.nextFieldNumber() {
        // The use of inline closures is to circumvent an issue where the compiler
        // allocates stack space for every case branch when no optimizations are
        // enabled. https://github.com/apple/swift-protobuf/issues/1034
        switch fieldNumber {
        case 1: try { try decoder.decodeSingularMessageField(value: &_storage._radio) }()
        case 2: try { try decoder.decodeSingularMessageField(value: &_storage._myNode) }()
        case 3: try { try decoder.decodeSingularMessageField(value: &_storage._owner) }()
        case 4: try { try decoder.decodeRepeatedMessageField(value: &_storage._nodeDb) }()
        case 5: try { try decoder.decodeRepeatedMessageField(value: &_storage._receiveQueue) }()
        case 7: try { try decoder.decodeSingularMessageField(value: &_storage._rxTextMessage) }()
        case 8: try { try decoder.decodeSingularUInt32Field(value: &_storage._version) }()
        case 9: try { try decoder.decodeSingularBoolField(value: &_storage._noSave) }()
        case 11: try { try decoder.decodeSingularBoolField(value: &_storage._didGpsReset) }()
        case 12: try { try decoder.decodeRepeatedMessageField(value: &_storage._secondaryChannels) }()
        default: break
        }
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    try withExtendedLifetime(_storage) { (_storage: _StorageClass) in
      if let v = _storage._radio {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 1)
      }
      if let v = _storage._myNode {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 2)
      }
      if let v = _storage._owner {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 3)
      }
      if !_storage._nodeDb.isEmpty {
        try visitor.visitRepeatedMessageField(value: _storage._nodeDb, fieldNumber: 4)
      }
      if !_storage._receiveQueue.isEmpty {
        try visitor.visitRepeatedMessageField(value: _storage._receiveQueue, fieldNumber: 5)
      }
      if let v = _storage._rxTextMessage {
        try visitor.visitSingularMessageField(value: v, fieldNumber: 7)
      }
      if _storage._version != 0 {
        try visitor.visitSingularUInt32Field(value: _storage._version, fieldNumber: 8)
      }
      if _storage._noSave != false {
        try visitor.visitSingularBoolField(value: _storage._noSave, fieldNumber: 9)
      }
      if _storage._didGpsReset != false {
        try visitor.visitSingularBoolField(value: _storage._didGpsReset, fieldNumber: 11)
      }
      if !_storage._secondaryChannels.isEmpty {
        try visitor.visitRepeatedMessageField(value: _storage._secondaryChannels, fieldNumber: 12)
      }
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: DeviceState, rhs: DeviceState) -> Bool {
    if lhs._storage !== rhs._storage {
      let storagesAreEqual: Bool = withExtendedLifetime((lhs._storage, rhs._storage)) { (_args: (_StorageClass, _StorageClass)) in
        let _storage = _args.0
        let rhs_storage = _args.1
        if _storage._radio != rhs_storage._radio {return false}
        if _storage._myNode != rhs_storage._myNode {return false}
        if _storage._owner != rhs_storage._owner {return false}
        if _storage._nodeDb != rhs_storage._nodeDb {return false}
        if _storage._receiveQueue != rhs_storage._receiveQueue {return false}
        if _storage._version != rhs_storage._version {return false}
        if _storage._rxTextMessage != rhs_storage._rxTextMessage {return false}
        if _storage._noSave != rhs_storage._noSave {return false}
        if _storage._didGpsReset != rhs_storage._didGpsReset {return false}
        if _storage._secondaryChannels != rhs_storage._secondaryChannels {return false}
        return true
      }
      if !storagesAreEqual {return false}
    }
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}
