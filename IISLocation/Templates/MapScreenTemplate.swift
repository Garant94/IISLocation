//
//  MapScreenTemplate.swift
//  IISLocation
//
//  Created by Taras Holets on 20/07/2018.
//  Copyright © 2018 Taras Holets. All rights reserved.
//


protocol MapScreenView: class {
    func showError(with message: String)
    func configurePoint(latitude: Double, longitude: Double, subtitle: String)
    func setTime(time: String)
}

protocol MapSreenViewPresenter {
    
    init(view: MapScreenView)
    
    func fetchAllData()
}
