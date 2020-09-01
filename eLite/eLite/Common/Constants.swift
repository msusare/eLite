//
//  Constants.swift
//  iTwoSafe
//
//  Created by Mayur Susare on 13/04/20.
//  Copyright © 2020 WINJIT. All rights reserved.
//

import UIKit
class Constants: NSObject {
    
    static let APP_DEL = UIApplication.shared.delegate as! AppDelegate
       
    public static let kIS_IPAD = UIDevice.current.userInterfaceIdiom == .pad
    
}

struct K {
    struct ProductionServer {
        static let baseURL = "https://raw.githubusercontent.com/" // server URL
    }
}
enum HTTPHeaderField: String {
    case authentication = "auth"
    case contentType = "Content-Type"
    case acceptType = "Accept"
    case acceptEncoding = "Accept-Encoding"
}

enum ContentType: String {
    case json = "application/json"
}



