//
//  TitleTableViewCell.swift
//  tmdb
//
//  Created by Kagan Girgin on 12.12.2020.
//

import UIKit

final class TitleTableViewCell: UITableViewCell {

    let lblTitle = UILabel()

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setUI()
    }
    
    required init(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        //MARK: contentView init
        contentView.backgroundColor = UIColor(red: CGFloat(248/255.0), green: CGFloat(248/255.0), blue: CGFloat(248/255.0), alpha: 1.0)
        
        //MARK: lblTitle init
        lblTitle.textColor = .black
        lblTitle.font = UIFont.systemFont(ofSize: 24, weight: .semibold)
        lblTitle.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(lblTitle)
        
        //MARK: set constraints
        NSLayoutConstraint.activate([
            lblTitle.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            lblTitle.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: 20),
            lblTitle.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 10),
            lblTitle.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: 10)
        ])
    }
    
    func updateCell(title: String){
        lblTitle.text = title
    }

}
