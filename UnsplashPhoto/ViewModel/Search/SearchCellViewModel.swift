//
//  SearchCellViewModel.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/12.
//

import Foundation
import RxSwift
import RxCocoa

class SearchCellViewModel {
    
    var photo: BehaviorRelay<Photo>
    let disposeBag = DisposeBag()
    
    init(photo: Photo) {
        self.photo = BehaviorRelay<Photo>.init(value: photo)
        checkIfUserLikedPhoto()
    }
    
    func like() {
        
        UserService.like(photoID: photo.value.id) { [weak self] in
            guard let self = self else { return }
            
            var newPhoto = self.photo.value
            newPhoto.likes += 1
            newPhoto.liked_by_user = true
            
            self.photo.accept(newPhoto)
        }
    }
    
    func unlike() {
        
        UserService.unlike(photoID: photo.value.id) { [weak self] in
            guard let self = self else { return }
            
            var newPhoto = self.photo.value
            newPhoto.likes -= 1
            newPhoto.liked_by_user = false
            
            self.photo.accept(newPhoto)
        }
    }
    
    // 셀을 로드할 때마다 좋아요 상태를 체크
    func checkIfUserLikedPhoto() {
        
        UserService.checkIfUserLikedPhoto(photoID: photo.value.id) { [weak self] photoInstance in
            guard let self = self else { return }
            
            var newPhoto = self.photo.value
            newPhoto.likes = photoInstance.likes
            newPhoto.liked_by_user = photoInstance.liked_by_user
            self.photo.accept(newPhoto)
        }
        
    }
}
