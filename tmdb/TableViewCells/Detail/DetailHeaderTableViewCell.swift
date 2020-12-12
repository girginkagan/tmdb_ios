//
//  DetailHeaderTableViewCell.swift
//  tmdb
//
//  Created by Kagan Girgin on 13.12.2020.
//

import UIKit
import Kingfisher

final class DetailHeaderTableViewCell: UITableViewCell {

    let ivBg = UIImageView()
    let ivCover = UIImageView()
    let viewCoverShadow = UIView()
    let lblTitle = UILabel()
    var safeAreaTopInset: CGFloat = 0

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
        if #available(iOS 11.0, *) {
            safeAreaTopInset = (UIApplication.shared.keyWindow?.safeAreaInsets.top ?? 0)
        }
        
        //MARK: contentView init
        contentView.backgroundColor = UIColor(red: CGFloat(248/255.0), green: CGFloat(248/255.0), blue: CGFloat(248/255.0), alpha: 1.0)
        
        //MARK: ivBg init
        ivBg.alpha = 0.1
        ivBg.clipsToBounds = true
        ivBg.contentMode = .scaleAspectFill
        ivBg.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: ivCover init
        ivCover.layer.cornerRadius = 8
        ivCover.clipsToBounds = true
        ivCover.contentMode = .scaleAspectFill
        ivCover.translatesAutoresizingMaskIntoConstraints = false
        
        //MARK: viewCoverShadow init
        viewCoverShadow.translatesAutoresizingMaskIntoConstraints = false
        setShadow(view: viewCoverShadow, width: 160, height: 240, radius: 8, shadowRadius: 15)
        
        //MARK: lblTitle init
        lblTitle.translatesAutoresizingMaskIntoConstraints = false
        lblTitle.font = UIFont.systemFont(ofSize: 20, weight: .semibold)
        lblTitle.numberOfLines = 2
        lblTitle.textAlignment = .center

        contentView.addSubview(ivBg)
        contentView.addSubview(viewCoverShadow)
        contentView.addSubview(ivCover)
        contentView.addSubview(lblTitle)
        
        //MARK: set constraints
        NSLayoutConstraint.activate([
            ivBg.leading.constraint(equalTo: contentView.leading),
            ivBg.trailing.constraint(equalTo: contentView.trailing),
            ivBg.top.constraint(equalTo: contentView.top),
            ivBg.bottom.constraint(equalTo: contentView.bottom),
            ivCover.top.constraint(equalTo: contentView.top, constant: safeAreaTopInset + 60),
            ivCover.centerX.constraint(equalTo: contentView.centerX),
            ivCover.width.constraint(equalToConstant: 160),
            ivCover.height.constraint(equalToConstant: 240),
            viewCoverShadow.top.constraint(equalTo: contentView.top, constant: safeAreaTopInset + 60),
            viewCoverShadow.centerX.constraint(equalTo: contentView.centerX),
            viewCoverShadow.width.constraint(equalToConstant: 160),
            viewCoverShadow.height.constraint(equalToConstant: 240),
            lblTitle.leading.constraint(equalTo: contentView.leading, constant: 20),
            lblTitle.trailing.constraint(equalTo: contentView.trailing, constant: -20),
            lblTitle.top.constraint(equalTo: ivCover.bottom, constant: 20),
        ])
    }
    
    func updateCell(data: SearchResponseModelElement?){
        ivBg.kf.setImage(with: URL(string: baseUrlForImages + ((data?.mediaType ?? MediaType.movie) == MediaType.person ? (data?.profilePath ?? "") : (data?.posterPath ?? ""))), placeholder: UIImage(named: (data?.mediaType ?? MediaType.movie) == MediaType.person ? "ic_cast_placeholder" : "ic_movie_placeholder"))
        ivCover.kf.setImage(with: URL(string: baseUrlForImages + ((data?.mediaType ?? MediaType.movie) == MediaType.person ? (data?.profilePath ?? "") : (data?.posterPath ?? ""))), placeholder: UIImage(named: (data?.mediaType ?? MediaType.movie) == MediaType.person ? "ic_cast_placeholder" : "ic_movie_placeholder"))
        
        if (data?.mediaType ?? MediaType.movie) == MediaType.person || (data?.mediaType ?? MediaType.movie) == MediaType.tv{
            lblTitle.text = data?.name
        }
        else{
            lblTitle.text = data?.title
        }
    }
}
