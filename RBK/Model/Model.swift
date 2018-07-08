//
//  Model.swift
//  ParseJSON
//
//  Created by Антон Зайцев on 18.06.2018.
//  Copyright © 2018 Антон Зайцев. All rights reserved.
//

import Foundation

struct RBK: Decodable {
    let status: String
    let totalResults: Int
    var articles: [Articles]
}

struct Articles: Decodable {
    let title: String
    let description: String
    let urlToImage: String
    let publishedAt: String
    let url: String
}

//MARK: DateFormat
func stringToData(dateString: String) -> NSDate {
    let dateFormatter = DateFormatter()
    dateFormatter.locale = Locale(identifier: "ru_RU")
    dateFormatter.dateFormat = "yyyy-mm-dd'T'HH:mm:ss.SSSSSSS'Z'"
    let date = dateFormatter.date(from: dateString) as NSDate?
    return date!
}

func dateToString(date: NSDate) -> String {
    let dateFormatter = DateFormatter()
    dateFormatter.timeStyle = .medium
    dateFormatter.dateStyle = .long
    let dateString = dateFormatter.string(from:date as Date)
    return dateString
}
