//
//  NewsFeedVM.swift
//  Boxing 247
//
//  Copyright © 2018 Omar. All rights reserved.
//

import Foundation

class NewsFeedVM: NSObject {
    
    var articlesArray = Bindable([Article]())
    let url = URL(string: "https://bit.ly/2tZmM0E")
    var cellVMArray: [NewsFeedCellVM]!
    let appServerClient : AppServerClient
    
    init(appServerClient: AppServerClient = AppServerClient()) {
        self.appServerClient = appServerClient
    }
    
    func downloadNews(completion: @escaping () -> Void) {
        
        self.appServerClient.downloadNews() { (result) in
            
            self.articlesArray.value = result
            self.cellVMArray = self.articlesArray.value.compactMap{ NewsFeedCellVM(initWith: $0) } // create an array of view models. 1 for each tableview view cell / article returned from the web request
            completion()
        }
    }
}
