//
//  NextViewController.swift
//  TableView
//
//  Created by 柴田優河 on 2021/02/14.
//

import UIKit

class NextViewController: UIViewController {
        
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        self.navigationController?.setNavigationBarHidden(false, animated: false) // navigationbarを表示する
    }
    
    override func viewWillLayoutSubviews() {
        configure()

    }

    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.navigationBar.alpha = 0.0
        // Do any additional setup after loading the view.
    }
    
    func configure() {
        let navigationBarHeight = self.navigationController?.navigationBar.frame.size.height
        self.view.frame = CGRect(x: 0, y: navigationBarHeight!, width: view.frame.size.width, height: self.view.frame.size.height - navigationBarHeight!)
    }
}
