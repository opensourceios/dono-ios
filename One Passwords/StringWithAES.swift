//
//  StringWithAES.swift
//  One Passwords
//
//  Created by Ghost on 3/3/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import UIKit
import CryptoSwift

extension String
{
    func aesEncrypt() throws -> String
    {
        let key = String(UIDevice.currentDevice().identifierForVendor!.UUIDString.characters.dropLast(4))
        let iv = String(UIDevice.currentDevice().identifierForVendor!.UUIDString.characters.dropLast(20))
        let data = self.dataUsingEncoding(NSUTF8StringEncoding)
        let enc = try AES(key: key, iv: iv, blockMode:.CBC).encrypt(data!.arrayOfBytes(), padding: PKCS7())
        let encData = NSData(bytes: enc, length: Int(enc.count))
        let base64String: String = encData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions(rawValue: 0))
        let result = String(base64String)

        return result
    }
    
    func aesDecrypt() throws -> String
    {
        let key = String(UIDevice.currentDevice().identifierForVendor!.UUIDString.characters.dropLast(4))
        let iv = String(UIDevice.currentDevice().identifierForVendor!.UUIDString.characters.dropLast(20))
        let data = NSData(base64EncodedString: self, options: NSDataBase64DecodingOptions(rawValue: 0))
        let dec = try AES(key: key, iv: iv, blockMode:.CBC).decrypt(data!.arrayOfBytes(), padding: PKCS7())
        let decData = NSData(bytes: dec, length: Int(dec.count))
        
        if let result = NSString(data: decData, encoding: NSUTF8StringEncoding)
        {
            return String(result)
        }
        else
        {
            return String()
        }
    }
}