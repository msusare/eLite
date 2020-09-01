//
//  DetailViewController.swift
//  eLite
//
//  Created by Mayur Susare on 01/09/20.
//  Copyright © 2020 Local. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    /// Variable Declarations
    var detailView: BaseView = BaseView()
    var listContent : ListContent?
    
    //MARK: - App Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()

        /// Setup Views
        setup()
    }
    
    //MARK: - Custom Methods
    func setup() {
        /// set navigation bar text
        self.navigationItem.title = "Detail Content"
        
        self.view.addSubview(self.detailView)
        detailView.snp.makeConstraints { (makeDetailView) in
            makeDetailView.leading.equalToSuperview()
            makeDetailView.top.equalTo(view.safeAreaLayoutGuide).inset(0)
            makeDetailView.trailing.equalToSuperview()
            makeDetailView.bottom.equalToSuperview()
        }
        
        self.view.backgroundColor = .systemBackground
        
        if let content = self.listContent {
            self.detailView.setupContent(isDetailsView: true, content: content)
        }
    }
}
