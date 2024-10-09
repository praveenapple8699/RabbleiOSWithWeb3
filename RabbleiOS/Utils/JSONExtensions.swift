//
//  JSONEncoder+Extensions.swift
//  RabbleiOS
//
//  Created by PraveenKumar on 08/10/24.
//

import Foundation


extension JSONDecoder {
    
    class func decode<T: Decodable>(responseData: Data, to type: T.Type) -> (T?,String?) {
        do {
            let model = try JSONDecoder().decode(T.self, from: responseData)
            return (model,nil)
        } catch {
            print("error in decoding = \(error)")
            return (nil,error.localizedDescription)
        }
    }
    
}
