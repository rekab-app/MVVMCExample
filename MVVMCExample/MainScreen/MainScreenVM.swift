//
//  MainScreenVM.swift
//  MVVMCExample
//
//  Created by Mehdi Sohrabi on 12/8/18.
//  Copyright © 2018 sixthsolution. All rights reserved.
//

import Common
import RxSwift
import RxCocoa
import SharedNetwork

enum PostResult {
    case success([Post]?)
    case error(Error)
    case loading
}

class MainScreenVM: BaseViewModel {
    let apiClient: ApiClient
    
    var isLoading: Driver<Bool>?
    var hasFailed: Driver<Error?>?
    var hasSucced: Driver<[Post]?>?
    
    let itemClicked: AnyObserver<Post>
    let didItemClicked: Observable<Post>
    
    init(apiClient: ApiClient) {
        self.apiClient = apiClient
        
        let _itemClicked = PublishSubject<Post>()
        itemClicked = _itemClicked.asObserver()
        didItemClicked = _itemClicked.asObservable()
    }
    
    func bindViewDidLoad(_ vdl: Driver<Void>) {
        let stats = vdl
            .flatMapLatest { [unowned self] _ -> Driver<PostResult> in
                return self.loadPosts()
                    .observeOn(MainScheduler.instance)
                    .map { .success($0) }
                    .asDriver(onErrorRecover: { error -> Driver<PostResult> in
                        Driver.just(PostResult.error(error))
                    })
                    .startWith(.loading)
        }
        
        isLoading = stats
            .map { event in
                switch event {
                case .loading: return true
                default: return false
                }
        }
        
        hasFailed = stats
            .map { event in
                switch event {
                case let .error(error): return error
                default: return nil
                }
        }
        
        hasSucced = stats
            .map { event -> [Post]? in
                switch event {
                case let .success(posts): return posts
                default: return nil
                }
            }
    }
    
    func loadPosts() -> Observable<[Post]?> {
        return Observable.create({ subscriber -> Disposable in
            let client = ApiClient()
            client.getPosts(successCallback: { posts -> KotlinUnit in
                subscriber.onNext(posts)
                subscriber.onCompleted()
                return KotlinUnit()
            }) { error -> KotlinUnit in
                subscriber.onError(error as! Error)
                return KotlinUnit()
            }
            return Disposables.create()
        })
            
    }
}
