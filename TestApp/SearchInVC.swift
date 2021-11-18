//
//  SearchInVC.swift
//  TestApp
//
//  Created by Marin Saca on 17.11.2021.
//

import UIKit

class SearchInVC: UIViewController {
    
    @IBOutlet weak var searchInTitle: UISwitch!
    @IBOutlet weak var searchInDescription: UISwitch!
    @IBOutlet weak var searchInContent: UISwitch!
    
    let viewModel = SearchVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupViews()
    }
    
    func setupViews() {
        searchInTitle.setOn(viewModel.getTitleSearch(), animated: true)
        searchInDescription.setOn(viewModel.getDescSearch(), animated: true)
        searchInContent.setOn(viewModel.getContentSearch(), animated: true)
    }
    
    @IBAction func setTitleValue(_ sender: UISwitch) {
        viewModel.setTitleSearch(with: sender.isOn)
    }
    
    @IBAction func setDescriptionValue(_ sender: UISwitch) {
        viewModel.setDescrSearch(with: sender.isOn)
    }
    
    @IBAction func setContentValue(_ sender: UISwitch) {
        viewModel.setContentSearch(with: sender.isOn)
    }
    
    @IBAction func backAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func applyChangesAction(_ sender: Any) {
        Config.titleSearch = viewModel.getTitleSearch()
        Config.descrSearch = viewModel.getDescSearch()
        Config.contentSearch = viewModel.getContentSearch()
        
        self.navigationController?.popViewController(animated: true)
    }
    
}
