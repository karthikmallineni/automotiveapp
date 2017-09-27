//
//  KeychainClass.swift
//  AutomotiveApp
//
//  Created by Vijayalakshmi on 9/27/17.
//  Copyright © 2017 Vijayalakshmi. All rights reserved.
//

import UIKit

class KeychainClass: NSObject {
    let passwordkey = "asmltd1"
    let userAccount = "AuthenticatedUser"
    
    let kSecClassValue = NSString(format: kSecClass)
    let kSecAttrAccountValue = NSString(format: kSecAttrAccount)
    let kSecValueDataValue = NSString(format: kSecValueData)
    let kSecClassGenericPasswordValue = NSString(format: kSecClassGenericPassword)
    let kSecAttrServiceValue = NSString(format: kSecAttrService)
    let kSecMatchLimitValue = NSString(format: kSecMatchLimit)
    let kSecReturnDataValue = NSString(format: kSecReturnData)
    let kSecMatchLimitOneValue = NSString(format: kSecMatchLimitOne)
    /**
     * Exposed methods to perform save and load queries.
     */
    
//    public class func savePassword(token: NSString) {
//        save(service: passwordkey, data: token)
//    }
//    
//    public class func loadPassword() -> NSString? {
//        return self.load(service: passwordkey)
//    }
    
    func save(service: NSString, data: NSString) {
        let dataFromString: NSData = data.data(using: String.Encoding.utf8.rawValue, allowLossyConversion: false)! as NSData
        
        // Instantiate a new default keychain query
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, userAccount, dataFromString], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecValueDataValue])
        
        // Delete any existing items
        SecItemDelete(keychainQuery as CFDictionary)
        
        // Add the new keychain item
        SecItemAdd(keychainQuery as CFDictionary, nil)
    }
    
    func load(service: NSString) -> NSString? {
        // Instantiate a new default keychain query
        // Tell the query to return a result
        // Limit our results to one item
        let keychainQuery: NSMutableDictionary = NSMutableDictionary(objects: [kSecClassGenericPasswordValue, service, userAccount, kCFBooleanTrue, kSecMatchLimitOneValue], forKeys: [kSecClassValue, kSecAttrServiceValue, kSecAttrAccountValue, kSecReturnDataValue, kSecMatchLimitValue])
        
        var dataTypeRef :AnyObject?
        
        // Search for the keychain items
        let status: OSStatus = SecItemCopyMatching(keychainQuery, &dataTypeRef)
        var contentsOfKeychain: NSString? = nil
        
        if status == errSecSuccess {
            if let retrievedData = dataTypeRef as? NSData {
                contentsOfKeychain = NSString(data: retrievedData as Data, encoding: String.Encoding.utf8.rawValue)
            }
        } else {
            print("Nothing was retrieved from the keychain. Status code \(status)")
        }
        
        return contentsOfKeychain
    }
}

