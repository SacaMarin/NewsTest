//
//  NewsVC.swift
//  TestApp
//
//  Created by Marin Saca on 16.11.2021.
//

import UIKit

class NewsVC: UIViewController {

    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var loadingIndicator: UIActivityIndicatorView!
    
    let viewModel = NewsVM()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        getArticles()
        // Do any additional setup after loading the view.
    }

    override func viewDidAppear(_ animated: Bool) {
        setupViews()
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = R.segue.newsVC.showArticleWeb(segue: segue)?.destination {
            vc.viewModel.setSelectedArticle(with: viewModel.getSelectedArticle())
        }
    }
    
    func setupViews() {
        StyleSheets.apply(for: self)
    }
    
    private func getArticles() {
        loadingIndicator.startAnimating()
        
        viewModel.getTopHeadlinesArticles(with: self) { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.loadingIndicator.stopAnimating()
                    
                }
            }
        }
    }
    
    fileprivate func showSelectedArticle(with indexRow: Int) {
        viewModel.selectArticleForRow(for: indexRow)
        performSegue(withIdentifier: R.segue.newsVC.showArticleWeb, sender: self)
    }
}

extension NewsVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.getArticlesCount()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "newsCell") as! NewsCell
        cell.selectionStyle = .none
        cell.setup(with: viewModel.getArticlesForRow(for: indexPath.row))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 128
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        showSelectedArticle(with: indexPath.row)
    }
    
}
