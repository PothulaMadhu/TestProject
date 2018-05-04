//
//  HomeVC.swift
//  SideMenuSwift
//
//  Created by Madhusudan Reddy on 13/04/18.
//  Copyright © 2018 Madhusudan Reddy. All rights reserved.
//

import UIKit

class HomeVC: UIViewController, UITabBarDelegate {

    @IBOutlet weak var tabBar: UITabBar!
    override func viewDidLoad() {
        super.viewDidLoad()
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
}
