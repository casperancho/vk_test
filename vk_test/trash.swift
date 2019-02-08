//
//  trash.swift
//  vk_test
//
//  Created by Артем Закиров on 08.02.2019.
//  Copyright © 2019 bmstu. All rights reserved.
//

import Foundation

//    @IBAction func click(_ sender: Any) {
//
//
//        let sdk = VKSdk.initialize(withAppId: self.vk_app_id)
//        sdk?.uiDelegate = self
//        sdk!.register(self)
//        VKSdk.wakeUpSession(Scope, complete: {(state: VKAuthorizationState, error: Error?) -> Void in
//            if state == .authorized {
//                print("yes")
//            } else {
//                VKSdk.authorize(self.Scope)
//            }
//            return
//        })
//
//    }

//    func getWithToken(at: VKAccessToken){
//        let local = at.localUser
//        print(local)//6dff70
//    }
//    func getId(){
////        let userId = String(VKSdk.accessToken()?.localUser.id as! Int)
//        let userAccessToken = VKSdk.accessToken()
//        let local = userAccessToken?.localUser
//        let id = local?.id
//        print("Получил id иду за видео")
////        getVideo(ownner: userId)
//    }



//        refreshControl = UIRefreshControl()
//        refreshControl?.attributedTitle = NSAttributedString(string: "Идет обновление...")
//        refreshControl?.addTarget(self, action: Selector(("refresh:")), for: UIControl.Event.valueChanged)
//        tableView.addSubview(refreshControl!)
//        self.tableView.tableFooterView?.isHidden = true


//@IBAction func forphoto(_ sender: Any) {
//    let current = videos[0]
//    print(current.picture)
//    DispatchQueue.main.async {
//        let data = try? Data(contentsOf: current.picture)
//        self.testinImage.image = UIImage(data: data!)
//}
//    



//class BatchViewController: UIViewController, UITableViewDataSource{
//    
//    @IBOutlet weak var coinTableView: UITableView!
//    
//    var coinArray : [Coin] = []
//    
//    let baseURL = "https://api.coinmarketcap.com/v2/ticker/?"
//    
//    // fetch 15 items for each batch
//    let itemsPerBatch = 15
//    
//    // current row from database
//    var currentRow : Int = 1
//    
//    // URL computed by current row
//    var url : URL {
//        return URL(string: "\(baseURL)start=\(currentRow)&limit=\(itemsPerBatch)")!
//    }
//    
//    // ... skipped viewDidLoad stuff
//    
//    // MARK : - Tableview data source
//    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
//        // +1 to show the loading cell at the last row
//        return self.coinArray.count + 1
//    }
//    
//    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        // if reached last row, load next batch
//        if indexPath.row == self.coinArray.count {
//            let cell = tableView.dequeueReusableCell(withIdentifier: loadingCellIdentifier, for: indexPath) as! LoadingTableViewCell
//            loadNextBatch()
//            return cell
//        }
//        
//        // else show the cell as usual
//        let cell = tableView.dequeueReusableCell(withIdentifier: coinCellIdentifier , for: indexPath) as! CoinTableViewCell
//        
//        // get the corresponding post object to show from the array
//        let coin = coinArray[indexPath.row]
//        cell.configureCell(with: coin)
//        
//        return cell
//    }
//    
//    // MARK : - Batch
//    func loadNextBatch() {
//        URLSession(configuration: URLSessionConfiguration.default).dataTask(with: url) { data, response, error in
//            
//            // Parse JSON into array of Car struct using JSONDecoder
//            guard let coinList = try? JSONDecoder().decode(CoinList.self, from: data!) else {
//                print("Error: Couldn't decode data into coin list")
//                return
//            }
//            
//            // contain array of tuples, ie. [(key : ID, value : Coin)]
//            let coinTupleArray = coinList.data.sorted {$0.value.rank < $1.value.rank}
//            for coinTuple in coinTupleArray {
//                self.coinArray.append(coinTuple.value)
//            }
//            
//            // increment current row
//            self.currentRow += self.itemsPerBatch
//            
//            // Make sure to update UI in main thread
//            DispatchQueue.main.async {
//                self.coinTableView.reloadData()
//            }
//            
//            }.resume()
//    }
//    
//}



//http://178.162.205.104/download/?title=.webm&url=https%3A%2F%2Fcs500600.vkuservideo.net%2F17%2Fu102402741%2Fvideos%2F9cd67a583a.480.mp4%3Fextra%3D7hQNk8EbdToFxkSn2zOguNtYG4w1vtgNRmjUnvpASg29obuS4_hZpXz1Jk6BqX6nWL3if4UejOg323WENb62MNBuW5X1t8gFlbfD-9Iz8Lh1IgWEVs_90sEvqHmjA-7S_FY-3tFRajU
//
//https://vk.com/video_ext.php?oid=-30316056&id=456296813&hash=d1a1540d069f8f82&__ref=vk.api&api_hash=15496506594c3494782a643c491b_GU2TENRXGE2Q
//
//
//http://s10.savefrom.net/media/3308071985/24083137f10a4ddab829684ac22a2899/.webm.mp4
//https://vk.com/video_ext.php?oid=-30316056&id=456282357&hash=47a410683a74aa76&__ref=vk.api&api_hash=1549650659d648d1185a49a3bc36_GU2TENRXGE2Q

