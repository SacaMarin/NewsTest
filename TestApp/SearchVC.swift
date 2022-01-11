//
//  SearchVC.swift
//  TestApp
//
//  Created by Marin Saca on 16.11.2021.
//

import UIKit
import CoreData

class SearchVC: UIViewController {
    
    @IBOutlet weak var topView: UIView!
    @IBOutlet weak var cornerView: UIView!
    @IBOutlet weak var filterBtn: UIButton!
    @IBOutlet weak var sortBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var titleSearchTop: UILabel!
    @IBOutlet weak var sortByView: UIView!
    
    @IBOutlet weak var uploadedDateSortBtn: UIButton!
    @IBOutlet weak var relevanceSortBtn: UIButton!
    
    let viewModel = SearchVM()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        StyleSheets.apply(for: self)
        getHystoryDB()
    }
    
    func searchArticlesBy(with fromDate: String, with toDate: String) {
        viewModel.searchArticlesBy(for: self, with: fromDate, with: toDate) { error in
            if error == nil {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                    self.titleSearchTop.text = self.viewModel.getCountArticles() != 0 ? "\(self.viewModel.getResultCountArticles()) news" : "Search History"
                }
            }
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = R.segue.searchVC.showNewsAction(segue: segue)?.destination {
            vc.viewModel.setSelectedArticle(with: viewModel.getSelectedArticle())
        } else if let filterVc = R.segue.searchVC.showFilterVC(segue: segue)?.destination {
            filterVc.searchProtocol =  self
        }
    }
    
    @IBAction func filterAction(_ sender: Any) {
        performSegue(withIdentifier: R.segue.searchVC.showFilterVC, sender: self)
    }
    
    @IBAction func sortAction(_ sender: Any) {
        sortByView.isHidden = !sortByView.isHidden
    }
    
    @IBAction func sortByDateAction(_ sender: Any) {
        Config.sortBy = Config.sortByDate
        self.uploadedDateSortBtn.setImage(UIImage(named: "selected"), for: .normal)
        self.relevanceSortBtn.setImage(UIImage(named: "unselected"), for: .normal)
        self.searchArticlesBy(with: "", with: "")
        sortByView.isHidden = !sortByView.isHidden
    }
    
    @IBAction func sortByRelevanceAction(_ sender: Any) {
        Config.sortBy = Config.sortByRelevance
        self.uploadedDateSortBtn.setImage(UIImage(named: "unselected"), for: .normal)
        self.relevanceSortBtn.setImage(UIImage(named: "selected"), for: .normal)
        self.searchArticlesBy(with: "", with: "")
        sortByView.isHidden = !sortByView.isHidden
    }
    
    fileprivate func showSelectedArticle(with indexRow: Int) {
        viewModel.selectArticleForRow(for: indexRow)
        performSegue(withIdentifier: R.segue.searchVC.showNewsAction, sender: self)
    }
    
    private func saveSearchedTitles(with title: String) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let entity = NSEntityDescription.entity(forEntityName: "Hystory", in: context)
        let newTitle = NSManagedObject(entity: entity!, insertInto: context)
        
        newTitle.setValue(title, forKey: "title")
        
        do {
            try context.save()
        } catch {
            print("Failed saving")
        }
        
        
        getHystoryDB()
    }
    
    func getHystoryDB() {
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "Hystory")
        //request.predicate = NSPredicate(format: "age = %@", "12")
        request.returnsObjectsAsFaults = false
        
        do {
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let result = try context.fetch(request)
            Config.searchHystory.removeAll()
            
            for data in result as! [NSManagedObject] {
                Config.searchHystory.append(data.value(forKey: "title") as! String)
            }
            
            self.tableView.reloadData()
            self.titleSearchTop.text = self.viewModel.getCountArticles() != 0 ? "\(self.viewModel.getResultCountArticles()) news" : "Search History"
            
        } catch {
            print("Failed")
        }
        
    }
}

extension SearchVC: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.getCountArticles() == 0 {
            return Config.searchHystory.count
        }
        
        return viewModel.getCountArticles()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.getCountArticles() == 0 {
            let cell = tableView.dequeueReusableCell(withIdentifier: "SearchHystoryCell") as! SearchHystoryCell
            cell.selectionStyle = .none
            cell.setup(with: Config.searchHystory[indexPath.row])
            
            return cell
        }
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "NewsCellSearch") as! NewsCell
        cell.selectionStyle = .none
        cell.setup(with: viewModel.getArticleForRow(for: indexPath.row))
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel.getCountArticles() == 0 {
            return 43
        }
        
        return 128
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if viewModel.getCountArticles() > 0 {
            showSelectedArticle(with: indexPath.row)
        }
    }
    
}

extension SearchVC: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        guard let searchText = searchBar.text else {
            self.searchBar.endEditing(true)
            
            return
        }
        
        self.saveSearchedTitles(with: searchText)
        self.searchBar.endEditing(true)
        self.viewModel.setSearchWord(with: searchText)
        self.searchArticlesBy(with: "", with: "")
        self.searchBar.text = nil
    }
}

extension SearchVC: FilterSearchProtocol {
    
    func searchByFilters(with dateFrom: String, with dateTo: String) {
        searchArticlesBy(with: dateFrom, with: dateTo)
    }
    
}
