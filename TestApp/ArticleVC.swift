//
//  ArticleVC.swift
//  TestApp
//
//  Created by Marin Saca on 17.11.2021.
//

import UIKit
import WebKit

class ArticleVC: UIViewController, WKNavigationDelegate {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var articleWebView: WKWebView!
    
    let viewModel = NewsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupViews()
    }
    
    func setupViews() {
        StyleSheets.apply(for: self)
        articleWebView.navigationDelegate = self
        
        guard let url = URL(string: viewModel.getSelectedArticle()?.url) else { return }
        articleWebView.load(URLRequest(url: url))
        articleWebView.allowsBackForwardNavigationGestures = true
    }

    @IBAction func goBackAction(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
}
