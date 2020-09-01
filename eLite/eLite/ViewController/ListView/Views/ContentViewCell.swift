//
//  ContentViewCell.swift
//  eLite
//
//  Created by Mayur Susare on 29/08/20.
//  Copyright © 2020 Local. All rights reserved.
//

import Foundation
import UIKit

//Class ContentViewCell to manage the List cell content
class ContentViewCell: UITableViewCell {
    
    //Variables and outlets.
    let baseView: BaseView = BaseView()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        self.contentView.addSubview(self.baseView)
        baseView.snp.makeConstraints { (makeBaseView) in
            makeBaseView.leading.equalToSuperview()
            makeBaseView.top.equalToSuperview()
            makeBaseView.trailing.equalToSuperview()
            makeBaseView.bottom.equalToSuperview()
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override class func awakeFromNib() {
    
    }
    
}
