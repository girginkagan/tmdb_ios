//
//  DetailDescriptionTableViewCell.swift
//  tmdb
//
//  Created by Kagan Girgin on 13.12.2020.
//

import UIKit

final class DetailDescriptionTableViewCell: UITableViewCell {

    let lblDesc = UILabel()

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
        
        //MARK: lblDesc init
        lblDesc.textColor = .black
        lblDesc.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        lblDesc.numberOfLines = 0
        lblDesc.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(lblDesc)
        
        //MARK: set constraints
        NSLayoutConstraint.activate([
            lblDesc.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            lblDesc.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            lblDesc.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            lblDesc.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10)
        ])
    }
    
    func updateCell(desc: String){
        lblDesc.text = desc
    }

}
