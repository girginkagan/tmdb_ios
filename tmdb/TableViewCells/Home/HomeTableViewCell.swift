//
//  HomeTableViewCell.swift
//  tmdb
//
//  Created by Kagan Girgin on 12.12.2020.
//

import UIKit
import Kingfisher

final class HomeTableViewCell: UITableViewCell {
    
    let viewInfoContainer = UIView()
    let ivItem = UIImageView()
    let lblTitle = UILabel()
    let lblOverview = UILabel()

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
        
        //MARK: viewInfoContainer init
        viewInfoContainer.backgroundColor = .white
        viewInfoContainer.layer.cornerRadius = 8
        viewInfoContainer.translatesAutoresizingMaskIntoConstraints = false
        setShadow(view: viewInfoContainer, width: Int(UIScreen.main.bounds.width) - 42, height: 150, radius: 8, shadowRadius: 7)
        
        //MARK: ivItem init
        ivItem.layer.cornerRadius = 8
        ivItem.clipsToBounds = true
        ivItem.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: lblTitle init
        lblTitle.textColor = .black
        lblTitle.font = UIFont.systemFont(ofSize: 20, weight: .medium)
        lblTitle.numberOfLines = 2
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: lblOverview init
        lblOverview.textColor = .black
        lblOverview.font = UIFont.systemFont(ofSize: 13, weight: .regular)
        lblOverview.numberOfLines = 3
        lblOverview.translatesAutoresizingMaskIntoConstraints = false
        
        contentView.addSubview(viewInfoContainer)
        viewInfoContainer.addSubview(ivItem)
        viewInfoContainer.addSubview(lblTitle)
        viewInfoContainer.addSubview(lblOverview)
        
        //MARK: set constraints
        NSLayoutConstraint.activate([
            viewInfoContainer.leading.constraint(equalTo: contentView.leading, constant: 20),
            viewInfoContainer.trailing.constraint(equalTo: contentView.trailing, constant: -20),
            viewInfoContainer.height.constraint(equalToConstant: 150),
            viewInfoContainer.bottom.constraint(equalTo: contentView.bottom, constant: -10),
            ivItem.leading.constraint(equalTo: viewInfoContainer.leading),
            ivItem.bottom.constraint(equalTo: viewInfoContainer.bottom),
            ivItem.width.constraint(equalToConstant: 120),
            ivItem.height.constraint(equalToConstant: 176),
            lblTitle.top.constraint(equalTo: viewInfoContainer.top, constant: 15),
            lblTitle.leading.constraint(equalTo: ivItem.trailing, constant: 20),
            lblTitle.trailing.constraint(equalTo: viewInfoContainer.trailing, constant: -10),
            lblOverview.top.constraint(equalTo: lblTitle.bottom, constant: 10),
            lblOverview.leading.constraint(equalTo: ivItem.trailing, constant: 20),
            lblOverview.trailing.constraint(equalTo: viewInfoContainer.trailing, constant: -10),
            lblOverview.bottom.constraint(equalTo: viewInfoContainer.bottom, constant: -10)
        ])
    }
    
    func updateCell(data: SearchResponseModelElement?){
        ivItem.kf.setImage(with: URL(string: baseUrlForImages + (data?.posterPath ?? "")), placeholder: UIImage(named: "ic_movie_placeholder"))
        lblTitle.text = data?.title
        lblOverview.text = data?.overview
    }

}
