//
//  Dono.swift
//  DonoCore
//
//  Created by Ghost on 5/27/16.
//
//

import BigInt
import CryptoSwift

public class Dono
{
    public static var MIN_KEY_LENGTH = 17
    
    private var rounds : [BigInt] =
        [
            BigInt("21688899074207999999999999999"),
            BigInt("834188425931076923076923075"),
            BigInt("32084170228118343195266271"),
            BigInt("1234006547235320892125624"),
            BigInt("47461790278281572774061"),
            BigInt("1825453472241598952847"),
            BigInt("70209748932369190493"),
            BigInt("2700374958937276556"),
            BigInt("103860575343741405"),
            BigInt("3994637513220822"),
            BigInt("153639904354646"),
            BigInt("5909227090562"),
            BigInt("227277965020"),
            BigInt("8741460192"),
            BigInt("336210006"),
            BigInt("12931153"),
            BigInt("497351"),
            BigInt("19127"),
            BigInt("734"),
            BigInt("27"),
            BigInt("0"),
            ]
    
    private var EvaluatorCheat = "!A"
    
    public init() { }

    public func computePassword(k: String, l: String) -> String
    {
        l.lowercaseString
        var s = "4a5e1e4baab89f3a32518a88c31bc87f618f76673e2cc77ab2127b7afdeda33b"
        
        s = (k + l + s).sha256()
        var d = (k + l + s).sha256()
        
        let rs = decideRounds(k)
        
        for var i = BigInt(0); i < rs; i = i + BigInt(1)
        {
            s = (d + s).sha256()
            d = (d + s).sha256()
        }
        
        return d + EvaluatorCheat
    }
    
    private func decideRounds(k: String) -> BigInt
    {
        if (k.characters.count < rounds.count)
        {
            return rounds[k.characters.count]
        }
        else
        {
            return rounds[rounds.count - 1]
        }
    }    
}
