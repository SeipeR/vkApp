//
//  TableSectionHeaderView.swift
//  vkApp
//
//  Created by Дамир Доронкин on 20.04.2021.
//

import UIKit

final class TableSectionHeaderView: UITableViewHeaderFooterView {
    private let myLabel: UILabel = {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 17, weight: .bold)
        label.textColor = UIColor.systemIndigo
        label.textAlignment = .center
        
        return label
    }()
    
    override init(reuseIdentifier: String?) {
        super.init(reuseIdentifier: reuseIdentifier)
        configurateViews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override var reuseIdentifier: String? {
        "TableSectionHeaderView"
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        myLabel.text = nil
    }
    
    private func configurateViews() {
        addSubview(myLabel)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myLabel.frame = self.bounds
    }
    
    func configure(with name: String) {
        myLabel.text = name
    }
}
