//
//  DetailCastCollectionViewCell.swift
//  tmdb
//
//  Created by Kagan Girgin on 13.12.2020.
//

import UIKit

final class DetailCastCollectionViewCell: UICollectionViewCell{
    
    let ivItem = UIImageView()
    let viewCoverShadow = UIView()
    let lblName = UILabel()
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setUI(){
        //MARK: contentView init
        contentView.backgroundColor = UIColor(red: CGFloat(248/255.0), green: CGFloat(248/255.0), blue: CGFloat(248/255.0), alpha: 1.0)
        
        //MARK: ivItem init
        ivItem.contentMode = .scaleAspectFill
        ivItem.layer.cornerRadius = 8
        ivItem.clipsToBounds = true
        ivItem.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: viewCoverShadow init
        viewCoverShadow.translatesAutoresizingMaskIntoConstraints = false
        setShadow(view: viewCoverShadow, width: 95, height: 140, radius: 8, shadowRadius: 5)
        
        //MARK: lblName init
        lblName.textColor = .black
        lblName.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        lblName.numberOfLines = 1
        lblName.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(viewCoverShadow)
        contentView.addSubview(ivItem)
        contentView.addSubview(lblName)
        
        //MARK: set constraints
        NSLayoutConstraint.activate([
            ivItem.leading.constraint(equalTo: contentView.leading, constant: 10),
            ivItem.trailing.constraint(equalTo: contentView.trailing, constant: -10),
            ivItem.top.constraint(equalTo: contentView.top, constant: 10),
            ivItem.height.constraint(equalToConstant: 140),
            viewCoverShadow.leading.constraint(equalTo: contentView.leading, constant: 10),
            viewCoverShadow.trailing.constraint(equalTo: contentView.trailing, constant: -10),
            viewCoverShadow.top.constraint(equalTo: contentView.top, constant: 10),
            viewCoverShadow.height.constraint(equalToConstant: 140),
            lblName.leading.constraint(equalTo: contentView.leading, constant: 10),
            lblName.trailing.constraint(equalTo: contentView.trailing, constant: -10),
            lblName.top.constraint(equalTo: ivItem.bottom, constant: 10)
        ])
    }
    
    func updateCell(data: SearchResponseModelElement?){
        ivItem.kf.setImage(with: URL(string: baseUrlForImages + (data?.profilePath ?? "")), placeholder: UIImage(named: "ic_cast_placeholder"))
        lblName.text = data?.name
    }
}
