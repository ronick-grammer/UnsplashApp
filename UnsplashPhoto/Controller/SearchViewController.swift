//
//  SearchViewController.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/06.
//

import Foundation
import UIKit
import SnapKit

class SearchViewController: UITableViewController {
    
    private let cellIdentifier = "SearchCell"
    
    private var searchController = UISearchController()
    
    private var barButton: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem()
        barButtonItem.title = "로그인"
        
        return barButtonItem
    }()
    
    
    
    override func viewDidLoad() {


        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(SearchCell.self, forCellReuseIdentifier: cellIdentifier)
        
        navigationItem.searchController = searchController
        navigationItem.title = "Search"
        navigationItem.rightBarButtonItem = barButton
        navigationItem.hidesSearchBarWhenScrolling = false
        
        setUpSearchView()
        
        
    }
    
    private func setUpLayout() {
        
        
    }
    
    private func setUpSearchView(){
        searchController.delegate = self
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchBar.placeholder = "사진을 검색하세요"
        
    }
    
}

// MARK: - UITableViewControllerDelegate
extension SearchViewController{
    
}

// MARK: - UITableViewDataSource
extension SearchViewController{

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 11
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 10
    }
    
    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView()
        headerView.backgroundColor = UIColor.clear
        
        return headerView
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 300
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! SearchCell
        
        cell.configure(photo: UIImage(named: "restraurant_1")!, name: "Kevin", likes: 13)


        return cell
    }

}





// MARK: - UISearchControllerDelegate
extension SearchViewController: UISearchControllerDelegate {
    
}

// MARK: - UISearchResultsUpdater
extension SearchViewController: UISearchResultsUpdating {
    
    func updateSearchResults(for searchController: UISearchController) {
        
    }
    
}

// MARK: - UISearchBarDelegate
extension SearchViewController: UISearchBarDelegate {
    
}


// MARK: - Preview
#if DEBUG

import SwiftUI

struct SearchViewController_Preview: PreviewProvider {
    
    static var previews: some View {
        
        UIViewControllerPreview {
            let navController = UINavigationController(rootViewController: SearchViewController())
            navController.navigationBar.backgroundColor = .white
            return navController
            
        }
        
    }
    
}


#endif
