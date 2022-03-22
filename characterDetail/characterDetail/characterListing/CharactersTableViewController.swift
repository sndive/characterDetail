//
//  CharactersTableViewController.swift
//  characterDetail
//
//  Created by Anton Tropashko on 22.03.2022.
//

import UIKit

class CharactersTableViewController: UITableViewController {

    var interactor: CharactersInteractor!
    private lazy var dataSource = makeDataSource()
    
    public required init?(coder: NSCoder)
    {
        super.init(coder: coder)
        guard let interactor = CharactersInteractor(viewContoller: self) else {
            assertionFailure()
            return nil
        }
        self.interactor = interactor
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        assert(self.tableView.dataSource === self)

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

    func applySnapshot(figments: [MarvelCharacter], animatingDifferences: Bool = true) {
      var snapshot = Snapshot()
      snapshot.appendSections([.main])
      snapshot.appendItems(figments)
      dataSource.apply(snapshot, animatingDifferences: animatingDifferences)
    }
    
    enum Section {
      case main
    }
    typealias DataSource = UITableViewDiffableDataSource<Section, MarvelCharacter>
    typealias Snapshot = NSDiffableDataSourceSnapshot<Section, MarvelCharacter>
    
    func makeDataSource() -> DataSource {
      // 1
      let dataSource = DataSource(
        tableView: tableView,
        cellProvider: { (tableView, indexPath, character) ->
          UITableViewCell? in
          // 2
          let cell = tableView.dequeueReusableCell(
            withIdentifier: "ComicCell",
            for: indexPath) as? ComicCell
          cell?.configureWith(character)
          return cell
      })
      return dataSource
    }

    let spinner = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.medium)

    // cause prefetchRowsAt is never called
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            self.tableView.tableFooterView = spinner
            self.tableView.tableFooterView?.isHidden = false
            // print("this is the last cell")
        }

        let lookUpAheadMargin = 30
        if indexPath.section == lastSectionIndex &&
            indexPath.row >= lastRowIndex - lookUpAheadMargin {
            print(" prefetch heruistic tripped")
            interactor.loadCharacters(uptoindex: indexPath.row + lookUpAheadMargin)
        }
    }

    func tableView(_ tableView: UITableView, prefetchRowsAt indexPaths: [IndexPath])
    {
        let lastSectionIndex = tableView.numberOfSections - 1
        for ip in indexPaths {
            if ip.section ==  lastSectionIndex {
                interactor.loadCharacters(uptoindex: ip.row)
            }
        }
    }
    
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
