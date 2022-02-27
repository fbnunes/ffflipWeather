//
//  HourlyCell.swift
//  WeatherApp
//
//  Created by Muhammad Osama Naeem on 3/29/20.
//  Copyright © 2020 Muhammad Osama Naeem. All rights reserved.
//


import UIKit

class HourlyCell: UICollectionViewCell {
    
    static var reuseIdentifier: String = "HourlyCell"
    
    let tempLabel: UILabel = {
       let label = UILabel()
        label.text = "05:00"
        label.font = UIFont.systemFont(ofSize: 15)
        label.textAlignment = .center
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        contentView.backgroundColor = UIColor.clear.withAlphaComponent(0)
         contentView.layer.cornerRadius = 10
         contentView.layer.masksToBounds = true
    
         setupViews()
         layoutViews()
     }
    
    func setupViews() {
        addSubview(tempLabel)
    }
    
    func layoutViews() {
        tempLabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tempLabel.leadingAnchor.constraint(equalTo: leadingAnchor).isActive = true
        tempLabel.trailingAnchor.constraint(equalTo: trailingAnchor).isActive = true
        tempLabel.heightAnchor.constraint(equalToConstant: 20).isActive = true
        tempLabel.backgroundColor = UIColor.clear.withAlphaComponent(0)
        
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with item: WeatherInfo) {
        let dateFormatterGet = DateFormatter()
        dateFormatterGet.dateFormat = "yyyy-MM-dd HH:mm:ss"

        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm"

        tempLabel.text = String(((item.max_temp + item.min_temp)/2).kelvinToCeliusConverter()) + "°C"
    }
}

