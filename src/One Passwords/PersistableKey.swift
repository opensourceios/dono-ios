//
//  PersistableKey.swift
//  One Passwords
//
//  Created by Ghost on 3/3/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Foundation

let keyFileName = "/.key";
let pathToKeyFile = docsFolder.stringByAppendingString(keyFileName);

internal class PersistableKey
{
    static var Key = String();
    
    internal func getKey() -> String
    {
        if (!PersistableKey.Key.isEmpty)
        {
            return PersistableKey.Key;
        }
        else
        {
            loadKey();
            
            return PersistableKey.Key;
        }
    }
    
    internal func setkey(key: String, remember: Bool)
    {
        PersistableKey.Key = key;
            
        if (remember)
        {
            saveKey();
        }
    }
    
    internal func delete()
    {
        let fileManager = NSFileManager.defaultManager()
        do
        {
            try fileManager.removeItemAtURL(NSURL(fileURLWithPath: pathToKeyFile))
        }
        catch
        {
        }
    }
    
    internal func save()
    {
        self.saveKey()
    }
    
    private func loadKey()
    {
        do
        {
            let encryptedKey = try String(contentsOfFile: pathToKeyFile, encoding: NSUTF8StringEncoding)
            PersistableKey.Key = try encryptedKey.aesDecrypt()
        }
        catch
        {
        }
    }
    
    private func saveKey()
    {
        do
        {
            let encryptedKey = try PersistableKey.Key.aesEncrypt();
            try encryptedKey.writeToFile(pathToKeyFile, atomically: false, encoding: NSUTF8StringEncoding);
        }
        catch
        {
        }
    }
}