//
//  Shot.swift
//  DribbbleReader
//
//  Created by naoyashiga on 2015/05/17.
//  Copyright (c) 2015年 naoyashiga. All rights reserved.
//

import Foundation

class Shot: DribbbleBase {
    var imageUrl:String!
    var htmlUrl:String!
    var imageData: Data?
    
    var shotName = ""
    var designerName = ""
    var avatarUrl = ""
    var shotCount = ""
    
    override init(data: NSDictionary) {
        super.init(data: data)
        
//        let images = data["images"] as! NSDictionary
        self.imageUrl = data["imglink"] as! String
        self.htmlUrl = data["html_url"] as! String
        
        shotName = data["title"] as! String
        designerName = data["user"] as! String
        avatarUrl = data["html_url"] as! String
        shotCount = "阅读次数："
    }
}
