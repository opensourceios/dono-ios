// Dono Key Derivation Function
// Copyright (C) 2016  Panos Sakkos
//
// This program is free software: you can redistribute it and/or modify
// it under the terms of the GNU General Public License as published by
// the Free Software Foundation, either version 3 of the License, or
// (at your option) any later version.
//
// This program is distributed in the hope that it will be useful,
// but WITHOUT ANY WARRANTY; without even the implied warranty of
// MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
// GNU General Public License for more details.
//
// You should have received a copy of the GNU General Public License
// along with this program.  If not, see <http://www.gnu.org/licenses/>.

import BigInt
import CryptoSwift

public class Dono
{
    public static var MIN_KEY_LENGTH = 17

    public static var MAX_DK_LEN = 64

    private static var Iterations : [BigInt] =
        [
            BigInt("56641855831775999999999999999"),
            BigInt("2178532916606769230769230768"),
            BigInt("83789727561798816568047336"),
            BigInt("3222681829299954483386435"),
            BigInt("123949301126921326284092"),
            BigInt("4767280812573897164771"),
            BigInt("183356954329765275567"),
            BigInt("7052190551144818290"),
            BigInt("271238098120954548"),
            BigInt("10432234543113635"),
            BigInt("401239790119754"),
            BigInt("15432299619989"),
            BigInt("593549985383"),
            BigInt("22828845590"),
            BigInt("878032521"),
            BigInt("33770480"),
            BigInt("1298863"),
            BigInt("49955"),
            BigInt("1920"),
            BigInt("72"),
            BigInt("1"),
        ]
    
    private static var MagicSalt = "4a5e1e4baab89f3a32518a88c31bc87f618f76673e2cc77ab2127b7afdeda33b"
    
    private static var MagicSymbol = "!"

    private static var MagicCapital = "A"

    public init() { }
    
    public func computePassword(k: String, l: String, passwordLen: Int = Dono.MAX_DK_LEN, addFixedSymbol: Bool = false, addFixedCapital: Bool = false) -> String?
    {
        if (k.characters.count < Dono.MIN_KEY_LENGTH)
        {
            return nil
        }
        
        if (passwordLen > Dono.MAX_DK_LEN)
        {
            return nil
        }
        
        l.lowercaseString
        
        let c = getIterations(k)

        var dkLen = passwordLen
        dkLen = addFixedSymbol ? dkLen - 1 : dkLen
        dkLen = addFixedCapital ? dkLen - 1 : dkLen
        
        var d = derivePassword(k, l: l, c: c, dkLen: dkLen)
        
        if (addFixedSymbol)
        {
            d += Dono.MagicSymbol
        }

        if (addFixedCapital)
        {
            d += Dono.MagicCapital
        }
        
        return d
    }
    
    private func derivePassword(k: String, l: String, c: Int, dkLen: Int) -> String
    {
        let password: [UInt8] = k.utf8.map {$0}
        
        let s = (k + l + Dono.MagicSalt).sha256()
        
        let salt: [UInt8] = s.utf8.map {$0}
        
        let d = try! PKCS5.PBKDF2(password: password, salt: salt, iterations: c, keyLength: 256, variant: .sha256)
                            .calculate()
                            .toHexString()
                            .characters
        
        return String(d.dropLast(d.count - dkLen))
    }

    private func getIterations(k: String) -> Int
    {
        if (k.characters.count < Dono.Iterations.count)
        {
            return Int(Dono.Iterations[k.characters.count].description)!
        }
        else
        {
            return Int(Dono.Iterations[Dono.Iterations.count - 1].description)!
        }
    }
}
