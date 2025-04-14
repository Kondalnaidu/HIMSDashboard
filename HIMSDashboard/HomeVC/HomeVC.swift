//
//  HomeVC.swift
//  HIMSDashboard
//
//  Created by ATHENTECH INDIA on 17/07/23.
//

import UIKit
import SideMenu
class HomeVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
     }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
@IBAction func sideMenuActBtn(_ sender: UIButton) {
    
}
     
}
