//
//  ViewController.swift
//  AutomotiveApp
//
//  Created by Vijayalakshmi on 9/11/17.
//  Copyright © 2017 Vijayalakshmi. All rights reserved.
//

import UIKit
import AWSS3
import NetworkExtension
import Security

 var keychain : KeychainClass?

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
         keychain = KeychainClass()
         keychain?.save(service: "asmltd1", data: <#NSString#>)
        
        createTheConfiguration()
        
        // Do any additional setup after loading the view, typically from a nib.
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(sender:)), name:NSNotification.Name.UIKeyboardWillShow, object: nil);
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(sender:)), name:NSNotification.Name.UIKeyboardWillHide, object: nil);
    }

        
    func keyboardWillShow(sender: NSNotification) {
        self.view.frame.origin.y = -150 // Move view 150 points upward
    }
    
    func keyboardWillHide(sender: NSNotification) {
        self.view.frame.origin.y = 0 // Move view to original position
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func createTheConfiguration() {
        
        let manager = NEVPNManager.shared()
        manager.loadFromPreferences { (error) -> Void in
            
            if((error) != nil) {
                print("VPN Preferences error")
            }
            else {
                let vpnProtocol = NEVPNProtocolIPSec()
                vpnProtocol.username = "vpnuser1"
                vpnProtocol.serverAddress = "106.51.73.150"
                vpnProtocol.passwordReference = keychain?.load(service: "asmltd1")
                print(vpnProtocol.passwordReference!)
                vpnProtocol.authenticationMethod = NEVPNIKEAuthenticationMethod.sharedSecret
                //p.sharedSecretReference = KeychainService.dataForKey("sharedSecret")!
                print(vpnProtocol.sharedSecretReference!)
                vpnProtocol.localIdentifier = "vpn"
                vpnProtocol.remoteIdentifier = "vpn"
                vpnProtocol.disconnectOnSleep = false
                
                
                manager.`protocolConfiguration` = vpnProtocol
                manager.isOnDemandEnabled = true
                manager.localizedDescription = "VPN"
                
                manager.saveToPreferences(completionHandler: { (error) -> Void in
                    if((error) != nil) {
                        print("VPN Preferences error: 2")
                        print(error!)
                    }
                    else {
                       
                        do {
                            try manager.connection.startVPNTunnel()
                        } catch let error {
                            print("Error starting VPN Connection \(error.localizedDescription)");
                        }
                        
                    }
                        
                        
                    })
                }
        }
    }
    
            
    
            
            
            
            
            
                    }
    
    





