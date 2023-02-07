//
//  HomeVM.swift
//  SnapchatFirebase
//
//  Created by Hakan Adanur on 7.02.2023.
//

import Foundation
import UIKit
import Firebase
import FirebaseStorage

protocol HomeVMDelegate: AnyObject {
    func saveSuccess()
    func error()
}


class HomeVM {
    weak var delegate: HomeVMDelegate?
    
    func saveSnap(snapImage: UIImage) {

        let storage = Storage.storage()
        let storageReferance = storage.reference()
        
        let mediaFolder = storageReferance.child("photo")
        
        if let data = snapImage.jpegData(compressionQuality: 0.6) {
            let imageReferance = mediaFolder.child("image.jpg")
            imageReferance.putData(data, metadata: nil) { (metadata, error) in
                if error != nil {
                    print(error?.localizedDescription)
                } else {
                    imageReferance.downloadURL { (url, error)  in
                        if error != nil {
                            let imageUrl = url?.absoluteString
                            print(imageUrl)
                        }
                    }
                }
            }
        }
        
    }
}
