//
//  ViewController.swift
//  vk_test
//
//  Created by Артем Закиров on 06.02.2019.
//  Copyright © 2019 bmstu. All rights reserved.
//

import UIKit
import VK_ios_sdk

class ViewController: UITableViewController, VKSdkDelegate,VKSdkUIDelegate, UISearchBarDelegate, UISearchControllerDelegate{
    let Scope = ["video"]
    var vk_app_id = "6848921"
    var videos : [Video] = []
    var videoCount = 0
    let testImage = UIImage()
    let cellId = "vid"
    var offset = 1
    let count = 40
    
    
    func vkSdkShouldPresent(_ controller: UIViewController!) {
        self.present(controller, animated: true, completion: nil)

    }
    
    func vkSdkNeedCaptchaEnter(_ captchaError: VKError!) {}
    
    func vkSdkAccessAuthorizationFinished(with result: VKAuthorizationResult!) {
        if (result!.token != nil){
            print("auth succes")
        }else{
            print(result.error)
        }
    }
    
    func vkSdkUserAuthorizationFailed() {
        navigationController?.popToRootViewController(animated: true)
    }
    
    let dialogs = VKShareDialogController()
    

    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "VK Video"
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self, action: #selector(logOut(_:)))
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: cellId)
        
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search"
        navigationItem.searchController = searchController
        searchController.searchBar.returnKeyType = .done
        searchController.searchBar.delegate = self
        
        definesPresentationContext = true
        
        let sdk = VKSdk.initialize(withAppId: self.vk_app_id)
        sdk!.register(self)
        sdk?.uiDelegate = self
        let wakeUpSession = VKSdk.wakeUpSession(Scope, complete: {(state: VKAuthorizationState,
            error: Error?) ->Void in
            if state == .authorized {
                            print("все ок")
//                            self.getId()
                        } else {
                            print("войди")
//                            DispatchQueue.main.async {
                                VKSdk.authorize(self.Scope)
//                            }
                        }
            return
                    })

    }
    

    func getVideo(q:String){
        
        let video : VKRequest = VKApi.request(withMethod: "video.search",
                                              andParameters: [ "q":String(q), "offset":String(offset), "count":String(count), "sort":"2"])
        video.execute(resultBlock: { (response) -> Void in
            let videos = response?.json as! NSDictionary
            let items = videos["items"] as! NSArray
            self.addingVideo(video: items)
            },errorBlock: {(Error) -> Void in
                print(Error!)
        })
        
    }
    
    func addingVideo(video: NSArray){
        for i in 0...video.count-1{
            let current = video[i] as! NSDictionary
            var new = Video(title: current["title"] as! String,
                            duration: current["duration"] as! Int,
                            picture: URL(string:(current["photo_320"] as! String))!,
                            urlVid: URL(string: current["player"] as! String)!)
            self.videos.append(new)
            print("добавил \(i)")
        }
        print("получил видео")
        self.tableView.reloadData()
    }
    
    @objc func logOut(_ button:UIBarButtonItem!){
        VKSdk.forceLogout()
        print("пока")
    }
    
    @IBOutlet weak var testinImage: UIImageView!
    @IBAction func forphoto(_ sender: Any) {
        let current = videos[0]
        print(current.picture)
        DispatchQueue.main.async {
            let data = try? Data(contentsOf: current.picture)
            self.testinImage.image = UIImage(data: data!)
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath)
        let info = videos[indexPath.row]
        cell.textLabel?.text = "\(indexPath.row) \(info.title)"
        return cell
    }
    
}


extension ViewController : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
//        print(searchController.searchBar.text!)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        getVideo(q: searchBar.text!)
    }
}

