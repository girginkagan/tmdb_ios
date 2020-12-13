//
//  DetailCastTableViewCell.swift
//  tmdb
//
//  Created by Kagan Girgin on 13.12.2020.
//

import UIKit

final class DetailCastTableViewCell: UITableViewCell {

    var collectionView: UICollectionView!
    let layout = UICollectionViewFlowLayout()
    var collectionViewSource: DetailCastCollectionViewSource?

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
        
        //MARK: collectionView init
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.collectionViewLayout = layout
        collectionView.contentInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        collectionView.backgroundColor = UIColor(red: CGFloat(248/255.0), green: CGFloat(248/255.0), blue: CGFloat(248/255.0), alpha: 1.0)
        collectionView.register(DetailCastCollectionViewCell.self, forCellWithReuseIdentifier: "DetailCastCollectionViewCell")
        collectionView.showsHorizontalScrollIndicator = false
        collectionView.showsVerticalScrollIndicator = false
        collectionView.translatesAutoresizingMaskIntoConstraints = false

        contentView.addSubview(collectionView)
        
        //MARK: set constraints
        NSLayoutConstraint.activate([
            collectionView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor),
            collectionView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor),
            collectionView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: 5),
            collectionView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -10),
            collectionView.height.constraint(equalToConstant: 180)
        ])
    }
    
    func updateCell(presenter: DetailPresenter, entities: DetailEntities){
        if collectionViewSource == nil{
            collectionViewSource = DetailCastCollectionViewSource(presenter: presenter, entities: entities)
            collectionView.dataSource = collectionViewSource
            collectionView.delegate = collectionViewSource
            collectionView.reloadData()
        }
    }

}
