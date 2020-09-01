//
//  APIClient.swift
//  Onco Power
//
//  Created by MayurSusare on 15/07/19.
//  Copyright © 2019 None. All rights reserved.
//
//

import Alamofire
import SwiftyJSON

class APIClient {
    
    @discardableResult
    /// Function to request data from URL and decode data into model
    ///
    /// - Parameters:
    ///   - route: APIRouter request
    ///   - decoder: json decoder
    ///   - completion: returns decodable model
    ///   - failure: if fail returns failure message or code
    /// - Returns: response for the request
    private static func performRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T>)->Void,failure: @escaping (String)->Void) -> DataRequest  {
        let response = AF.request(route)
        
        if  NetworkReachabilityManager()!.isReachable {
            
            return response
                .responseDecodable (decoder: decoder){ (response: DataResponse<T>) in
                    if response.response?.statusCode == 200 {
                        if let _ = response.data {
                                completion(response.result)
                        }
                    }else{
                        failure("")
                    }
            }
        }else{
            failure("The Internet connection appears to be offline.")
        }
        return response
    }
    
    private static func performAuthRequest<T:Decodable>(route:APIRouter, decoder: JSONDecoder = JSONDecoder(), completion:@escaping (Result<T>)->Void) -> DataRequest {
        return AF.request(route)
            .responseDecodable (decoder: decoder){ (response: DataResponse<T>) in
                completion(response.result)
        }
    }
    
    static func getData(completion:@escaping (Result<[ListContent]>)->Void,failure: @escaping (String)->Void) {
        performRequest(route: APIRouter.getData, completion: completion, failure: failure)
    }
}
