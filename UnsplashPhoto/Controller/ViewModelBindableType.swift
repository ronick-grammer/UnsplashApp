//
//  ViewModelBindableType.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2022/02/13.
//

import UIKit

protocol ViewModelBindableType {
    associatedtype ViewModelType
    
    var viewModel: ViewModelType { get set }
    func bindViewModel()
}
