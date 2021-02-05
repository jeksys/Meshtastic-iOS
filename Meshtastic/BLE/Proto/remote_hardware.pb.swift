// DO NOT EDIT.
// swift-format-ignore-file
//
// Generated by the Swift generator plugin for the protocol buffer compiler.
// Source: remote_hardware.proto
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

/// A example app to show off the plugin system. This message is used for REMOTE_HARDWARE_APP PortNums.
///
/// Also provides easy remote access to any GPIO.  
///
/// In the future other remote hardware operations can be added based on user interest (i.e. serial output, spi/i2c input/output).
///
/// FIXME - currently this feature is turned on by default which is dangerous because no security yet (beyond the channel mechanism).
/// It should be off by default and then protected based on some TBD mechanism (a special channel once multichannel support is included?)
struct HardwareMessage {
  // SwiftProtobuf.Message conformance is added in an extension below. See the
  // `Message` and `Message+*Additions` files in the SwiftProtobuf library for
  // methods supported on all messages.

  ///
  /// What type of HardwareMessage is this?
  var typ: HardwareMessage.TypeEnum = .unset

  ///
  /// What gpios are we changing. Not used for all MessageTypes, see MessageType for details
  var gpioMask: UInt64 = 0

  ///
  /// For gpios that were listed in gpio_mask as valid, what are the signal levels for those gpios.
  /// Not used for all MessageTypes, see MessageType for details
  var gpioValue: UInt64 = 0

  var unknownFields = SwiftProtobuf.UnknownStorage()

  enum TypeEnum: SwiftProtobuf.Enum {
    typealias RawValue = Int

    ///
    /// Unset/unused
    case unset // = 0

    ///
    /// Set gpio gpios based on gpio_mask/gpio_value
    case writeGpios // = 1

    ///
    /// We are now interested in watching the gpio_mask gpios.
    /// If the selected gpios change, please broadcast GPIOS_CHANGED.
    ///
    /// Will implicitly change the gpios requested to be INPUT gpios.
    case watchGpios // = 2

    ///
    /// The gpios listed in gpio_mask have changed, the new values are listed in gpio_value
    case gpiosChanged // = 3

    ///
    /// Read the gpios specified in gpio_mask, send back a READ_GPIOS_REPLY reply with gpio_value populated
    case readGpios // = 4

    ///
    /// A reply to READ_GPIOS. gpio_mask and gpio_value will be populated
    case readGpiosReply // = 5
    case UNRECOGNIZED(Int)

    init() {
      self = .unset
    }

    init?(rawValue: Int) {
      switch rawValue {
      case 0: self = .unset
      case 1: self = .writeGpios
      case 2: self = .watchGpios
      case 3: self = .gpiosChanged
      case 4: self = .readGpios
      case 5: self = .readGpiosReply
      default: self = .UNRECOGNIZED(rawValue)
      }
    }

    var rawValue: Int {
      switch self {
      case .unset: return 0
      case .writeGpios: return 1
      case .watchGpios: return 2
      case .gpiosChanged: return 3
      case .readGpios: return 4
      case .readGpiosReply: return 5
      case .UNRECOGNIZED(let i): return i
      }
    }

  }

  init() {}
}

#if swift(>=4.2)

extension HardwareMessage.TypeEnum: CaseIterable {
  // The compiler won't synthesize support with the UNRECOGNIZED case.
  static var allCases: [HardwareMessage.TypeEnum] = [
    .unset,
    .writeGpios,
    .watchGpios,
    .gpiosChanged,
    .readGpios,
    .readGpiosReply,
  ]
}

#endif  // swift(>=4.2)

// MARK: - Code below here is support for the SwiftProtobuf runtime.

extension HardwareMessage: SwiftProtobuf.Message, SwiftProtobuf._MessageImplementationBase, SwiftProtobuf._ProtoNameProviding {
  static let protoMessageName: String = "HardwareMessage"
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    1: .same(proto: "typ"),
    2: .standard(proto: "gpio_mask"),
    3: .standard(proto: "gpio_value"),
  ]

  mutating func decodeMessage<D: SwiftProtobuf.Decoder>(decoder: inout D) throws {
    while let fieldNumber = try decoder.nextFieldNumber() {
      // The use of inline closures is to circumvent an issue where the compiler
      // allocates stack space for every case branch when no optimizations are
      // enabled. https://github.com/apple/swift-protobuf/issues/1034
      switch fieldNumber {
      case 1: try { try decoder.decodeSingularEnumField(value: &self.typ) }()
      case 2: try { try decoder.decodeSingularUInt64Field(value: &self.gpioMask) }()
      case 3: try { try decoder.decodeSingularUInt64Field(value: &self.gpioValue) }()
      default: break
      }
    }
  }

  func traverse<V: SwiftProtobuf.Visitor>(visitor: inout V) throws {
    if self.typ != .unset {
      try visitor.visitSingularEnumField(value: self.typ, fieldNumber: 1)
    }
    if self.gpioMask != 0 {
      try visitor.visitSingularUInt64Field(value: self.gpioMask, fieldNumber: 2)
    }
    if self.gpioValue != 0 {
      try visitor.visitSingularUInt64Field(value: self.gpioValue, fieldNumber: 3)
    }
    try unknownFields.traverse(visitor: &visitor)
  }

  static func ==(lhs: HardwareMessage, rhs: HardwareMessage) -> Bool {
    if lhs.typ != rhs.typ {return false}
    if lhs.gpioMask != rhs.gpioMask {return false}
    if lhs.gpioValue != rhs.gpioValue {return false}
    if lhs.unknownFields != rhs.unknownFields {return false}
    return true
  }
}

extension HardwareMessage.TypeEnum: SwiftProtobuf._ProtoNameProviding {
  static let _protobuf_nameMap: SwiftProtobuf._NameMap = [
    0: .same(proto: "UNSET"),
    1: .same(proto: "WRITE_GPIOS"),
    2: .same(proto: "WATCH_GPIOS"),
    3: .same(proto: "GPIOS_CHANGED"),
    4: .same(proto: "READ_GPIOS"),
    5: .same(proto: "READ_GPIOS_REPLY"),
  ]
}
