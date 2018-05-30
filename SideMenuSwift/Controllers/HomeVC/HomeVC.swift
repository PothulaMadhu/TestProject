//
//  HomeVC.swift
//  SideMenuSwift
//
//  Created by Madhusudan Reddy on 13/04/18.
//  Copyright © 2018 Madhusudan Reddy. All rights reserved.
//

import UIKit
import Alamofire

class HomeVC: UIViewController, UITabBarDelegate {

    @IBOutlet weak var tabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
        networkFunction()
        tabBar.delegate = self;
        tabBar.isTranslucent = false
        title = "Home"
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Left", style: .plain, target: self, action: #selector(SSASideMenu.presentLeftMenuViewController))
        self.view.backgroundColor = UIColor.white
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    override func viewWillAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
    }
    override func viewDidAppear(_ animated: Bool) {
        UIApplication.shared.isStatusBarHidden = false
    }
    
    //MARK : - TabBar Delegate Methods
    
    public func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        if tabBar.tag == 0 {
            var vc: UIViewController? = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "ViewController")
            
          // UINavigationController.sharedInstance.popToRootAndSwitch(to: vc, with SlideOutAnimation: true, andCompletion: nil)
        }else if tabBar.tag == 1
        {
            
        }else
        {
            
        }
    }
    public func networkFunction() {
        
        let headers = [
            "Authorization": "Basic",
            "Accept": "application/json"
        ]
        let urlRequest = URLRequest(url: URL(string: "https://httpbin.org/get")!)
        let urlString = urlRequest.url?.absoluteString
         let parameters: Parameters = ["foo": "bar"]
        
        Alamofire.request("https://jsonplaceholder.typicode.com/todos/1", method: .get, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseData(queue: DispatchQueue.global(qos: .utility), completionHandler: { (response) in
            print(response)
        }).responseJSON(completionHandler: {response in
            print(response)
        })
        // Alamofire 4
        Alamofire.request("https://jsonplaceholder.typicode.com/todos/1", method: .get, parameters: parameters, encoding: JSONEncoding.default )
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                return .success
            }
            .responseJSON { response in
                debugPrint(response)
        }
        
        //Simple url request
        Alamofire.request("https://jsonplaceholder.typicode.com/todos/1").response { response in // method defaults to `.get`
            debugPrint(response)
        }
        
        //Download Request - Simple with URL string // Alamofire 4
        let destination = DownloadRequest.suggestedDownloadDestination()
        
        Alamofire.download("", to: destination).response { response in // method defaults to `.get`
            print(response.request)
            print(response.response)
            print(response.temporaryURL)
            print(response.destinationURL)
            print(response.error)
        }
        
        // Alamofire 4
        Alamofire.download(urlRequest, to: destination).validate().responseData { response in
            debugPrint(response)
            print(response.temporaryURL)
            print(response.destinationURL)
        }
        
        //Download Request - Complex with URL string
        
        // Alamofire 4
        let fileURL: URL
        let destination: DownloadRequest.DownloadFileDestination = { _, _ in
            return (fileURL, [.createIntermediateDirectories, .removePreviousFile])
        }
        
        Alamofire.download("", method: .get, parameters: parameters, encoding: JSONEncoding.default, to: destination)
            .downloadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, temporaryURL, destinationURL in
                // Custom evaluation closure now includes file URLs (allows you to parse out error messages if necessary)
                return .success
            }
            .responseJSON { response in
                debugPrint(response)
                print(response.temporaryURL)
                print(response.destinationURL)
        }
        
        //Upload Request - Simple with URL string
        // Alamofire 4
        Alamofire.upload(data, to: "").response { response in // method defaults to `.post`
            debugPrint(response)
        }
        
        // Alamofire 4
        Alamofire.upload(fileURL, with: urlRequest).validate().responseData { response in
            debugPrint(response)
        }
        
        //Upload Request - Complex with URL string
        
        // Alamofire 4
        Alamofire.upload(fileURL, to: urlString!, method: .put)
            .uploadProgress(queue: DispatchQueue.global(qos: .utility)) { progress in
                print("Upload Progress: \(progress.fractionCompleted)")
            }
            .downloadProgress { progress in // called on main queue by default
                print("Download Progress: \(progress.fractionCompleted)")
            }
            .validate { request, response, data in
                // Custom evaluation closure now includes data (allows you to parse data to dig out error messages if necessary)
                return .success
            }
            .responseJSON { response in
                debugPrint(response)
        }
        //https://github.com/Alamofire/Alamofire/blob/master/Documentation/Alamofire%204.0%20Migration%20Guide.md
    }
}


