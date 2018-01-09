//
//  Connectivity.swift
//  Marvel Discovery
//
//  Created by Nada Kamel on 1/6/18.
//  Copyright © 2018 Nada Kamel. All rights reserved.
//

import Foundation
import Alamofire

class Connectivity {
    class func isConnectedToInternet() ->Bool {
        return NetworkReachabilityManager()!.isReachable
    }
}
