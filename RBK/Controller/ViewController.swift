//
//  TableViewController.swift
//  ParseJSON
//
//  Created by Антон Зайцев on 14.06.2018.
//  Copyright © 2018 Антон Зайцев. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate {
    
    @IBOutlet weak var searchController: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let coreData = CoreDataManager()
    
    // Массив для данных из файла json
    var newsArray = [Articles]()
    
    // Массив из поискового запроса
    var filterNewsArray = [Articles]()
    
    // Переменная поиска
    var textSearch: String!
    var isSearching = false
    var api = APIManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Лента новостей RBK"
        
        // Подписываемся на протоколы
        tableView.delegate = self
        tableView.dataSource = self
        searchController.delegate = self
        
        // Вызываем функции
        addNavigationItem()
        addSearchBar()
        
        api.getData { [weak self] (article) in
            self?.newsArray = article
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
    }
    
    // Параметры navigationBar
    func addSearchBar() {
        navigationController?.navigationBar.tintColor = #colorLiteral(red: 0.1098039216, green: 0.6196078431, blue: 0.3960784314, alpha: 1)
        navigationController?.navigationBar.barTintColor = .black
        navigationController?.navigationBar.barStyle = .blackOpaque
        definesPresentationContext = true
    }
    // Параметры navigationController
    func addNavigationItem() {
        // Добавили 2 кнопки по краям, удалить и обновить.
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .trash, target: self, action: #selector(deleted))
        navigationItem.leftBarButtonItem = UIBarButtonItem(barButtonSystemItem: .play, target: self, action: #selector(refresh))
        navigationItem.searchController = UISearchController()
        navigationController?.navigationBar.tintColor = .black
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 0.1515978873, green: 0.5209135413, blue: 0.08649467677, alpha: 1)
        navigationController?.navigationBar.barStyle = .black
    }
    
    @objc func refresh() {
        let service = APIManager()
        service.getData { (result) in
            self.newsArray = result
            self.coreData.saveInCoreData(array: self.newsArray)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    @objc func deleted() {
        let ac = UIAlertController(title: "Вы точно хотите удалить данные?", message: "", preferredStyle: .actionSheet)
        let delete = UIAlertAction(title: "Удалить", style: .destructive) {
            (action: UIAlertAction) -> Void in
            self.coreData.clearData()
            self.newsArray.removeAll()
            self.tableView.reloadData()
        }
        let cancel = UIAlertAction(title: "Отмена", style: .cancel , handler: nil)
        ac.addAction(delete)
        ac.addAction(cancel)
        ac.view.tintColor = #colorLiteral(red: 0.1098039216, green: 0.6196078431, blue: 0.3960784314, alpha: 1)
        present(ac, animated: true, completion: nil)
    }
    
    // Функции tableView
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "customCell", for: indexPath) as! TableViewCell
        
        
        let course = isSearching ? filterNewsArray[indexPath.row] : newsArray[indexPath.row]
    
        cell.nameLabel?.text = course.title
        cell.detailLabel?.text = course.description
        
        let convertDate = stringToData(dateString: course.publishedAt)
        let date = dateToString(date: convertDate)
        cell.publisherDate?.text = date
        
        let completeLink = course.urlToImage
        cell.newsImage?.contentMode = .scaleToFill
        cell.newsImage?.downloadedFrom(link: completeLink)
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let course = isSearching ? filterNewsArray[indexPath.row] : newsArray[indexPath.row]
        let webVC = WebViewController()
        self.navigationController?.pushViewController(webVC, animated: true)
        webVC.url = course.url
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isSearching {
            return filterNewsArray.count
        }
        return newsArray.count
    }
    
    // Функции searchBar
    // Когда начинаешь вводить данные в поисковик
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        if searchBar.text == nil || searchBar.text == "" {
            isSearching = true
            self.tableView.reloadData()
            view.endEditing(true)
        } else {
            isSearching = true
            filterNewsArray = self.newsArray.filter { news in
                return news.title.lowercased().contains(searchText.lowercased())
            }
            print(filterNewsArray)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        isSearching = false
    }
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        isSearching = false
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 400
    }
}




