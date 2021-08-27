//
//  ListModel.swift
//  Harton
//
//  Created by harton on 2021/8/27.
//

import UIKit

class ListModel: BaseModel {
    var online_ad_data : Online_ad_data?
    var is_recommend : Bool = false
    var info : [Info]?
    var page : Int = 0
    var max_count : Int = 0
    var w_classify = 0
    var is_new = 0
    var is_hot = 1
    var hot_wd : [String]?
}

class Info: BaseModel {
    var real_preview = 0
    var interaction_type : [Any]?
    var type : String?
    var is_restrict = 0
    var price = 0
    var ext : String?
    var special_type = 0
    var create_time = 0
    var worksName : String?
    var video_quality: String?
    var rsid : String?
    var tmp_state = 1
    var coverUrl : String?
    var fbl : String?
    var size : String?
    var auditTime : String?
    
    var encodeVideoUrl1080 : String?
    var set_times : Int?
    var preview : Int?
    var createType : Int?
    var duration : String?
    var videoUrl : String?
    var downloads : String?
    var is_cost : Int?
    
    var nickname : String?
    var real_transmit : String?
    var sham_downloads : String?
    var transmit : String?
    var userId : String?
    var praise : Int?
    var worksClassify : Int?
    var shortVideoUrl : String?
    var face : String?
    var createTime : String?
    var auditStatus : Int?
    var developer_auth_type : Int?
    var real_praise : Int?
    var coverUrl_original : String?
    var size_total : Double?
    var sizeCount : Double?
    var special_type_info : String?
    var audit_status : Audit_status?
    
    
    var icon : URL?{
        guard let c = coverUrl else {
            return nil
        }
        return URL(string: c)
    }
    
    var icon_origin : URL?{
        guard let c = coverUrl_original else {
            return nil
        }
        return URL(string: c)
    }
    
    
    var video_u : URL?{
        guard let c = videoUrl else {
            return nil
        }
        return URL(string: c)
    }
    
    
}

class Audit_status: BaseModel {
    var status  = 0
    var name : String?
}

class Online_ad_data: BaseModel {
    var id : String?
    var ad_name : String?
    var ad_link : String?
    var site : Int?
    var pic : String?
}
