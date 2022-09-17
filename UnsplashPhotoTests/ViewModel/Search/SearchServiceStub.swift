//
//  SearchServiceMock.swift
//  UnsplashPhotoTests
//
//  Created by RONICK on 2022/05/06.
//

import Foundation
import RxSwift
@testable import UnsplashPhoto

class SearchServiceStub: SearchServiceProtocol {
    
    let photoResultsResponse: [String: Any] = [
        "results": [
            [
                "id": "jNvdetcgz4Y",
                "likes": 4,
                "liked_by_user": false,
                "user": [
                    "username": "yloryb",
                    "name": "Ýlona María Rybka",
                    "profile_image": [
                        "medium": "https://images.unsplash.com/profile-1573409782840-b562ea569ea7image?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64"
                    ]
                ],
                "urls": [
                    "regular": "https://images.unsplash.com/photo-1570400576439-d677fe6c7880?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyODE4Mjl8MHwxfHNlYXJjaHwxfHxOYXR1cmV8ZW58MHx8fHwxNjUxODI0MjEy&ixlib=rb-1.2.1&q=80&w=1080"
                ]
            ],
            
            [
                "id": "NT5jeCTvqQY",
                "likes": 3,
                "liked_by_user": false,
                "user": [
                    "username": "bruno_adam",
                    "name": "Bruno Adam",
                    "profile_image": [
                        "medium": "https://images.unsplash.com/profile-1589333091957-dd3ace4b5735image?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64"
                    ]
                ],
                "urls": [
                    "regular": "https://images.unsplash.com/photo-1585108229701-9ed4665d8a45?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyODE4Mjl8MHwxfHNlYXJjaHwyfHxOYXR1cmV8ZW58MHx8fHwxNjUxODI0MjEy&ixlib=rb-1.2.1&q=80&w=1080"
                ]
            ],
            
            [
                "id": "EwKXn5CapA4",
                "likes": 10731,
                "liked_by_user": false,
                "user": [
                    "username": "jeremybishop",
                    "name": "Jeremy Bishop",
                    "profile_image": [
                        "medium": "https://images.unsplash.com/profile-1610519305252-c9d552283aaaimage?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64"
                    ]
                ],
                "urls": [
                    "regular": "https://images.unsplash.com/photo-1518495973542-4542c06a5843?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyODE4Mjl8MHwxfHNlYXJjaHwzfHxOYXR1cmV8ZW58MHx8fHwxNjUxODI0MjEy&ixlib=rb-1.2.1&q=80&w=1080"
                ]
            ],
            
            [
                "id": "4rDCa5hBlCs",
                "likes": 8929,
                "liked_by_user": false,
                "user": [
                    "username": "mischievous_penguins",
                    "name": "Casey Horner",
                    "profile_image": [
                        "medium": "https://images.unsplash.com/profile-1502669002421-a8d274ad2897?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64"
                    ]
                ],
                "urls": [
                    "regular": "https://images.unsplash.com/photo-1513836279014-a89f7a76ae86?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyODE4Mjl8MHwxfHNlYXJjaHw0fHxOYXR1cmV8ZW58MHx8fHwxNjUxODI0MjEy&ixlib=rb-1.2.1&q=80&w=1080"
                ]
            ],
            
            [
                "id": "sMQiL_2v4vs",
                "likes": 5411,
                "liked_by_user": false,
                "user": [
                    "username": "veeterzy",
                    "name": "veeterzy",
                    "profile_image": [
                        "medium": "https://images.unsplash.com/profile-1506670759095-e8bab484cbc5?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64"
                    ]
                ],
                "urls": [
                    "regular": "https://images.unsplash.com/photo-1453791052107-5c843da62d97?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyODE4Mjl8MHwxfHNlYXJjaHw1fHxOYXR1cmV8ZW58MHx8fHwxNjUxODI0MjEy&ixlib=rb-1.2.1&q=80&w=1080"
                ]
            ],
            
            [
                "id": "78A265wPiO4",
                "likes": 7808,
                "liked_by_user": false,
                "user": [
                    "username": "davidmarcu",
                    "name": "David Marcu",
                    "profile_image": [
                        "medium": "https://images.unsplash.com/profile-1586795246793-9a7d890a432bimage?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64"
                    ]
                ],
                "urls": [
                    "regular": "https://images.unsplash.com/photo-1469474968028-56623f02e42e?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyODE4Mjl8MHwxfHNlYXJjaHw2fHxOYXR1cmV8ZW58MHx8fHwxNjUxODI0MjEy&ixlib=rb-1.2.1&q=80&w=1080"
                ]
            ],
            
            [
                "id": "igX2deuD9lc",
                "likes": 2943,
                "liked_by_user": false,
                "user": [
                    "username": "cmreflections",
                    "name": "Clément M.",
                    "profile_image": [
                        "medium": "https://images.unsplash.com/profile-1649703067755-b2937320c07eimage?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64"
                    ]
                ],
                "urls": [
                    "regular": "https://images.unsplash.com/photo-1509316975850-ff9c5deb0cd9?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyODE4Mjl8MHwxfHNlYXJjaHw3fHxOYXR1cmV8ZW58MHx8fHwxNjUxODI0MjEy&ixlib=rb-1.2.1&q=80&w=1080"
                ]
            ],
            
            [
                "id": "cssvEZacHvQ",
                "likes": 2919,
                "liked_by_user": false,
                "user": [
                    "username": "blakeverdoorn",
                    "name": "Blake Verdoorn",
                    "profile_image": [
                        "medium": "https://images.unsplash.com/profile-1471894155967-749fe500172d?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64"
                    ]
                ],
                "urls": [
                    "regular": "https://images.unsplash.com/photo-1433086966358-54859d0ed716?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyODE4Mjl8MHwxfHNlYXJjaHw4fHxOYXR1cmV8ZW58MHx8fHwxNjUxODI0MjEy&ixlib=rb-1.2.1&q=80&w=1080"
                ]
            ],
            
            [
                "id": "eOpewngf68w",
                "likes": 4985,
                "liked_by_user": false,
                "user": [
                    "username": "timswaanphotography",
                    "name": "Tim Swaan",
                    "profile_image": [
                        "medium": "https://images.unsplash.com/profile-1563477652977-77551f72b3b2?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64"
                    ]
                ],
                "urls": [
                    "regular": "https://images.unsplash.com/photo-1447752875215-b2761acb3c5d?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyODE4Mjl8MHwxfHNlYXJjaHw5fHxOYXR1cmV8ZW58MHx8fHwxNjUxODI0MjEy&ixlib=rb-1.2.1&q=80&w=1080"
                ]
            ],
            
            [
                "id": "01_igFr7hd4",
                "likes": 5536,
                "liked_by_user": false,
                "user": [
                    "username": "ideasboom",
                    "name": "Qingbao Meng",
                    "profile_image": [
                        "medium": "https://images.unsplash.com/profile-1536207867484-ee3f39fa0ee9?ixlib=rb-1.2.1&q=80&fm=jpg&crop=faces&cs=tinysrgb&fit=crop&h=64&w=64"
                    ]
                ],
                "urls": [
                    "regular": "https://images.unsplash.com/photo-1501854140801-50d01698950b?crop=entropy&cs=tinysrgb&fit=max&fm=jpg&ixid=MnwyODE4Mjl8MHwxfHNlYXJjaHwxMHx8TmF0dXJlfGVufDB8fHx8MTY1MTgyNDIxMg&ixlib=rb-1.2.1&q=80&w=1080"
                ]
            ]
        ]
    ]
    func searchImage(query: String, page: Int, perPage: Int) -> Observable<PhotoResults> {
        let data = try! JSONSerialization.data(withJSONObject: photoResultsResponse, options: .prettyPrinted)
        let photoResults = try! JSONDecoder().decode(PhotoResults.self, from: data)
        
        return Observable.just(photoResults)
    }
}
