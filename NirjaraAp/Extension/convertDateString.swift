//
//  convertDateString.swift
//  NirjaraAp
//
//  Created by gadgetzone on 4/19/18.
//  Copyright © 2018 gadgetzone. All rights reserved.
//

import Foundation

func dateToString(dateString : String!, fromFormat sourceFormat : String!, toFormat desFormat : String!) -> String {
    
    let dateFormatter = DateFormatter()
    dateFormatter.dateFormat = sourceFormat
    let date = dateFormatter.date(from: dateString)
    
    dateFormatter.dateFormat = desFormat
    
    return dateFormatter.string(from: date!)
}
