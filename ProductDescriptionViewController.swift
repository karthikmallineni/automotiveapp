//
//  ProductDescriptionViewController.swift
//  AutomotiveApp
//
//  Created by Vijayalakshmi on 9/20/17.
//  Copyright © 2017 Vijayalakshmi. All rights reserved.
//

import UIKit

class ProductDescriptionViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    @IBOutlet weak var productDescriptionTableview: UITableView!
    @IBOutlet weak var productImageView: UIImageView!
    var featureName:NSMutableArray!
    var specificImage:UIImage!
   
    var productDescriptionArray:NSMutableArray!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.productImageView.image = specificImage
        
        self.featureName=["Millege(ARAI)kmpl","Millege(city)kmpl","Fuel Type","Engiene Displacement","BHP"]
        
        
    
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return  self.featureName.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell    {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ProductDescriptionTableViewCell
        cell.nameLbl.text = self.featureName.object(at: indexPath.row) as? String
        cell.descriptionLbl.text = self.productDescriptionArray.object(at: indexPath.row) as? String
        
        self.productDescriptionTableview.separatorColor = UIColor.clear
        //[cell
        cell.selectionStyle = .none
        return cell
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
