import XCTest
@testable import ASN1Parser

final class FullParseTests: XCTestCase {
  func testParsingECPublicKeyDER() throws {
    guard let derData = Data(base64Encoded: "MFkwEwYHKoZIzj0CAQYIKoZIzj0DAQcDQgAEQPtmXeh4gkzq30Zq3LXdgcl39fgCOBRZExhNWgZTSv5NTvbRoZNx28Ln/+Wtkfc42nWdunurluAeMPr0BrnLtA==")
    else {
      XCTFail()
      return
    }
    
    // XCTExpectFailure appears to unsupported on other platforms
    #if os(OSX)
    XCTExpectFailure("ASN1Parser does not yet fully implement all required value types")
    let tree = try DERParser.parse(der: derData)
    print(tree)
    #endif
  }
}
