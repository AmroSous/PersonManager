//
//  PersonListViewController.swift
//  PersonManager
//
//  Created by Amro Sous on 07/10/2025.
//

import Cocoa

class PersonListViewController: NSViewController {
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var headerView: HeaderView! {
        didSet {
            headerView.delegate = self
        }
    }
    @IBOutlet private weak var contentView: ContentView! {
        didSet {
            contentView.delegate = self
        }
    }
    @IBOutlet private weak var footerView: FooterView!
    
    // MARK: - Private properties
    
    private var viewModel = PersonListViewModel(sessionManager: SessionManager())
    private lazy var appInfoPopover: NSPopover = {
        let popover = NSPopover()
        popover.behavior = .transient
        popover.contentViewController = makeAppInfoPopoverViewController()
        return popover
    }()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.loadPersonList()
        contentView.updateTableItems(items: viewModel.filteredPersons)
    }
    
    deinit {
        viewModel.savePersonList()
    }
    
    // MARK: - Private functions
    
    private func makeAppInfoPopoverViewController() -> NSViewController {
        let vc = NSViewController()
        vc.view = NSView(frame: .zero)
        
        let stack = NSStackView()
        stack.orientation = .vertical
        stack.spacing = 8
        stack.translatesAutoresizingMaskIntoConstraints = false
        
        let authorNameTextField = NSTextField(labelWithString: AppInfo.authorName)
        let authorDescriptionTextField = NSTextField(labelWithString: AppInfo.authorDescription)
        
        stack.addArrangedSubview(authorNameTextField)
        stack.addArrangedSubview(authorDescriptionTextField)
        vc.view.addSubview(stack)
        
        NSLayoutConstraint.activate([
            stack.topAnchor.constraint(equalTo: vc.view.topAnchor, constant: 8),
            stack.leadingAnchor.constraint(equalTo: vc.view.leadingAnchor, constant: 8),
            stack.trailingAnchor.constraint(equalTo: vc.view.trailingAnchor, constant: -8),
            stack.bottomAnchor.constraint(equalTo: vc.view.bottomAnchor, constant: -8)
        ])
        
        return vc
    }
}

extension PersonListViewController: AddPersonViewControllerDelegate {
    func didAddPerson(_ sender: AddPersonViewController, withName name: String, symbol: SFSymbol) {
        let person = Person(name: name, symbol: symbol)
        viewModel.addPerson(person)
        contentView.updateTableItems(items: viewModel.filteredPersons)
    }
}

extension PersonListViewController: HeaderViewDelegate {
    func filterTextDidChange(_ sender: HeaderView, text: String) {
        viewModel.setFilterText(filterText: text)
        contentView.updateTableItems(items: viewModel.filteredPersons)
    }
    
    func addPersonDidClicked(_ sender: HeaderView) {
        let vc: AddPersonViewController = Storyboard.main.instance.instantiate(AddPersonViewController.self)
        vc.delegate = self
        presentAsSheet(vc)
    }
    
    func appInfoDidClicked(_ sender: HeaderView, anchor: NSButton) {
        if appInfoPopover.isShown {
            appInfoPopover.performClose(anchor)
            return
        }
        appInfoPopover.show(relativeTo: anchor.bounds, of: anchor, preferredEdge: .maxY)
    }
}

extension PersonListViewController: ContentViewDelegate {
    func didToggleStarPerson(_ sender: ContentView, person: Person) {
        viewModel.toggleStarPerson(person)
        contentView.updateTableItems(items: viewModel.filteredPersons, shouldReloadData: false)
    }
    
    func didDeletePerson(_ sender: ContentView, person: Person) {
        viewModel.removePerson(person)
        contentView.updateTableItems(items: viewModel.filteredPersons)
    }
    
    func didSelectPerson(_ sender: ContentView, person: Person?) {
        footerView.updateSelectedItem(to: person)
    }
}
