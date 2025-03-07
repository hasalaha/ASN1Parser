//
//  ASN1ObjectIdentifier.swift
//  
//
//  Created by Dominik Horn on 11.11.21.
//

import Foundation
import BigInt

/// Represents an ASN.1 Object Identifier value
public struct ASN1ObjectIdentifier: ASN1Value {
  /// Individual object identifier nodes in order
  public var nodes = [BigUInt]()
  
  /// Canonical string representation, separating nodes by a single '.' each
  public var value: String {
    nodes.map {
      "\($0)"
    }.joined(separator: ".")
  }
  
  /**
   Construct given a canonical Object Identifier string representation
   
   - Parameter oid: unsigned integer nodes separated by a single '.' each
   
   - Throws: ``ASN1ConstructionError/invalidObjectIdentifierNode(index:)`` if node at index is invalid.
      This can happen, e.g., if the first node's value is greater than 3 or the second node's value is greater or equal to 40
   */
  public init(oid: String) throws {
    nodes = try oid.split(separator: ".").enumerated().map { (i, node) in
      guard let node = BigUInt(node), (i != 0 || node < 4), (i != 1 || node < 40) else {
        throw ASN1ConstructionError.invalidObjectIdentifierNode(index: i)
      }
      return node
    }
  }
  
  /**
   Construct given individual node values
   
   - Parameter nodes: node values in order
   
   - Throws: ``ASN1ConstructionError/invalidObjectIdentifierNode(index:)`` if node at index is invalid.
      This can happen, e.g., if the first node's value is greater than 3 or the second node's value is greater or equal to 40
   */
  public init(nodes: [BigUInt]) throws {
    try nodes.enumerated().forEach { (i, node) in
      guard (i != 0 || node < 4), (i != 1 || node < 40) else {
        throw ASN1ConstructionError.invalidObjectIdentifierNode(index: i)
      }
    }
    self.nodes = nodes
  }
}

extension ASN1ObjectIdentifier: Equatable {}

extension ASN1ObjectIdentifier: CustomStringConvertible {
  public var description: String {
    "OBJECT IDENTIFIER = \(value)"
  }
}
