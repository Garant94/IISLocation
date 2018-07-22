//
//  MapScreenPresenter.swift
//  IISLocation
//
//  Created by Taras Holets on 20/07/2018.
//  Copyright © 2018 Taras Holets. All rights reserved.
//

import Foundation

class MapScreenPresenter {
    
    fileprivate unowned let view: MapScreenView
    fileprivate var iISData: IISData
    fileprivate var astronautsData: AstronautsData
    
    required init(view: MapScreenView) {
        self.view = view
        
        iISData = IISData(message: "", iisPosition: IISPosition(latitude: "", longitude: ""), timestamp: 0)
        astronautsData = AstronautsData(message: "", people: [Astronaut](), number: 0)
    }
    
    fileprivate func fetchData(of type: RequestType, comletiononHandler: @escaping (Data?)->()) {
       
        NetworkManager.shared.getIISData(of: type) { [weak self] (data, error) in
            
            guard let strongSelf = self else { return }
            
            if let responseError = error {
                strongSelf.view.showError(with: responseError.localizedDescription)
                
            }
            
            comletiononHandler(data)
        }
    }
    
        
    fileprivate func fetchIISData(completed: @escaping ()->()) {

        fetchData(of: .location) { [weak self] (data) in
            
            guard let strongSelf = self else { return }
            
            if let responseData = data,
                let decodedData  = try? JSONDecoder().decode(IISData.self, from: responseData) {
                strongSelf.iISData = decodedData
                
            } else {
                strongSelf.view.showError(with: "Bad data")
            }
            completed()
        }
    }

    fileprivate func fetchAstonautData(completed: @escaping ()->()) {
        fetchData(of: .astronauts) { [weak self] (data) in
            
            guard let strongSelf = self else { return }
            
            if let responseData = data,
                let decodedData  = try? JSONDecoder().decode(AstronautsData.self, from: responseData) {
                strongSelf.astronautsData = decodedData
                
            } else {
                strongSelf.view.showError(with: "Bad data")
            }
            completed()
        }
    }
    
}

extension MapScreenPresenter: MapSreenViewPresenter {
    
    func fetchAllData() {
        
        fetchIISData { [weak self] in
            guard let strongSelf = self else { return }
            
            strongSelf.fetchAstonautData {
                
                strongSelf.view.configurePoint(latitude:strongSelf.iISData.iISPosition.doubleLatitude,
                                               longitude: strongSelf.iISData.iISPosition.doubleLongitude,
                                               subtitle: strongSelf.astronautsData.astronautsNames)
                strongSelf.view.setTime(time: strongSelf.iISData.timeString)

                StoreDataMenager.shared.storeData(position: strongSelf.iISData.iISPosition, timestamp: strongSelf.iISData.timestamp)
            }
        }
    }
    
}
