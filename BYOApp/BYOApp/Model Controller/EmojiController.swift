//
//  EmojiController.swift
//  BYOApp
//
//  Created by Sebastian Guiscardo on 2/22/23.
//

import Foundation

class EmojiController {
    
    static func fetchEmojiList(completion: @escaping ([Emoji]?) -> Void) {
        
        //Construct URL
        guard let baseURL = URL(string: Constants.EmojiURL.baseURL) else { completion(nil) ; return }
        var urlComponents = URLComponents(url: baseURL, resolvingAgainstBaseURL: true)
        urlComponents?.path.append(Constants.EmojiURL.apiPath)
        urlComponents?.path.append(Constants.EmojiURL.emojiPath)
        guard let finalURL =  urlComponents?.url else { completion(nil) ; return }
        print("Final URL: \(finalURL)")
        
        //Fetch using URL
        URLSession.shared.dataTask(with: finalURL) { data, response, error in
            
            if let error = error {
                print(error.localizedDescription)
                completion(nil) ; return
            }
            
            if let response = response as? HTTPURLResponse {
                print("Status Code: \(response.statusCode)")
            }
            
            guard let data = data else { completion(nil) ; return }
            
            do {
                if let topLevel =  try JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed) as? [[String : Any]] {
                    
                    var emojis: [Emoji] = []
                    for emojiListDictionary in topLevel {
                        if let parsedEmoji = Emoji(emojiDictionary: emojiListDictionary){
                            emojis.append(parsedEmoji)
                        }
                    }
                    completion(emojis)
                }
            } catch {
                print(error.localizedDescription)
                completion(nil) ; return
            }
        }.resume()
    }
}
