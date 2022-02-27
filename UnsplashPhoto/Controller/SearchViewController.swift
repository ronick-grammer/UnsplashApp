//
//  SearchViewController.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/06.
//

import Foundation
import UIKit
import RxSwift
//import RxCocoa

class SearchViewController: UITableViewController {
    
    private let cellIdentifier = "SearchCell"
    
    private var searchController = UISearchController()

    private let disposeBag = DisposeBag()
    
    private var searchViewModel = SearchViewModel()
    
    lazy var input = SearchViewModel.Input(
        searchButtonClicked: searchController.searchBar.rx.searchButtonClicked.asObservable(),
        searchQuery: searchController.searchBar.rx.text.asObservable()
    )
    
    lazy var output = searchViewModel.transform(input: input)
    
    override func viewDidLoad() {
        
        tableView.dataSource = nil
        tableView.delegate = self
        tableView.register(SearchCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.allowsSelection = false
        
        setUpSearchView()
        
        AuthManager.shared.loggedIn
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in

                self?.tableView.reloadData()

            }).disposed(by: disposeBag)
        
//        searchViewModel.photos
//            .observeOn(MainScheduler.instance)
//            .subscribe(onNext: { [weak self] _ in
//                print("Check Test: reloadData")
//                self?.tableView.reloadData()
//
//            }).disposed(by: disposeBag)
        
//        searchViewModel.photos
//            .observeOn(MainScheduler.instance)
//            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: SearchCell.self)) { index, item, cell in
//                print("Check Test: tableView")
//                cell.configure(photo: item)
//
//            }.disposed(by: disposeBag)
//
        
        output.searchedPhotoes
            .observeOn(MainScheduler.instance)
            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: SearchCell.self)) { index, item, cell in
                print("Check Test: tableView")
                cell.configure(photo: item)
            }.disposed(by: disposeBag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        navigationController?.navigationBar.topItem?.title = "Search"
        navigationController?.navigationBar.topItem?.searchController = searchController
        navigationController?.navigationBar.topItem?.hidesSearchBarWhenScrolling = false
        
        tableView.reloadData()
    }
    
    private func setUpSearchView(){
        searchController.delegate = self
        searchController.searchResultsUpdater = self
//        searchController.searchBar.delegate = self
        
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.hidesNavigationBarDuringPresentation = false
        
        searchController.searchBar.placeholder = "사진을 검색하세요"
        searchController.searchBar.returnKeyType = .search
        
    }

}

extension SearchViewController {
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        return 300
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
//extension SearchViewController: UISearchBarDelegate {
//    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
//        searchViewModel.searchImage(query: searchBar.text ?? "Nature")
//    }
//}
