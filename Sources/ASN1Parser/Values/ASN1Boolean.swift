//
//  ASN1Boolean.swift
//  
//
//  Created by Dominik Horn on 10.11.21.
//

import Foundation

/// Represents an ASN.1 Boolean value
public struct ASN1Boolean: ASN1Value {
  var swiftValue: Bool
  
  /// Construct given a swift Bool value
  public init(_ swiftValue: Bool) {
    self.swiftValue = swiftValue
  }
}

extension ASN1Boolean: Equatable {}

extension ASN1Boolean: CustomStringConvertible {
  public var description: String {
    "BOOL = \(swiftValue)"
  }
}
