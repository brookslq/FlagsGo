//
//  MainWeatherView.swift
//  FlagsGo
//
//  Created by brooks on 2017/12/1.
//  Copyright © 2017年 brooks. All rights reserved.
//

import UIKit

class MainWeatherView: UIView {


    
    var realTemp: UILabel!
    var realSkycon: UILabel!
    var realWind: UILabel!
    var realPM25: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    func setupUI() {
        
//        let topBgV = UIView(frame: CGRect(x: 0, y: 20, width: self.width, height: 144))
//        topBgV.backgroundColor = UIColor.white
//        self.addSubview(topBgV)
        
        realTemp = UILabel(frame: CGRect(x: 10, y: 20, width: self.width / 2, height: 64))
        realTemp.font = UIFont.systemFont(ofSize: 62)
        realTemp.textAlignment = .center
        realTemp.textColor = UIColor.black
        self.addSubview(realTemp)
        
        realSkycon = UILabel(frame: CGRect(x: realTemp.right + 10, y: 20, width: self.width / 2 - 30, height: 64))
        realSkycon.font = UIFont.systemFont(ofSize: 62)
        realSkycon.textColor = UIColor.black
        realSkycon.textAlignment = .center
        self.addSubview(realSkycon)
        
        realWind = UILabel(frame: CGRect(x: 10, y: realTemp.bottom + 14, width: self.width, height: 26))
        realWind.font = UIFont.boldSystemFont(ofSize: 26)
        realWind.textAlignment = .left
        self.addSubview(realWind)
        
        realPM25 = UILabel(frame: CGRect(x: 10, y: realWind.bottom + 14, width: self.width, height: 26))
        realPM25.font = UIFont.boldSystemFont(ofSize: 26)
        realPM25.textAlignment = .left
        self.addSubview(realPM25)
        
    }
    
    func setupForecastWeather(forecastWeathers: [ForecastWeatherModel]) {
        
        let viewY = realPM25.bottom + 40
        for i in 0..<forecastWeathers.count {
            let wView = UIView(frame: CGRect(x: 0, y: viewY + CGFloat(44 * i), width: self.width, height: 44))
            wView.backgroundColor = UIColor.white
            self.addSubview(wView)
            
            let date = UILabel(frame: CGRect(x: 20, y: 12, width: 100, height: 20))
            date.font = UIFont.systemFont(ofSize: 18)
            date.text = forecastWeathers[i].date
            wView.addSubview(date)
            
            let temp = UILabel(frame: CGRect(x: date.right + 30, y: 12, width: 140, height: 20))
            temp.font = UIFont.systemFont(ofSize: 18)
            temp.text = String(format: "%.1f", forecastWeathers[i].tempMin) + "°C ~ " + String(format: "%.1f", forecastWeathers[i].tempMax) + "°C"
            wView.addSubview(temp)
            
            let skycon = UILabel(frame: CGRect(x: temp.right + 30, y: 12, width: 60, height: 20))
            skycon.font = UIFont.systemFont(ofSize: 18)
            skycon.text = DataCenter().conversionEng2Ch(text: forecastWeathers[i].skycon)
            wView.addSubview(skycon)
            
            
        }
        
        for i in 0..<forecastWeathers.count - 1 {
            let lineV = UIView(frame: CGRect(x: 0, y: viewY + CGFloat(44 * (i + 1)), width: self.width, height: 1))
            lineV.backgroundColor = UIColor.lightGray
            self.addSubview(lineV)
            
        }
        
        
        
        
    }
    
    
    

}
