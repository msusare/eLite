//
//  BaseView.swift
//  eLite
//
//  Created by Mayur Susare on 01/09/20.
//  Copyright © 2020 Local. All rights reserved.
//

import UIKit
import SnapKit
import Kingfisher

//Common base view to reuse
class BaseView: UIView {

    /// Variable Declaration
    var containerView: UIView = UIView()
    var labelContentId: UILabel = UILabel()
    var labelContentText: UILabel = UILabel()
    var labelContentDate: UILabel = UILabel()
    var imageViewContent: UIImageView = UIImageView()
    var stackViewContent: UIStackView = UIStackView()
    var stackViewImageContent: UIStackView = UIStackView()
    var containerStackView: UIStackView = UIStackView()

    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.addSubview(containerView)
        containerView.snp.makeConstraints { (makeContainerView) in
            makeContainerView.leading.equalToSuperview()
            makeContainerView.top.equalToSuperview()
            makeContainerView.trailing.equalToSuperview()
            makeContainerView.bottom.equalToSuperview()
        }
        
        containerView.addSubview(labelContentId)
        labelContentId.font = UIFont.systemFont(ofSize: 18, weight: .medium)
        
        labelContentId.snp.makeConstraints { (makeLabelContentId) in
            makeLabelContentId.leading.equalTo(10)
            makeLabelContentId.top.equalTo(10)
            makeLabelContentId.trailing.equalTo(10)
        }
        
        containerStackView.axis = .vertical
        containerStackView.alignment = .fill
        containerStackView.distribution = .fill
        containerStackView.spacing = 0
        
        containerView.addSubview(containerStackView)
        
        containerStackView.snp.makeConstraints { (makeContainerStackView) in
            makeContainerStackView.leading.equalTo(10)
            makeContainerStackView.top.equalTo(self.labelContentId.snp_bottomMargin).offset(15)
            makeContainerStackView.trailing.equalTo(-10)
        }
        
        containerStackView.addArrangedSubview(stackViewContent)
        stackViewContent.axis = .vertical
        stackViewContent.alignment = .fill
        stackViewContent.distribution = .fill
        stackViewContent.spacing = 0
        
        stackViewContent.addArrangedSubview(labelContentText)
        labelContentId.font = UIFont.systemFont(ofSize: 18, weight: .regular)
        
        stackViewImageContent.axis = .vertical
        containerStackView.addArrangedSubview(stackViewImageContent)
        
        stackViewImageContent.addArrangedSubview(imageViewContent)
        imageViewContent.contentMode = .scaleAspectFit
        imageViewContent.snp.makeConstraints { (makeImageViewContent) in
            makeImageViewContent.height.equalTo(200)
        }
        
        containerView.addSubview(labelContentDate)
        labelContentDate.textAlignment = .left
        labelContentDate.font = UIFont.systemFont(ofSize: 15, weight: .light)
        labelContentDate.snp.makeConstraints { (makeLabelContentDate) in
            makeLabelContentDate.leading.equalTo(10)
            makeLabelContentDate.top.equalTo(self.containerStackView.snp_bottomMargin).offset(15)
            makeLabelContentDate.trailing.equalTo(-10)
            makeLabelContentDate.bottom.equalToSuperview().offset(-10)
        }
    }
    
    /// Method to setup view with content
    /// - Parameters:
    ///   - isDetailsView: if want to show full screen data set this true
    ///   - content: content data to display on view
    func setupContent(isDetailsView:Bool, content: ListContent) {
        
        if isDetailsView {
            self.containerView.snp.remakeConstraints { (makeContainerView) in
                makeContainerView.leading.equalToSuperview()
                makeContainerView.top.equalToSuperview()
                makeContainerView.trailing.equalToSuperview()
            }
            
            imageViewContent.snp.removeConstraints()
        }
        self.labelContentId.text = "ID: \(content.id ?? "")"
        self.labelContentDate.text = "Date: \(content.date ?? "")"
            
        if let type = content.type, let contentType = ListContentType(rawValue: type) {
            
            switch contentType {
            case .text:
                self.stackViewImageContent.isHidden = true
                self.stackViewContent.isHidden = false
                self.labelContentText.text = content.data ?? ""
                self.labelContentText.numberOfLines = isDetailsView ? 0 : 3
                
            case .image:
                self.stackViewImageContent.isHidden = false
                self.stackViewContent.isHidden = true
                
                let processor = RoundCornerImageProcessor(cornerRadius: 10)
                let url = URL(string: content.data ?? "")
                self.imageViewContent.kf.indicatorType = .activity
                self.imageViewContent.kf.setImage(
                    with: url,
                    placeholder: UIImage(named: "placeholder"),
                    options: [
                        .processor(processor),
                        .scaleFactor(UIScreen.main.scale),
                        .transition(.fade(1)),
                        .cacheOriginalImage
                    ])
                {
                    result in
                    switch result {
                    case .success(let value):
                        print("Task done for: \(value.source.url?.absoluteString ?? "")")
                    case .failure(let error):
                        print("Job failed: \(error.localizedDescription)")
                    }
                }
            }
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
