//
//  DetailScreenVC.swift
//  MVVMCExample
//
//  Created by Mehdi Sohrabi on 12/8/18.
//  Copyright © 2018 sixthsolution. All rights reserved.
//

import UIKit
import Common
import SharedNetwork

class DetailScreenVC: BaseViewController<DetailScreenVM> {
    @IBOutlet weak var postTitle: UILabel!
    @IBOutlet weak var postDetail: UILabel!
    
    var post: Post?
    override func viewDidLoad() {
        super.viewDidLoad()

        postTitle.text = post?.title
        postDetail.text = post?.body
    }
    
}
