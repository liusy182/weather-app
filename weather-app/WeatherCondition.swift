//
//  WeatherCondition.swift
//  weather-app
//
//  Created by liusy182 on 10/4/16.
//  Copyright © 2016 liusy182. All rights reserved.
//

import Foundation
import WeatherIconsKit

func iconStringFromIcon(icon: IconType, size: CGFloat) -> NSAttributedString {
    switch icon {
    case .i01d:
        return WIKFontIcon.wiDaySunnyIconWithSize(size).attributedString()
    case .i01n:
        return WIKFontIcon.wiNightClearIconWithSize(size).attributedString()
    case .i02d:
        return WIKFontIcon.wiDayCloudyIconWithSize(size).attributedString()
    case .i02n:
        return WIKFontIcon.wiNightCloudyIconWithSize(size).attributedString()
    case .i03d:
        return WIKFontIcon.wiDayCloudyIconWithSize(size).attributedString()
    case .i03n:
        return WIKFontIcon.wiNightCloudyIconWithSize(size).attributedString()
    case .i04d:
        return WIKFontIcon.wiCloudyIconWithSize(size).attributedString()
    case .i04n:
        return WIKFontIcon.wiCloudyIconWithSize(size).attributedString()
    case .i09d:
        return WIKFontIcon.wiDayShowersIconWithSize(size).attributedString()
    case .i09n:
        return WIKFontIcon.wiNightShowersIconWithSize(size).attributedString()
    case .i10d:
        return WIKFontIcon.wiDayRainIconWithSize(size).attributedString()
    case .i10n:
        return WIKFontIcon.wiNightRainIconWithSize(size).attributedString()
    case .i11d:
        return WIKFontIcon.wiDayThunderstormIconWithSize(size).attributedString()
    case .i11n:
        return WIKFontIcon.wiNightThunderstormIconWithSize(size).attributedString()
    case .i13d:
        return WIKFontIcon.wiSnowIconWithSize(size).attributedString()
    case .i13n:
        return WIKFontIcon.wiSnowIconWithSize(size).attributedString()
    case .i50d:
        return WIKFontIcon.wiFogIconWithSize(size).attributedString()
    case .i50n:
        return WIKFontIcon.wiFogIconWithSize(size).attributedString()
    }
}

enum IconType: String {
    case i01d = "01d"
    case i01n = "01n"
    case i02d = "02d"
    case i02n = "02n"
    case i03d = "03d"
    case i03n = "03n"
    case i04d = "04d"
    case i04n = "04n"
    case i09d = "09d"
    case i09n = "09n"
    case i10d = "10d"
    case i10n = "10n"
    case i11d = "11d"
    case i11n = "11n"
    case i13d = "13d"
    case i13n = "13n"
    case i50d = "50d"
    case i50n = "50n"
}

struct WeatherCondition {
    let cityName: String?
    let weather: String
    let icon: IconType?
    let time: NSDate
    let tempKelvin: Double
    let maxTempKelvin: Double
    let minTempKelvin: Double
    
    var tempFahrenheit: Double {
        get {
            return tempCelsius * 9.0/5.0 + 32.0
        }
    }

    var maxTempFahrenheit: Double {
        get {
            return maxTempCelsius * 9.0/5.0 + 32.0
        }
    }
    
    var minTempFahrenheit: Double {
        get {
            return minTempCelsius * 9.0/5.0 + 32.0
        }
    }
    
    var tempCelsius: Double {
        get {
            return tempKelvin - 273.15
        }
    }
    
    var maxTempCelsius: Double {
        get {
            return maxTempKelvin - 273.15
        }
    }

    var minTempCelsius: Double {
        get {
            return minTempKelvin - 273.15
        }
    }
}