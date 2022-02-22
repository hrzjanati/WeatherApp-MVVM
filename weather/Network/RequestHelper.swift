//
//  RequestHelper.swift
//  weather
//
//  Created by 𝙷𝚘𝚜𝚎𝚒𝚗 𝙹𝚊𝚗𝚊𝚝𝚒  on 2/13/22.
//

import Foundation

class RequestHelper {
    static let shaered = RequestHelper()
    func dataRequest<T: Decodable>(with url: String, objectType: T.Type, completion: @escaping (Result<T>) -> Void) {
       guard let dataURL = URL(string: url) else {return}
        let session = URLSession.shared
        let request = URLRequest(url: dataURL, cachePolicy: .useProtocolCachePolicy, timeoutInterval: 60)
        let task = session.dataTask(with: request, completionHandler: { data, response, error in
            
            guard error == nil else {
                completion(Result.failure(APPError.networkError(error!)))
                return
            }
            
            guard let data = data else {
                completion(Result.failure(APPError.dataNotFound))
                return
            }
            
            do {
                let decodedObject = try JSONDecoder().decode(objectType.self, from: data)
                completion(Result.success(decodedObject))
            } catch let error {
                completion(Result.failure(APPError.jsonParsingError(error as! DecodingError)))
            }
        })
        task.resume()
    }
}

enum APPError: Error {
    case networkError(Error)
    case dataNotFound
    case jsonParsingError(Error)
    case invalidStatusCode(Int)
}

enum Result<T> {
    case success(T)
    case failure(APPError)
}
