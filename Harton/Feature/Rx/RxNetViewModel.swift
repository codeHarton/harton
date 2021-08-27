//
//  RxNetViewModel.swift
//  Harton
//
//  Created by harton on 2021/8/27.
//

import UIKit
import Moya
class RxNetViewModel: BaseViewModel {

    
    var loadData = APIProvider.rx.request(MultiTarget(HartonService.getList)).mapObject(type: ResponseData<ListModel>.self)
}
