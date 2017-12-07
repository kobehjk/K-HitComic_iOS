//
//  ComicDataTools.swift
//  KJ-HitComic
//
//  Created by hjk on 2017/12/6.
//  Copyright © 2017年 何锦坤. All rights reserved.
//

import UIKit
import Alamofire

protocol CommicDelegate {
    func getHotDaysResult(shotData:Shot) -> Void
}

class ComicDataTools: NSObject {
    
    private static let shareInstance:ComicDataTools = ComicDataTools()
    
    class var shared:ComicDataTools{
        return shareInstance
    }
    
    enum DataType {
        case dayHots
        case eshen
    }
    
    var dataType :DataType = .dayHots
    
    public func requestHotDay(urlstring :String,callBack:@escaping ([Dictionary<String,Any>])->Void){
        self.dataType = .dayHots
        self.getDocDataFrom(urlstring: urlstring) { (doc) in
            callBack(self.handleHotDay(doc: doc))
        }
    }
    
    private func handleHotDay(doc:OCGumboDocument) ->[Dictionary<String,Any>]{
        let parts :Array<OCGumboElement> = doc.query("body")?.find("div.mT10") as! Array<OCGumboElement>
        print(parts)
        var groupArray :Array<Dictionary<String,Any>> = Array()
        for hrefNode :OCGumboElement in parts {
            var groupdic = Dictionary<String, Any>()
            let groupTitle = hrefNode.query("h3")?.find("a")?.first()?.text()
            let moreLink = hrefNode.query("h3")?.find("a")?.last()?.attr("href")
            var imgArray :Array<Shot> = Array<Shot>()
            let imags :Array<OCGumboElement> = hrefNode.query("li.img1") as! Array<OCGumboElement>
            for imagElement :OCGumboElement in imags{
                var dic :Dictionary<String,Any> = Dictionary<String,Any>()
                let name :String? = imagElement.query("a.txt")?.first()?.text()
                let link :String? = imagElement.query("a.pic")?.first()?.attr("href")
                let imglink :String? = imagElement.query("img")?.first()?.attr("src")
                var part1 :String? = ""
                var part2 :String? = ""
                if (name?.contains(":"))!{
                    part1 = name?.components(separatedBy: CharacterSet.init(charactersIn: ":"))[0]
                    part1 = name?.components(separatedBy: CharacterSet.init(charactersIn: ":"))[1]
                }else{
                    part1 = name
                    part2 = ""
                }
                
                dic.updateValue(part1 == nil ? "" : name!, forKey: "title")
                dic.updateValue(part2 == nil ? "" : name!, forKey: "user")
                dic.updateValue(link == nil ? "" : link!, forKey: "html_url")
                dic.updateValue(imglink == nil ? "" : imglink!, forKey: "imglink")
                
                let shotdata = Shot(data: dic as NSDictionary)
                imgArray.append(shotdata)
                
            }
            groupdic.updateValue(groupTitle ?? "", forKey: "groupTitle")
            groupdic.updateValue(moreLink ?? "", forKey: "moreLink")
            groupdic.updateValue(imgArray, forKey: "imgArray")
            
            groupArray.append(groupdic)
        }
        
        return groupArray
    }
    
    private func getDocDataFrom(urlstring:String,callback:@escaping ((OCGumboDocument) -> Void)) {
        
        let url:URL = URL.init(string: urlstring)!
        Alamofire.SessionManager.default.request(url, method: .get, parameters: nil, encoding: URLEncoding.default, headers: ["User-Agent":"Mozilla/5.0 (iPhone; CPU iPhone OS 10_3_1 like Mac OS X) AppleWebKit/603.1.30 (KHTML, like Gecko) Version/10.0 Mobile/14E304"]).responseData { (resonseData) in
                let enc = CFStringConvertEncodingToNSStringEncoding(0x0632)
                let transformationStr = String.init(data: resonseData.data!, encoding: String.Encoding(rawValue: enc))
//                print(transformationStr)
                let document = OCGumboDocument.init(htmlString:transformationStr)
                print(document!)
                guard document != nil else{
                    return
                }
                switch self.dataType{
                case ComicDataTools.DataType.dayHots:
                    callback(document!)
                    break
                default:
                    break
                }
        }
        
        
//            .responseString { (dataString) in
////            print(dataString.description)
//            let enc = CFStringConvertEncodingToNSStringEncoding(0x0632)
//            let transformationStr = dataString.description.encode(to: enc as! Encoder)
////            NSStringEncoding enc = CFStringConvertEncodingToNSStringEncoding(kCFStringEncodingGB_18030_2000);
////            NSString *str = [[NSString alloc] initWithData:gb2312Data encoding:enc];
//            let document = OCGumboDocument.init(htmlString:dataString.description)
//            print(document!)
//            guard document != nil else{
//                return
//            }
//            switch self.dataType{
//            case ComicDataTools.DataType.dayHots:
//                self.handleHotDay(doc: document!)
//                break
//            default:
//                break
//            }
//
//        }
    }
    
    
    
}
