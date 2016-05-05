//
//  PersistableServiceTags.swift
//  One Passwords
//
//  Created by Ghost on 3/2/16.
//  Copyright © 2016 Panos Sakkos. All rights reserved.
//

import Foundation

let docsFolder = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true)[0] as String;

let serviceTagsfilename = "/.service-tags";
let pathToServiceTagsFile = docsFolder.stringByAppendingString(serviceTagsfilename);

internal class PersistableServiceTags
{
    var serviceTags = [String]()
    
    internal func add(var serviceTag: String)
    {
        if (self.serviceTags.contains(serviceTag))
        {
            return;
        }
        
        serviceTag = serviceTag.lowercaseString
        serviceTag = serviceTag.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        
        self.serviceTags.insert(serviceTag, atIndex: self.serviceTags.count);
        self.serviceTags.sortInPlace();
        saveServiceTags();
    }
    
    internal func getAll() -> [String]
    {
        loadServiceTags();
        self.serviceTags.sortInPlace();
        
        return self.serviceTags;
    }
    
    internal func getAt(position: Int) -> String
    {
        var ret = "";
        
        for (i, serviceTag) in self.serviceTags.enumerate()
        {
            if (i == position)
            {
                ret = serviceTag;
            }
        }
        
        return ret;
    }

    
    internal func deleteAt(position: Int) -> String
    {
        let ret = self.serviceTags.removeAtIndex(position);
        
        self.saveServiceTags();
        
        return ret;
    }

    internal func count() -> Int
    {
        return self.serviceTags.count;
    }
    
    private func saveServiceTags()
    {
        var dump = "";
        
        for (_, serviceTag) in self.serviceTags.enumerate()
        {
            dump += serviceTag + "\n";
        }
            
        do
        {
            try dump.writeToFile(pathToServiceTagsFile, atomically: false, encoding: NSUTF8StringEncoding);
        }
        catch
        {
        }
    }

    private func loadServiceTags()
    {
        do
        {
            self.serviceTags.removeAll();
            
            let tags = try String(contentsOfFile: pathToServiceTagsFile, encoding: NSUTF8StringEncoding).characters.split("\n");
            
            for (_, tag) in tags.enumerate()
            {
                self.serviceTags.insert(String(tag), atIndex: 0);
            }
            
            self.serviceTags.sortInPlace();
        }
        catch
        {
        }
    }
}