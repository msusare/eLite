//
//  ViewController.swift
//  eLite
//
//  Created by Mayur Susare on 29/08/20.
//  Copyright © 2020 Local. All rights reserved.
//

import UIKit
import SnapKit
import Alamofire
import SwiftyJSON

class ListViewController: UIViewController {

    
    /// Variable declarations
    var tableViewList: UITableView = UITableView()
    var arrListContent = [ListContent]()
    var arrFilteredList = [ListContent]()

    //MARK: - Application Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        /// Setup Views
        self.setup()
    }

    //MARK: - Custom Methods
    /// Function to setup views
    func setup() {
        //set navigation bar text
        self.navigationItem.title = "List"
        
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Sort", style: .plain, target: self, action: #selector(sortButtonClicked))
        
        /// Create tableView
        tableViewList = UITableView(frame: self.view.bounds, style: .plain)
        
        self.view.addSubview(tableViewList)
        
        /// setting up the tableViewConstraints
        tableViewList.snp.makeConstraints { (make) -> Void in
            make.leading.equalToSuperview()
            make.top.equalTo(view.safeAreaLayoutGuide).inset(0)
            make.trailing.equalToSuperview()
            make.bottom.equalToSuperview()
        }
        
        /// registering cell to table
        tableViewList.register(ContentViewCell.self, forCellReuseIdentifier: IBIdentifiers.CONTENT_CELL)
        tableViewList.dataSource = self
        tableViewList.delegate = self
        
        /// try to retrieve data from local or remote
        getData()
    }
    
    /// Method to call on sort button which shows the Sorting options
    @objc func sortButtonClicked() {
        
        let alertController = UIAlertController(title: "Sort", message: "Please select sort type", preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Text", style: .default, handler: { (action) in
            /// filter list based on text type
            self.arrFilteredList = self.arrListContent.filter({$0.type == "text"})
            self.tableViewList.reloadData()
        }))
        
        alertController.addAction(UIAlertAction(title: "Image", style: .default, handler: { (action) in
            /// filter list based on image type
            self.arrFilteredList = self.arrListContent.filter({$0.type == "image"})
            self.tableViewList.reloadData()
        }))
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: nil))
        
        ///present alert view controller
        self.present(alertController, animated: true, completion: nil)
    }
    
    /// Method to get data from remote or from local offline storage
    func getData() {
        
        if NetworkReachabilityManager()!.isReachable {
            self.startAnimating()
            self.fetchData { (listContentData) in
                self.stopAnimating()
                if let listContent = listContentData {
                    self.arrListContent = listContent
                    self.arrFilteredList = listContent
                    self.tableViewList.reloadData()
                    
                    do {
                        try self.saveJSONToLocalStorage(listContent: listContent)
                    }
                    catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }else{
            do {
                if let listContent = try self.retrieveLocalData() {
                    self.arrFilteredList = listContent
                    self.arrListContent = listContent
                }
            }catch {
                print(error.localizedDescription)
            }
            self.tableViewList.reloadData()
        }
    }
    
    /// Method to fetch data from API call
    /// - Parameter completion: returns the success list or nil
    func fetchData(completion: @escaping (_ listContent: [ListContent]?)->Void) {
        APIClient.getData(completion: { (result) in
            switch result {
                case .success(let listContent):
                    completion(listContent)
                    
                case .failure(let error):
                    print(error.localizedDescription)
                    completion(nil)
            }
        }) { (failure) in
            completion(nil)
        }
    }
    
    /// Method to store array of list content to local storage
    /// - Parameter listContent: array of list get from remote
    func saveJSONToLocalStorage(listContent: [ListContent]) throws {
        let encoder = JSONEncoder()
        encoder.outputFormatting = .prettyPrinted

        let jsonData = try encoder.encode(listContent)
        try Utils.writeDataTofile(data: jsonData, fileName: IBIdentifiers.LOCAL_FILE_NAME)
    }
    
    /// Method to retrieve local storage data from file
    /// return : If data found in local storage otherwise nil
    func retrieveLocalData() throws -> [ListContent]? {
        if let data = Utils.getDataFromFilePath(fileName: IBIdentifiers.LOCAL_FILE_NAME) {
            let decoder = JSONDecoder()
            let listContent = try decoder.decode(Array<ListContent>.self, from: data)
            return listContent
        }
        
        return nil
    }
    
}

//MARK: - TableView Methods

/// Extension to handle tableview delegates and callback
extension ListViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrFilteredList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let contentCell = tableView.dequeueReusableCell(withIdentifier: IBIdentifiers.CONTENT_CELL, for: indexPath) as! ContentViewCell
        
        let content = arrFilteredList[indexPath.row]

        contentCell.baseView.setupContent(isDetailsView: false, content: content)

        return contentCell
        
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        tableView.deselectRow(at: indexPath, animated: true)
        
        let content = self.arrFilteredList[indexPath.row]
        
        let detailViewController = DetailViewController()
        detailViewController.listContent = content
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
    }
}

