//
//  ViewModelType.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2022/02/13.
//

import Foundation
import RxSwift

protocol ViewModelType {
    associatedtype Input
    associatedtype Output
    
    var disposeBag: DisposeBag { get set }
    
    func transform(input: Input) -> Output
}
