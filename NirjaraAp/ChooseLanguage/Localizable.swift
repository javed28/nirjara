//
//  Localizable.swift
//  NirjaraAp
//
//  Created by gadgetzone on 4/25/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import Foundation


private let appleLanguagesKey = "AppleLanguages"


enum Language: String {
    
    case english = "en"
    case hindi = "hi"
    case gujarathi = "gu"
    
    var semantic: UISemanticContentAttribute {
        switch self {
        case .english:
            return .forceLeftToRight
        case .hindi:
            return .forceLeftToRight
        case .gujarathi:
           // return .forceRightToLeft
            return .forceLeftToRight
        }
    }
    
    
    static var language: Language {
        get {
            if let languageCode = UserDefaults.standard.string(forKey: appleLanguagesKey),
                let language = Language(rawValue: languageCode) {
                return language
            } else {
                let preferredLanguage = NSLocale.preferredLanguages[0] as String
                let index = preferredLanguage.index(
                    preferredLanguage.startIndex,
                    offsetBy: 2
                )
                guard let localization = Language(
                    rawValue: preferredLanguage.substring(to: index)
                    ) else {
                        return Language.english
                }
                
                return localization
            }
        }
        set {
            guard language != newValue else {
                return
            }
            
            //change language in the app
            //the language will be changed after restart
            UserDefaults.standard.set([newValue.rawValue], forKey: appleLanguagesKey)
            UserDefaults.standard.synchronize()
            
            //Changes semantic to all views
            //this hack needs in case of languages with different semantics: leftToRight(en/uk) & rightToLeft(ar)
            UIView.appearance().semanticContentAttribute = newValue.semantic
            
            //initialize the app from scratch
            //show initial view controller
            //so it seems like the is restarted
            //NOTE: do not localize storboards
            //After the app restart all labels/images will be set
            //see extension String below
            UIApplication.shared.windows[0].rootViewController = UIStoryboard(
                name: "Main",
                bundle: nil
                ).instantiateInitialViewController()
        }
    }
}


extension String {
    
    var localized: String {
        return Bundle.localizedBundle.localizedString(forKey: self, value: nil, table: nil)
    }
    
//    var localizedImage: UIImage? {
//        return localizedImage()
//            ?? localizedImage(type: ".png")
//            ?? localizedImage(type: ".jpg")
//            ?? localizedImage(type: ".jpeg")
//            ?? UIImage(named: self)
//    }
//
//    private func localizedImage(type: String = "") -> UIImage? {
//        guard let imagePath = Bundle.localizedBundle.path(forResource: self, ofType: type) else {
//            return nil
//        }
//        return UIImage(contentsOfFile: imagePath)
//    }
}

extension Bundle {
    
    static var localizedBundle: Bundle {
        let languageCode = Language.language.rawValue
        guard let path = Bundle.main.path(forResource: languageCode, ofType: "lproj") else {
            return Bundle.main
        }
        return Bundle(path: path)!
    }
}
