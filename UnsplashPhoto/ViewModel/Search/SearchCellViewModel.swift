//
//  SearchCellViewModel.swift
//  UnsplashPhoto
//
//  Created by RONICK on 2021/12/12.
//

import Foundation
import RxSwift
import RxCocoa

class SearchCellViewModel: ViewModelType {
    
    struct Input {
        let likeButtonClicked: Observable<Void>
    }
    
    struct Output {
        let photo: Observable<Photo?>
    }
    
    let photoId: String
    let likedByMe: Bool
    var disposeBag = DisposeBag()
    
    init(photoId: String, likedByMe: Bool) {
        self.photoId = photoId
        self.likedByMe = likedByMe
//        checkIfUserLikedPhoto()
    }
    
    func transform(input: Input) -> Output {
        let photo = input.likeButtonClicked
            .scan(likedByMe) { old, _ in
                print("likedByMe: ", self.likedByMe)
                return !old
            }.flatMap { liked -> Observable<Photo?> in
                return liked ? self.like() : self.unlike()
            }
        
        return Output(photo: photo)
    }
    
    func like() -> Observable<Photo?> {
        
//        UserService.like(photoID: photo.value.id) { [weak self] in
//            guard let self = self else { return }
//
//            var newPhoto = self.photo.value
//            newPhoto.likes += 1
//            newPhoto.liked_by_user = true
//
//            self.photo.accept(newPhoto)
//        }
        return UserService.like(photoID:photoId)
    }
    
    func unlike() -> Observable<Photo?> {
        
//        UserService.unlike(photoID: photo.value.id) { [weak self] in
//            guard let self = self else { return }
//
//            var newPhoto = self.photo.value
//            newPhoto.likes -= 1
//            newPhoto.liked_by_user = false
//
//            self.photo.accept(newPhoto)
//        }
        return UserService.unlike(photoID: photoId)
    }
    
    // 셀을 로드할 때마다 좋아요 상태를 체크
//    func checkIfUserLikedPhoto() {
//
//        UserService.checkIfUserLikedPhoto(photoID: photo.value.id) { [weak self] photoInstance in
//            guard let self = self else { return }
//
//            var newPhoto = self.photo.value
//            newPhoto.likes = photoInstance.likes
//            newPhoto.liked_by_user = photoInstance.liked_by_user
//            self.photo.accept(newPhoto)
//        }
//
//    }
}
