//
//  FirestoreManager.swift
//  BuyIN
//
//  Created by Amr Hossam on 23/03/2022.
//

import Foundation
import FirebaseDatabase
import Firebase
import FirebaseDatabaseSwift


enum FirestoreError: Error {
    case failedToAddReview
}

class FirestoreManager {
    
    private let database = Firestore.firestore()

    static let shared = FirestoreManager()
    
    
    func fetchReviews(for product: ProductViewModel, completion: @escaping (Result<[Review], Error>) -> Void) {
        database.collection("reviews").whereField("itemID", isEqualTo: product.id).getDocuments { result, error in
            guard let result = result else {
                completion(.failure(FirestoreError.failedToAddReview))
                return
            }
            var reviews: [Review] = []

            for doc in result.documents {
                let review = Review(itemID: product.id, reviewAuthor: doc["reviewAuthor"] as! String, reviewText: doc["reviewText"] as! String)
                reviews.append(review)
            }
            
            completion(.success(reviews))

        }
    }
    
    func commitReview(for model: Review, completion: @escaping (Result<Void, Error>) -> Void) {
        let doc = database.collection("reviews").document()
        guard let reviewData = model.dictionary else {
            completion(.failure(FirestoreError.failedToAddReview))
            return
        }
        doc.setData(reviewData) { error in
            if error == nil {
                completion(.success(()))
            } else {
                completion(.failure(FirestoreError.failedToAddReview))
            }
        }
    }
}
