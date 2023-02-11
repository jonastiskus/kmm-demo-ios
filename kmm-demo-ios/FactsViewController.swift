//
//  ViewController.swift
//  kmm-demo-ios
//
//  Created by Jonas Tiskus on 2023-02-08.
//

import UIKit
import shared

class FactsViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var table: UITableView!
    
    private let viewModel = FactsViewModel()
    private var data: [Fact] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupView()
        setupObservers()
        
        viewModel.fetchFacts()
    }
    
    private func setupObservers() {
        viewModel.state.watch { state in
            self.updateTable(facts: state?.facts ?? [])
        }
    }
    
    private func updateTable(facts: [Fact]) {
        print(facts.count)
        self.data = facts
        table.reloadData()
    }
    
    private func setupView() {
        table.dataSource = self
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "factCell", for: indexPath) as! FactTableViewCell
        
        cell.label.text = data[indexPath.row].fact
        
        
        return cell
    }
}

