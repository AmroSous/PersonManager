//
//  AddPersonViewController.swift
//  PersonManager
//
//  Created by Amro Sous on 07/10/2025.
//

import Cocoa

protocol AddPersonViewControllerDelegate: AnyObject {
    func didAddPerson(_ sender: AddPersonViewController, withName name: String, symbol: SFSymbol)
}

class AddPersonViewController: NSViewController {
    
    // MARK: - Public properties
    
    weak var delegate: AddPersonViewControllerDelegate?
    
    // MARK: - IBOutlets
    
    @IBOutlet private weak var addPersonView: AddPersonView! {
        didSet {
            addPersonView.delegate = self
        }
    }
    
    // MARK: - Private properties
    
    private var eventMonitor: Any?
    private var addPersonTask: Task<Void, Never>?
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventMonitor = NSEvent.addLocalMonitorForEvents(matching: [.keyDown]) { [weak self] event in
            guard let self else { return event }
            if event.keyCode == KeyCode.escape.rawValue {
                cancelAddPerson()
                return nil
            }
            return event
        }
    }
    
    deinit {
        removeEventMonitor()
        addPersonTask?.cancel()
    }
    
    // MARK: - Private functions
    
    private func removeEventMonitor() {
        if let monitor = eventMonitor {
            NSEvent.removeMonitor(monitor)
            eventMonitor = nil
        }
    }
    
    private func cancelAddPerson() {
        addPersonView.setLoading(false)
        addPersonTask?.cancel()
        dismiss(nil)
    }
}

extension AddPersonViewController: AddPersonViewDelegate {
    func didRequestAddPerson(_ sender: AddPersonView, withName name: String, symbol: SFSymbol) {
        addPersonView.setLoading(true)
        addPersonTask = Task { [weak self] in
            do {
                try await Task.sleep(nanoseconds: 2_000_000_000)
            } catch {
                await MainActor.run { [weak self] in
                    self?.addPersonView.setLoading(false)
                }
                return
            }
            
            if !Task.isCancelled {
                await MainActor.run { [weak self] in
                    guard let self else { return }
                    delegate?.didAddPerson(self, withName: name, symbol: symbol)
                    self.addPersonView.resetInputs()
                    self.addPersonView.setLoading(false)
                }
            }
        }
    }
    
    func didRequestCancelAddPerson(_ sender: AddPersonView) {
        cancelAddPerson()
    }
}
