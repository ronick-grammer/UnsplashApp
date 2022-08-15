//
//  SearchViewController.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/06.
//

import Foundation
import UIKit
import RxSwift
import RxCocoa

class SearchViewController: UITableViewController {
    
    private let cellIdentifier = "SearchCell"
    
    private var searchController = UISearchController()

    private let disposeBag = DisposeBag()
    
    private var searchViewModel = SearchViewModel()
    
    private let fetchPhotoes =  PublishSubject<Void>()
    
    lazy var input = SearchViewModel.Input(
        initialize: BehaviorSubject<Void>.init(value: Void()),
        searchButtonClicked: searchController.searchBar.rx.searchButtonClicked.asObservable(),
        searchQuery: searchController.searchBar.rx.text.asObservable(),
        page: BehaviorSubject<Int>.init(value: 1),
        didScroll: toTuple(),
        fetchPhotoes: fetchPhotoes.asObservable()
    )
    
    lazy var output = searchViewModel.transform(input: input)
    
    override func viewDidLoad() {
        
        tableView.dataSource = nil
        tableView.delegate = self
        tableView.register(SearchCell.self, forCellReuseIdentifier: cellIdentifier)
        tableView.allowsSelection = false
        
        setUpSearchView()
        bind()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.navigationBar.topItem?.title = "Search"
        navigationController?.navigationBar.topItem?.searchController = searchController
        navigationController?.navigationBar.topItem?.hidesSearchBarWhenScrolling = false
//        tableView.reloadData()
        fetchPhotoes.onNext(())
    }
    
    private func bind() {
        
        AuthManager.shared.loggedIn
            .observeOn(MainScheduler.instance)
            .subscribe(onNext: { [weak self] _ in

//                self?.tableView.reloadData()
                self?.fetchPhotoes.onNext(())

            }).disposed(by: disposeBag)
        
        output.searchedPhotoes
            .bind(to: tableView.rx.items(cellIdentifier: cellIdentifier, cellType: SearchCell.self))
            { index, item, cell in
                cell.configure(photo: item)
            }.disposed(by: disposeBag)
        
    }
    
    private func toTuple() ->  Observable<(contentOffsetY: CGFloat, contentSizeHeight: CGFloat, viewFrameHeight: CGFloat)> {
        tableView.rx.didScroll.flatMap { () -> Observable<(contentOffsetY: CGFloat, contentSizeHeight: CGFloat, viewFrameHeight: CGFloat)> in
            return Observable.just((self.tableView.contentOffset.y, self.tableView.contentSize.height, self.view.frame.height))
        }
    }
    
    private func setUpSearchView() {
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
