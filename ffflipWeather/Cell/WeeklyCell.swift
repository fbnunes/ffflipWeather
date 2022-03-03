//
//  WeeklyCell.swift
//  ffflipWeather
//
//  Created by ffflip on 23/02/22.
//

import Foundation
import UIKit

class WeeklyCell: UICollectionViewCell, SelfConfiguringCell, UICollectionViewDelegate, UICollectionViewDataSource {
    static var reuseIdentifier: String = "WeeklyCell"
    

    let weekdaylabel: UILabel = {
       let label = UILabel()
        label.text = "Monday"
        label.textColor = .white
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont(name:"ArialRoundedMTBold", size: 15)
        label.layer.compositingFilter = "overlayBlendMode"
//        print(label.text?.prefix(3))
        return label
    }()
    
    let tempEmoji: UILabel = {
       let label = UILabel()
        label.text = "☀️"
        label.font = UIFont.systemFont(ofSize: 20)
        label.textAlignment = .center
        label.textColor = .label
        label.translatesAutoresizingMaskIntoConstraints = false
        label.layer.compositingFilter = "overlayBlendMode"
        return label
    }()
    
    let tempSymbol: UIImageView = {
       let img = UIImageView()
        img.contentMode = .scaleAspectFit
        img.translatesAutoresizingMaskIntoConstraints = false
        return img
    }()
    
    
    var dailyForecast: [WeatherInfo] = []
    var collectionView : UICollectionView!
//    var tempEmoji: String?
    
    override init(frame: CGRect) {
         super.init(frame: frame)
        contentView.backgroundColor = UIColor.clear.withAlphaComponent(0)
         contentView.layer.cornerRadius = 10
         contentView.layer.masksToBounds = true
        
        collectionView = UICollectionView(frame: CGRect(x: 100, y: 0, width: (frame.width - 152), height: frame.height), collectionViewLayout: createCompositionalLayout())
        collectionView.register(HourlyCell.self, forCellWithReuseIdentifier: HourlyCell.reuseIdentifier)
        collectionView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        collectionView.delegate = self
        collectionView.dataSource = self
        collectionView.backgroundColor = UIColor.clear.withAlphaComponent(0)
        addSubview(collectionView)
         setupViews()
         layoutViews()
     }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {
        addSubview(weekdaylabel)
        addSubview(tempEmoji)
        addSubview(tempSymbol)
    }
    
    func layoutViews() {
        weekdaylabel.topAnchor.constraint(equalTo: topAnchor).isActive = true
        weekdaylabel.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 8).isActive = true
        weekdaylabel.heightAnchor.constraint(equalToConstant: 30).isActive = true
        weekdaylabel.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
        tempEmoji.topAnchor.constraint(equalTo: topAnchor).isActive = true
        tempEmoji.centerXAnchor.constraint(equalTo: centerXAnchor, constant: -45).isActive = true
        tempEmoji.heightAnchor.constraint(equalToConstant: 30).isActive = true
        tempEmoji.widthAnchor.constraint(equalToConstant: 100).isActive = true
        
    }
    
    func weekDayPrefix(word: String) -> String{
        var newString = word
        newString = newString.uppercased()
        
        return String(newString.prefix(3))
    }
    
    func createCompositionalLayout() -> UICollectionViewLayout {
        let layout = UICollectionViewCompositionalLayout { sectionIndex, layoutEnvironment in
            self.createFeaturedSection()
        }

        let config = UICollectionViewCompositionalLayoutConfiguration()
        layout.configuration = config
        return layout
    }
        
    func createFeaturedSection() -> NSCollectionLayoutSection {
        let itemSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1/2), heightDimension: .fractionalHeight(0.75))

       let layoutItem = NSCollectionLayoutItem(layoutSize: itemSize)
       layoutItem.contentInsets = NSDirectionalEdgeInsets(top:5, leading: 5, bottom: 50, trailing: 5)

       let layoutGroupSize = NSCollectionLayoutSize(widthDimension: .fractionalWidth(1), heightDimension: .estimated(110))
       let layoutGroup = NSCollectionLayoutGroup.horizontal(layoutSize: layoutGroupSize, subitems: [layoutItem])

       let layoutSection = NSCollectionLayoutSection(group: layoutGroup)
       layoutSection.orthogonalScrollingBehavior = .groupPagingCentered



       return layoutSection
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: HourlyCell.reuseIdentifier, for: indexPath) as! HourlyCell
        cell.configure(with: dailyForecast[indexPath.row])
        return cell
    }
    
    func setupEmojiTemperature(word: String) -> String {
//        if (word == "Wednesday") {
//            return String("☁️")
//        }
        switch word {
            case "clear sky":
            return "☀️"
            
            case "few clouds":
            return "🌥"
            
            case "broken clouds":
            return "🌥"
            
            case "scattered clouds":
            return "🌥"
            
            case "overcast clouds":
            return "🌥"
            
            case "shower rain":
            return "🌧"
            
            case "rain":
            return "🌧"
            
            case "light rain":
            return "🌧"
                
            case "thunderstorm":
            return "⛈"
                
            case "snow":
            return "❄️"
                
            case "mist":
            return "🌬"
            
            
            
        default:
            return " "
        }
        
//        return word
    }
    
    func configure(with item: ForecastTemperature) {
//        weekdaylabel.text = item.weekDay?.uppercased()
        weekdaylabel.text = weekDayPrefix(word: item.weekDay ?? "")
        dailyForecast = item.hourlyForecast ?? []
//        tempEmoji.text = item.tempEmoji?.text
        tempEmoji.text = setupEmojiTemperature(word: item.hourlyForecast?[0].description ?? "")
    
        print(item.hourlyForecast?[0].description)
    }
    
    
}
