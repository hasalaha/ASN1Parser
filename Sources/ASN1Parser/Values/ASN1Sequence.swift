//
//  ASN1Sequence.swift
//  
//
//  Created by Dominik Horn on 10.11.21.
//

import Foundation

/// Each instance represents a single ASN.1 SEQUENCE value
public struct ASN1Sequence: ASN1Value {
  /// ASN.1 values contained in this sequence in order
  public var values = [ASN1Value]()
  
  /**
   Construct an ASN.1 SEQUENCE value with a no throws guarantee
   
   - Parameters:
    - first: first value of the sequence
    - next: zero or more values, prepended to first in order
   */
  public init(_ first: ASN1Value, _ next: ASN1Value...) {
    values = [first] + next
  }
  
  /**
   Construct an ASN.1 SEQUENCE value given a list of values. Must not be empty.
   
   - Parameters:
    - values: values of the sequence in order
   
   - Throws ``ASN1ConstructionError/emptySequence`` if `values` is empty
   */
  public init(_ values: [ASN1Value]) throws {
    guard !values.isEmpty else {
      throw ASN1ConstructionError.emptySequence
    }
    self.values = values
  }
}
extension ASN1Sequence: Equatable {
  /// Two ASN1Sequences are equal if all their values (in order) are equal to one another
  public static func == (lhs: ASN1Sequence, rhs: ASN1Sequence) -> Bool {
    guard lhs.values.count == rhs.values.count else { return false }
    return zip(lhs.values, rhs.values).allSatisfy({ (v1, v2) in v1.isEqualTo(v2) })
  }
}

extension ASN1Sequence: CustomStringConvertible {
  public var description: String {
    "SEQUENCE:\n" + values.map { "\t\($0)".replacingOccurrences(of: "\n", with: "\n\t") }.joined(separator: "\n")
  }
}
