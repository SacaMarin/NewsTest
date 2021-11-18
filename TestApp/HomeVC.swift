//
//  HomeVC.swift
//  TestApp
//
//  Created by Marin Saca on 16.11.2021.
//

import UIKit

class HomeVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var cornerView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        setupViews()
    }
    
    func setupViews() {
        StyleSheets.apply(for: self)
    }

}
