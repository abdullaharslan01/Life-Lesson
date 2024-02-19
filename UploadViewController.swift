//
//  UploadViewController.swift
//  firebaseLearn
//
//  Created by abdullah on 18.02.2024.
//

import UIKit
import Firebase
import FirebaseStorage

class UploadViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet weak var xImageView: UIImageView!
    
    
    @IBOutlet weak var xFieldTextField: UITextField!
    
    @objc func closeKeyboard() {
        view.endEditing(true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(closeKeyboard)))

        xImageView.isUserInteractionEnabled = true
        
        xImageView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(chosePhoto)))
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        
        if let userImage = info[.editedImage] as? UIImage {
            xImageView.image = userImage
            picker.dismiss(animated: true, completion: nil)

        }
        
    }
    
    var imageLink = ""
    @objc func chosePhoto() {
        
        let imagePickerController = UIImagePickerController()
        imagePickerController.delegate = self
        
        imagePickerController.sourceType = .photoLibrary
        
        imagePickerController.allowsEditing = true
        present(imagePickerController, animated: true)
        
    
        
    }
    
    
    
    @IBAction func uploadStory(_ sender: Any) {
        
        // Firebase Storage nesnesini oluşturuyoruz
        let storage = Storage.storage()

        // Storage referansı alıyoruz
        let storageReference = storage.reference()

        // "media" adında bir klasör oluşturuyoruz veya varsa bu klasörü seçiyoruz
        let mediaFolder = storageReference.child("media")

        // Eğer image verisi mevcutsa devam ediyoruz
        if let userImageData = xImageView.image?.jpegData(compressionQuality: 0.5) {

            // Resmin ismini belirliyoruz
            let imageReference = mediaFolder.child("\(UUID().uuidString).jpg")

            // Resmi yüklüyoruz ve sonucunu alıyoruz
            imageReference.putData(userImageData) { storageMetadata, error in
                if error != nil  {
                    self.showWarningMessages(title: "Error", messages: "Resim yüklenirken hata oluştu: \(String(describing: error?.localizedDescription))")
                } else {
                    // Resim yükleme başarılı, şimdi URL'yi alıyoruz
                    imageReference.downloadURL { url, error in
                        if error != nil {
                            
                            self.showWarningMessages(title: "Error", messages: "URL alınırken hata oluştu: \(String(describing: error?.localizedDescription))")
                        }
                        else if let imageUrl = url?.absoluteString {

                            let postData: [String: Any] = [
                                "imageUrl": imageUrl,
                                "comment" : self.xFieldTextField.text!,
                                "email": Auth.auth().currentUser!.email!,
                                "date" : FieldValue.serverTimestamp()
                            ]
            
                            let firestoreDatabase = Firestore.firestore()
                            
                            // Yeni bir collection oluşturmayı sağlar.
                            firestoreDatabase.collection("Post").addDocument(data: postData) { error in
                                if error != nil {
                                    self.showWarningMessages(title: "Error", messages: error?.localizedDescription ?? "Unkwon Error")
                                }
                                else {
                                    
                                    self.xImageView.image = .mainLogo
                                    
                                    self.xFieldTextField.text = ""
                                    
                                    self.tabBarController?.selectedIndex = 0
                                }
                            }
                            
                            
                        }
                    }
                }
            }

        } else {
            self.showWarningMessages(title: "Warning", messages: "Resim verisi bulunamadı")
        }
        
        
        
        
    }
    
    
    func showWarningMessages(title: String, messages: String) {
        
        let alert = UIAlertController(title: title, message: messages, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true)
        
        
    }
    
    
}
