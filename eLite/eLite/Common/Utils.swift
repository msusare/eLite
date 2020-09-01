//
//  Utils.swift
//  eLite
//
//  Created by Mayur Susare on 01/09/20.
//  Copyright © 2020 Local. All rights reserved.
//

import Foundation
import UIKit

class Utils: NSObject {
    
    /**
     This function used to get the file path from the document directory
     
     - Parameters:
     - filename: filename to search in directory
     - Returns: returns filepath appending filename to it
     */
    public static func getFilePathFromFileName(filename: String) ->String {
        let paths = NSSearchPathForDirectoriesInDomains(FileManager.SearchPathDirectory.documentDirectory, FileManager.SearchPathDomainMask.userDomainMask, true)
        let documentsDirectory: NSString = paths[0] as NSString
        let dataPath = documentsDirectory.appendingPathComponent(filename)
        return dataPath
    }
    
    //This function used to saved the file in Directory with data
    // Parameter
    //  -data: date to store in file
    //  -fileName: file name to store data
    static func writeDataTofile(data: Data, fileName: String) throws {
        let filePath = Utils.getFilePathFromFileName(filename: fileName)
        try data.write(to: URL(fileURLWithPath: filePath))
    }
    
    ///This Function is used to get the Data from provided path resource file
    //  Parameter:
    //      -fileName: fileName to check
    static func getDataFromFilePath(fileName:String) -> Data? {
        let filePath = Utils.getFilePathFromFileName(filename: fileName)
        return FileManager.default.contents(atPath: filePath as String)
    }
}
