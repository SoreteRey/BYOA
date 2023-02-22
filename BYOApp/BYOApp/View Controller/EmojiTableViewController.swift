//
//  EmojiTableViewController.swift
//  BYOApp
//
//  Created by Sebastian Guiscardo on 2/22/23.
//

import UIKit

class EmojiTableViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        fetchEmoji()
    }
    // MARK: - Properties
    var emojis: [Emoji] = []
    
    // MARK: - Functions
    func fetchEmoji() {
        EmojiController.fetchEmojiList { emojis in
            guard let emojis = emojis else { return }
            self.emojis = emojis
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    // MARK: - Table view data source
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return emojis.count
    }


    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "emojiCell", for: indexPath)

        let emoji = emojis[indexPath.row]
        
        var config = cell.defaultContentConfiguration()
        config.text = emoji.name
        config.secondaryText = emoji.group
        cell.contentConfiguration = config

        return cell
    }
}
