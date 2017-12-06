//
//  ComicDataTools.swift
//  KJ-HitComic
//
//  Created by hjk on 2017/12/6.
//  Copyright © 2017年 何锦坤. All rights reserved.
//

import UIKit

class ComicDataTools: NSObject {
    private static func getDocFromUrl(urlstring:String){
        let url:URL = URL.init(string: urlstring)!
        var htmlString = ""
        
        do {
            htmlString = try String.init(contentsOf: url)
        } catch{
            return
        }
        
        let document = OCGumboDocument.init(HTMLString:htmlString)
        print(document)
        
//        NSString *htmlString = [NSString stringWithContentsOfURL:xcfURL encoding:NSUTF8StringEncoding error:&error];
//        OCGumboDocument *document = [[OCGumboDocument alloc] initWithHTMLString:htmlString];
        
    }
}
