//
//  APIRouter.swift
//  Onco Power
//
//  Created by MayurSusare on 15/07/19.
//  Copyright © 2019 None. All rights reserved.
//


import Alamofire
import SwiftyJSON

enum APIRouter: URLRequestConvertible {
    
    case getData
    
    // MARK: - HTTPMethod
    private var method: HTTPMethod {
        switch self {
        case .getData:
            return .get
        }
    }
    
    // MARK: - Path
    private var path: String {
        switch self {
        case .getData:
            return "AxxessTech/Mobile-Projects/master/challenge.json"
        }
    }
    
    // MARK: - Parameters
    private var parameters: Parameters? {
        switch self {
            case .getData:
                return nil
        }
    }
    
    // MARK: - URLRequestConvertible
    func asURLRequest() throws -> URLRequest {
        
        let url = try K.ProductionServer.baseURL.asURL()
        
        var urlRequest = URLRequest(url: url.appendingPathComponent(path))
        
        // HTTP Method
        urlRequest.httpMethod = method.rawValue
        
        // Parameters
        if let parameters = parameters {
            do {
                if JSONSerialization.isValidJSONObject(parameters) {
                     urlRequest.httpBody = try JSONSerialization.data(withJSONObject: parameters, options: [])
                }else {
                    _ = try JSONSerialization.data(withJSONObject: JSON(parameters).dictionary, options: [])
                    urlRequest.httpBody = try JSON(parameters).rawData()
                }
            } catch {
                throw AFError.parameterEncodingFailed(reason: .jsonEncodingFailed(error: error))
            }
        }
    
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.acceptType.rawValue)
        
        switch self {
            
        default:
            urlRequest.setValue(ContentType.json.rawValue, forHTTPHeaderField: HTTPHeaderField.contentType.rawValue)
        }
        
        return urlRequest
    }
}


