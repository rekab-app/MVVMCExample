//
//  MainScreenVC.swift
//  MVVMCExample
//
//  Created by Mehdi Sohrabi on 12/8/18.
//  Copyright © 2018 sixthsolution. All rights reserved.
//

import UIKit
import Common
import RxSwift
import RxCocoa
import RxDataSources
import SharedNetwork

extension Post: IdentifiableType {
    public typealias Identity = Int32
    public var identity: Int32 {
        return self.id
    }
}

struct SectionOfPosts: AnimatableSectionModelType, IdentifiableType {
    typealias Identity = String
    typealias Item = Post
    
    var identity: String
    var items: [Post]
    
    init(original: SectionOfPosts, items: [Post]) {
        self = original
        self.items = items
    }
    
    init(header: String, items: [Post]) {
        self.identity = header
        self.items = items
    }
}

class MainScreenVC: BaseViewController<MainScreenVM> {
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    var posts = PublishSubject<[SectionOfPosts]>()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.rowHeight = 80
        
        bindDataSource()
        bindDelegate()
        bindToViewModel()
    }
    
    func bindToViewModel() {
        viewModel.isLoading?
            .map { $0 }
            .drive(activityIndicator.rx.isAnimating)
            .disposed(by: bag)
        
        viewModel.hasFailed?
            .filter { $0 != nil }
            .map { $0!.localizedDescription }
            .drive(rx_showError)
            .disposed(by: bag)
        
        viewModel.hasSucced?
            .asObservable()
            .filter { $0 != nil }
            .map { $0! }
            .map {(items: [Post]) -> [SectionOfPosts] in
                return [SectionOfPosts(header: "", items: items)]
            }
            .bind(to: posts)
            .disposed(by: bag)
    }
}

extension MainScreenVC {
    func bindDataSource() {
        tableView.register(UINib(nibName: "PostCell", bundle: Bundle.main), forCellReuseIdentifier: "PostCell")

        let dataSource =  RxTableViewSectionedAnimatedDataSource<SectionOfPosts>(
            animationConfiguration: AnimationConfiguration(insertAnimation: .top,
                                                           reloadAnimation: .fade,
                                                           deleteAnimation: .left),
            configureCell: { (dataSource, table, idxPath, item) in
                let cell = table.dequeueReusableCell(withIdentifier: "PostCell", for: idxPath) as! PostCell
                cell.fillData(item)
                return cell
        })
        
        self.posts
            .bind(to: self.tableView.rx.items(dataSource: dataSource))
            .disposed(by: bag)
    }
    
    func bindDelegate() {
        self.tableView.rx.modelSelected(Post.self).bind(to: viewModel.itemClicked).disposed(by: bag)
    }
}

extension MainScreenVC {
    public var rx_showError: AnyObserver<String> {
        return Binder(self, binding: {(view, error) in
            print("something went wrong: \(error)")
        }).asObserver()
    }
}
