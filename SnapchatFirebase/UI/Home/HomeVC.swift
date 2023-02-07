//
//  HomeVC.swift
//  SnapchatFirebase
//
//  Created by Hakan Adanur on 7.02.2023.
//

import UIKit
import AVFoundation
import Firebase

class HomeVC: UIViewController {
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var saveButton: UIButton!
    @IBOutlet private weak var sendButton: UIButton!
    @IBOutlet private weak var cancelButton: UIButton!
    private var viewModel: HomeVM!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }

    @IBAction func didTapButton() {
        
        let imagePicker = UIImagePickerController()
        imagePicker.sourceType = .camera
        imagePicker.cameraOverlayView = .none
        imagePicker.delegate = self
        present(imagePicker, animated: false)
        
        sendButton.isHidden = false
        saveButton.isHidden = true
        cancelButton.isHidden = false
    }
    
    private func setupUI() {
        imageView.backgroundColor = .yellow
        
        saveButton.layer.cornerRadius = 52
        saveButton.layer.borderWidth = 8
        saveButton.layer.borderColor = UIColor.white.cgColor
        saveButton.layer.backgroundColor = UIColor.clear.cgColor
        
        sendButton.isHidden = true
        cancelButton.isHidden = true
        sendButton.layer.cornerRadius = 8
    }
    
    @IBAction func sendButtonTapped(_ sender: Any) {
        viewModel.saveSnap(snapImage: imageView.image!)
        navigationController?.popViewController(animated: true)
        
        imageView.image = nil
        
        sendButton.isHidden = true
        cancelButton.isHidden = true
        saveButton.isHidden = false
    }
    
    @IBAction func cancelButtonTapped(_ sender: Any) {
        imageView.image = nil
        
        sendButton.isHidden = true
        cancelButton.isHidden = true
        saveButton.isHidden = false
    }
    
}

extension HomeVC {
    static func create() -> HomeVC {
        let vc = HomeVC(nibName: "HomeVC", bundle: nil)
        vc.viewModel = HomeVM()
        return vc
    }
}

extension HomeVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        picker.dismiss(animated: true, completion: nil)
        
        guard let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else { return }
        
        imageView.image = image
        
        
    }
}
