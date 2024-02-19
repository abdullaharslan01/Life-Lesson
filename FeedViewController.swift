//
//  FeedViewController.swift
//  firebaseLearn
//
//  Created by abdullah on 18.02.2024.
//

import UIKit
import Firebase
import FirebaseFirestore
import SDWebImage

class FeedViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return posts.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath) as! FeedCell
        
        cell.email.text = posts[indexPath.row].email
        cell.comment.text = posts[indexPath.row].comment
        
        cell.postImageView.sd_setImage(with: URL(string: posts[indexPath.row].imageUrl ?? "defaul.jpg"))
        
        return cell
        
        
        
    }
    
    
    var posts = [Post] ()

    
    
    func firebaseDatas() {
     
        let firestoreDatabase = Firestore.firestore()

        firestoreDatabase.collection("Post") .order(by: "date", descending: true).addSnapshotListener { querySnapshot, error in
            if let error = error {
                print("Hata: \(error.localizedDescription)")
                return
            }

            if let snapshot = querySnapshot {
                self.posts.removeAll(keepingCapacity: false)
               
                
                
                for document in snapshot.documents {
                    let post = Post()
                    if let imageUrl = document.get("imageUrl") as? String {
                        post.imageUrl = imageUrl
                        
                    }

                    if let comment = document.get("comment") as? String {
                        post.comment = comment
                    }

                    if let email = document.get("email") as? String {
                        post.email = email
                    }
                    self.posts.append(post)
                }
                
    

                self.xTableView.reloadData()
            } else {
                print("Snapshot boş.")
            }
        }
    }


    @IBOutlet weak var xTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        xTableView.dataSource = self
        xTableView.delegate = self
        print("didload worked")
        firebaseDatas()

    }
    

    

}
