//
//  PresenterProtocol.swift
//  VRCarApp
//
//  Created by Pallak Singh on 14/11/18.
//  Copyright © 2018 Pallak Singh. All rights reserved.
//

import Foundation
protocol PresenterProtocol: class {
    func resetUIWithConnection(status: Bool)
    func updateStatusViewWith(status: String)
    func update(message: String)
}
