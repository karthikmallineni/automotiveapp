//
//  NewUserViewcontrollerViewController.swift
//  AutomotiveApp
//
//  Created by Vijayalakshmi on 9/22/17.
//  Copyright © 2017 Vijayalakshmi. All rights reserved.
//

import UIKit

class NewUserViewcontrollerViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
navigationController?.navigationBar.barTintColor = UIColor(colorLiteralRed: 60/255, green: 124/255, blue: 202/255, alpha: 1)
    navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.white]
       self.navigationItem.title = "New User"
    }
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.view.endEditing(true)
        return false
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
