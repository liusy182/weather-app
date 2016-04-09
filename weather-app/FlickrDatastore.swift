//
//  FlickrDatastore.swift
//  weather-app
//
//  Created by liusy182 on 9/4/16.
//  Copyright © 2016 liusy182. All rights reserved.
//

import Foundation
import FlickrKit

class FlickrDatastore {
    private let OBJECTIVE_FLICKR_API_KEY = "030f29d85083ee281e648d9fbb0b166d"
    private let OBJECTIVE_FLICKR_API_SHARED_SECRET = "fda64e65539f8b5f"
    private let GROUP_ID = "1463451@N25"
    
    func retrieveImageAtLat(
        lat: Double,
        lon: Double,
        closure: (image: UIImage?) -> Void){
        let fk = FlickrKit.sharedFlickrKit()
        fk.initializeWithAPIKey(OBJECTIVE_FLICKR_API_KEY,
            sharedSecret: OBJECTIVE_FLICKR_API_SHARED_SECRET)
        fk.call("flickr.photos.search",
                args: ["group_id": GROUP_ID, "lat": "\(lat)", "lon": "\(lon)", "radius": "10"],
                maxCacheAge: FKDUMaxAgeOneHour) {
            
                (response, error) -> Void in
                    self.extractImageFk(fk,
                                        response: response,
                                        error: error,
                                        closure: closure)
            }
    }
    
    
    /**
     format of json:
     {
       photos: {
         page: 1,
         pages: 3,
         perpage: 250,
         photo: [
           {
             farm = 8,
             id = 16172607518,
             ...
           }, {
             farm = 2,
             id = 16132447518,
             ...
           },
         ...
         ]
       }
     }
     */
    private func extractImageFk(
        fk: FlickrKit,
        response: AnyObject?,
        error: NSError?,
        closure: (image: UIImage?) -> Void) {
        
        if let response = response as? [String:AnyObject],
            photos = response["photos"] as? [String:AnyObject],
            listOfPhotos: AnyObject = photos["photo"]
            where listOfPhotos.count > 0 {
                let randomIndex = Int(arc4random_uniform(UInt32(listOfPhotos.count)))
                let photo = listOfPhotos[randomIndex] as! [String:AnyObject]
                let url = fk.photoURLForSize(FKPhotoSizeMedium640, fromPhotoDictionary: photo)
                let image = UIImage(data: NSData(contentsOfURL: url)!)
            
                dispatch_async(dispatch_get_main_queue()){
                    closure(image: image!)
                }
        } else {
            print(error)
            print(response)
        }
        
    }
}