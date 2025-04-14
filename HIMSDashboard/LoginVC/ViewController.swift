//
//  ViewController.swift
//  HIMSDashboard
//
//  Created by ATHENTECH INDIA on 17/07/23.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var locationView: UIView!
    @IBOutlet weak var mobileView: UIView!
    @IBOutlet weak var passwordView: UIView!
    @IBOutlet weak var loginBtn: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupDesign()
     }
    
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    func setupDesign() {
        locationView.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 10)
        locationView.clipsToBounds = true
        
        mobileView.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 10)
        mobileView.clipsToBounds = true
        
        passwordView.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 10)
        passwordView.clipsToBounds = true
        loginBtn.roundCorners([.topLeft, .topRight, .bottomLeft, .bottomRight], radius: 10)
        loginBtn.clipsToBounds = true
        
    }
    
@IBAction func loginActBtn(_ sender: UIButton) {
    
    let vc = self.storyboard?.instantiateViewController(withIdentifier: StoryBoardIdentifiers.HomeVC) as! HomeVC
    self.navigationController?.pushViewController(vc, animated: true)
    }
    
    
}

