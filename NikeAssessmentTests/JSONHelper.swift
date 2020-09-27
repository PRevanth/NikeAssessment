//
//  JSONHelper.swift
//  NikeAssessmentTests
//
//  Created by Pendyala Revanth on 9/27/20.
//

import Foundation

class JSONHelper {
    public static func getData(fromFileWithName name: String, bundle: Bundle) -> Data {
      guard let path = bundle.path(forResource: name, ofType: "json") else {
        return Data()
      }
      let data = try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
      return data ?? Data()
    }

    static func getJsonDecodeObject<T: Decodable>(type: T.Type, jsonFileName: String, bundle: Bundle) -> T?  {
        let jsonData = getData(fromFileWithName: jsonFileName, bundle: bundle)
        do {
            let jsonObject = try JSONDecoder().decode(T.self, from: jsonData)
            return jsonObject
        } catch _ {
            return nil
        }
    }
}
