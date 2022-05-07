//
//  SearchViewModelTests.swift
//  UnsplashPhotoTests
//
//  Created by RONICK on 2022/03/25.
//

import XCTest
@testable import UnsplashPhoto
import RxSwift
import RxCocoa
import RxBlocking
import RxTest
import Nimble

class SearchViewModelTests: XCTestCase {
    
    var sut: SearchViewModel!
    var input: SearchViewModel.Input!
    var output: SearchViewModel.Output!

    var searchButtonClicked: PublishSubject<Void>!
    var searchQuery: PublishSubject<String?>!
    
    var disposeBag: DisposeBag!

    override func setUp() {
        super.setUp()
        sut = SearchViewModel(searchService: SearchServiceStub())
        searchButtonClicked = PublishSubject<Void>()
        searchQuery = PublishSubject<String?>()
        
        input = SearchViewModel.Input(
            initialize: BehaviorSubject<Void>.init(value: Void()),
            searchButtonClicked: searchButtonClicked.asObservable(),
            searchQuery: searchQuery.asObservable(),
            page: BehaviorSubject<Int>.init(value: 1),
            didScroll: Observable.just((300, 700, 730))
            )
        output = sut.transform(input: input)
        
        disposeBag = DisposeBag()
    }

    override func tearDown() {
        sut = nil
        input = nil
        output = nil
        searchButtonClicked = nil
        searchQuery = nil
        disposeBag = nil
        super.tearDown()
    }
    
    func test_init() {
        XCTAssertEqual(try! output.searchedPhotoes.toBlocking().first()?.count, 10)
    }
    
    

}
