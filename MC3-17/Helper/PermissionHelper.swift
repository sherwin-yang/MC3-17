//
//  PermissionHelper.swift
//  MC3-17
//
//  Created by Eki Rifaldi on 02/08/20.
//  Copyright © 2020 Sherwin Yang. All rights reserved.
//

import Foundation
import HealthKit

protocol PermissionHelperDelegate {
    func didSuccessHealthStoreAuth()
    func didFailHealthStoreAuth()
}

struct PermissionHelper {
    
    var delegate: PermissionHelperDelegate?
    let healthStore = HKHealthStore()
    
    func requestHealthStoreAuth() {
        let thisTypes = Set([HKObjectType.workoutType(),
                            HKObjectType.quantityType(forIdentifier: .heartRate)!])
        
        healthStore.requestAuthorization(toShare: thisTypes, read: thisTypes) { (success, error) in
            print("Success \(success). Error \(error.debugDescription)")
            if success {
                //sukses auth tidak berarti permission accepted
                self.delegate?.didSuccessHealthStoreAuth()
            } else {
                self.delegate?.didFailHealthStoreAuth()
            }
        }
    }
    
    func getHealthStoreAuthStatus() -> Int {
        let status = healthStore.authorizationStatus(for: HKObjectType.workoutType())
        return status.rawValue
    }
}
