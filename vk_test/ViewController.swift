//
//  ViewController.swift
//  vk_test
//
//  Created by Артем Закиров on 06.02.2019.
//  Copyright © 2019 bmstu. All rights reserved.
//

import UIKit
import VK_ios_sdk
import SafariServices

class ViewController: UITableViewController, VKSdkDelegate,VKSdkUIDelegate, UISearchBarDelegate, UISearchControllerDelegate, UITextFieldDelegate{
    let Scope = ["video"]
    var vk_app_id = "6848921"
    var videos : [Video] = []
    let cellId = "vid"
    var offset = 0 //сдвиг для поиска
    let count = 40 // количество подгржаемых
    var q = "" //ключ поиска
    
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
        let searchIn = UITextField()
        searchIn.becomeFirstResponder()
        searchIn.text = "Search"
        searchIn.returnKeyType = .done
        searchIn.delegate = self
        navigationItem.titleView = searchIn
        if #available(iOS 11.0, *) {
            navigationController?.navigationBar.prefersLargeTitles = true
        } else {
            // Fallback on earlier versions
        }
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Logout", style: .plain, target: self,
                                                            action: #selector(logOut(_:)))
        tableView.register(VideoCell.self, forCellReuseIdentifier: cellId)
         
        //поиск searchbar 11+
//        let searchController = UISearchController(searchResultsController: nil)
//        searchController.searchResultsUpdater = self
//        searchController.obscuresBackgroundDuringPresentation = false
//        searchController.searchBar.placeholder = "Search"
//        if #available(iOS 11.0, *) {
//            navigationItem.searchController = searchController
//        } else {
//            // Fallback on earlier versions
//        }
//        searchController.searchBar.returnKeyType = .done
//        searchController.searchBar.delegate = self
//        definesPresentationContext = true
        
        
        
        let sdk = VKSdk.initialize(withAppId: self.vk_app_id)
        sdk!.register(self)
        sdk?.uiDelegate = self
        let wakeUpSession = VKSdk.wakeUpSession(Scope, complete: {(state: VKAuthorizationState,
            error: Error?) ->Void in
            if state == .authorized {
                            print("все ок")
                        } else {
                            print("войди")
                                VKSdk.authorize(self.Scope)
                        }
            return
                    })

    }
    
    //обработка нажатия .done
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        self.videos = []
        self.offset = 0
        DispatchQueue.main.async {
            self.getVideo(q: textField.text! ,offset: self.offset )
        }
        textField.resignFirstResponder()
        return true
    }
    
    //получение ответа на запрос
    func getVideo(q: String, offset: Int){
        self.q = q
        let token = VKSdk.accessToken()
        let video : VKRequest = VKApi.request(withMethod: "video.search",
                                              andParameters: [ "q":String(q), "offset":String(offset),
                                                               "count":String(count), "sort":"2"],andHttpMethod: "&access_token=\(token)&v=5.92")
        video.execute(resultBlock: { (response) -> Void in
            let videos = response?.json as! NSDictionary
            let items = videos["items"] as! NSArray
            self.addingVideo(video: items)
            },errorBlock: {(Error) -> Void in
                print(Error!)
        })
        
    }
    //добавление видео в массив
    func addingVideo(video: NSArray){
        for i in 0...video.count-1{
            let current = video[i] as! NSDictionary
            print(current)
            DispatchQueue.main.async {
                let image = UIImage(data: try! Data(contentsOf: URL(string:(current["photo_320"] as! String))!))
            let new = Video(title: current["title"] as! String,
                            duration: current["duration"] as! Int,
                            picture: image!,
                            urlVid: URL(string: current["player"] as! String)!)
            self.videos.append(new)
            }
            print("добавил \(i)")
        }
        print("получил видео")
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    @objc func logOut(_ button:UIBarButtonItem!){
        VKSdk.forceLogout()
        print("пока")
        callAlert()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return videos.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.row == videos.count-10{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! VideoCell
            let info = videos[indexPath.row]
            cell.video = info
            self.offset += self.count
            DispatchQueue.main.async {
                self.getVideo(q: self.q, offset: self.offset)
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! VideoCell
            let info = videos[indexPath.row]
            cell.video = info
            return cell
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let selectedVideo = videos[indexPath.row]
        let SafariVC = SFSafariViewController(url: selectedVideo.urlVid)
        present(SafariVC, animated: true, completion: nil)
        
        //вызов отдельного контроллера для него нужны ссылки из files. у меня не вышло, но я работаю над этим :)
//        let PlayerVC = PlayerViewController()
//        PlayerVC.video = selectedVideo
//        navigationController?.pushViewController(PlayerVC, animated: true)
        
    }
    
    func callAlert(){
        let alertView = UIAlertController(title: "See u again", message: nil, preferredStyle: .alert)
        let login = UIAlertAction(title: "Login", style: .default) { (action) in
            VKSdk.authorize(self.Scope)
        }
        self.present(alertView, animated: true, completion: {
            print("Alert worked")
        })
        alertView.addAction(login)
    }
    
}



extension ViewController : UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
//        print(searchController.searchBar.text!)
    }
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {           //4work w searchBar
        self.videos = []
        self.offset = 0
        DispatchQueue.main.async {
            self.getVideo(q: searchBar.text! ,offset: self.offset )
        }
    }
}


