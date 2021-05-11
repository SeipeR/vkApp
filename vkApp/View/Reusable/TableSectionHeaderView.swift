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
        label.textColor = UIColor.label
//        label.textAlignment = .center
        
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
        contentView.backgroundColor = UIColor.systemBackground.withAlphaComponent(0.5)

        contentView.addSubview(myLabel)
        myLabel.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint(item: myLabel, attribute: .leading, relatedBy: .equal, toItem: contentView, attribute: .leading, multiplier: 1, constant: 30).isActive = true
        NSLayoutConstraint(item: myLabel, attribute: .centerY, relatedBy: .equal, toItem: contentView, attribute: .centerY, multiplier: 1, constant: 0).isActive = true
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        myLabel.frame = self.bounds
    }
    
    func configure(with name: Character) {
        myLabel.text = String(name)
    }
}
