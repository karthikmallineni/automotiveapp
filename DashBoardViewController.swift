//
//  DashBoardViewController.swift
//  AutomotiveApp
//
//  Created by Vijayalakshmi on 9/20/17.
//  Copyright © 2017 Vijayalakshmi. All rights reserved.
//

import UIKit
import AWSS3
import AWSCore

class DashBoardViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    var imageArray:NSMutableArray!
    var downloadImage:UIImage?
    var downloadError:NSError!
    var imageURL:String?
    var productTitle:String?
    var productMileage:String?
    var productArr:NSArray?
     var dataArray:NSArray?
    var nameArray:NSMutableArray!
    var millegeArray:NSMutableArray!
    var specificImage:UIImage!
    var productFuelArray:NSMutableArray!
    var mileageCityArray:NSMutableArray!
    var engineArray:NSMutableArray!
    var bhpArray:NSMutableArray!
   
    var activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: UIActivityIndicatorViewStyle.gray)

    @IBOutlet var dashBoardTableview: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        activityIndicator.activityIndicatorViewStyle  = UIActivityIndicatorViewStyle.white;
        activityIndicator.center = view.center;
        dashBoardTableview.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        self.imageArray=NSMutableArray()
        self.downloadData(key: "car1.jpg")
        self.downloadData(key: "car2.jpg")
        self.downloadData(key: "car3.jpeg")
        print(self.imageArray)
         self.nameArray = NSMutableArray()
        self.millegeArray = NSMutableArray()
        self.getData()
    
    }
  
    
    // Getting data from json
    
    
        func getData() {
        if let path = Bundle.main.path(forResource: "DummyData", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                do{
                    
                    let json =  try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                    
                    print(json)
                    
                    let jsonDictionary =  json as! Dictionary<String,Any>
                    for (key, value) in jsonDictionary {
                        
                        print("\(key) - \(value) ")
                        
                    }
                    
                    dataArray = jsonDictionary["Data"] as! Array<Dictionary<String,Any>> as NSArray
                    for (_, element) in (self.dataArray?.enumerated())!
                    {
                        if let element = element as? NSDictionary{
                            
                            self.nameArray.add((element.value(forKey: "name") as! String))
                            self.imageURL = (element.value(forKey: "urlimage") as! String)
                            self.millegeArray.add(element.value(forKey: "Mileage") as! String)
                            
                            
                        }
                    }
    
                    productArr = jsonDictionary["product"] as? Array<Dictionary<String,Any>> as NSArray?
                    
                   
                }catch let error{
                    
                    print(error.localizedDescription)
                }
                
            } catch let error {
                print(error.localizedDescription)
            }
        } else {
            print("Invalid filename/path.")
        }
        
    }
    
    // Downloading image from amazon s3.
    
    func downloadData(key: String)
    {
        
        let transferManager = AWSS3TransferManager.default()
        
        let downloadingFileURL = URL(fileURLWithPath: NSTemporaryDirectory()).appendingPathComponent(key)
        
        let downloadRequest = AWSS3TransferManagerDownloadRequest()
        
        downloadRequest?.bucket = "dert345"
        downloadRequest?.key = key
        downloadRequest?.downloadingFileURL = downloadingFileURL
        
        
        transferManager.download(downloadRequest!).continueWith(executor: AWSExecutor.default(), block: { (task:AWSTask<AnyObject>) -> Any? in
            
            if let error = task.error as NSError? {
                if error.domain == AWSS3TransferManagerErrorDomain, let code = AWSS3TransferManagerErrorType(rawValue: error.code) {
                    switch code {
                    case .cancelled, .paused:
                        break
                    default:
                        print("Error downloading: \(String(describing: downloadRequest?.key)) Error: \(error)")
                    }
                } else {
                    print("Error downloading: \(String(describing: downloadRequest?.key)) Error: \(error)")
                }
                return nil
            }
            else{
                if task.result != nil{
                    
                     self.imageArray.add(UIImage(contentsOfFile: downloadingFileURL.path)!)
                    print(self.imageArray)
                    self.dashBoardTableview .reloadData()
                    self.activityIndicator.stopAnimating()
                    
                    print("Download complete for: \(String(describing: downloadRequest?.key!))")

                }
            }
            
            return nil
        })
        
    }
    
    
    // Do any additional setup after loading the view.
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
  
    //Tableview delegate methods
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) ->UITableViewCell    {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! DashBoardTableViewCell
      print(nameArray)
        print(imageArray)
        
        
        if(imageArray.count == 3 )
        {
           cell.carImage.image = self.imageArray.object(at: indexPath.row) as? UIImage
            cell.productName.text = self.nameArray.object(at: indexPath.row) as? String
            cell.productMileage.text = self.millegeArray.object(at: indexPath.row) as? String
        }
            self.dashBoardTableview.separatorColor = UIColor.clear
            cell.selectionStyle = .none
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let secondViewController = self.storyboard?.instantiateViewController( withIdentifier: "ProductDescriptionViewController") as! ProductDescriptionViewController
         secondViewController.specificImage = self.imageArray.object(at:indexPath.row) as! UIImage
        var productDictionary:NSDictionary!
        productDictionary=productArr?.object(at: indexPath.row) as! NSDictionary
        let values = Array(productDictionary.allValues) as! NSMutableArray
        secondViewController.productDescriptionArray=values 
        self.present(secondViewController, animated: true, completion: nil)
 }
    
}

/*
 // MARK: - Navigation
 
 // In a storyboard-based application, you will often want to do a little preparation before navigation
 override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
 // Get the new view controller using segue.destinationViewController.
 // Pass the selected object to the new view controller.
 }
 */
