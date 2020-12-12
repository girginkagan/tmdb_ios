//
//  BaseInteractor.swift
//  tmdb
//
//  Created by Kagan Girgin on 12.12.2020.
//

import UIKit

class BaseInteractor: NSObject{
    let services = Services()
    let appDelegate = (UIApplication.shared.delegate as! AppDelegate)
    let userDefaultsUtil = UserDefaultsUtil()
}
