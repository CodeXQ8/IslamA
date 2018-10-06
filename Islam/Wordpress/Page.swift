//
//  Page.swift
//  Islam
//
//  Created by Nayef Alotaibi on 10/6/18.
//  Copyright © 2018 Islam. All rights reserved.
//


import Foundation

public struct Page : CustomStringConvertible
{
    public let id: Int
    public let date: Date
    public let title: String
    public let content: String
    public let excerpt: String
    
    
    public var description: String {
        return "\n\(id) - \(date): \(title)"
    }
    
    //    init(id : Int, data: Date, title: String, content: String, excerpt: String) {
    //        self.title = title
    //        self.content = content
    //        self.excerpt = excerpt
    //        self.id = id
    //        self.data = data
    //    }
    
    init? (data: Dictionary<String, AnyObject>) {
        guard
            let identifier = data["id"] as? Int,
            let dateString = data["date"] as? String,
            let date = wpDateFormatter.date(from: dateString),
            let titleDictionary = data["title"] as? Dictionary<String, Any>,
            let title = titleDictionary["rendered"] as? String,
            let contentDictionary = data["content"] as? Dictionary<String, Any>,
            let content = contentDictionary["rendered"] as? String,
            let excerptDictionary = data["excerpt"] as? Dictionary<String, Any>,
            let excerpt = excerptDictionary["rendered"] as? String
            else {
                return nil
        }
        
        self.id = identifier
        self.date = date
        self.title = title
        self.content = content
        self.excerpt = excerpt
    }
    
    private let wpDateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-DD'T'HH:mm:ss"     // "2016-01-29T01:45:33"
        return formatter
    }()
    
}
