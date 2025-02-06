//
//  ViewController.swift
//  DocumentPickerControllerBug
//
//  Created by Yusuf Temel Miletli on 06.02.25.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
    
    @IBAction func presentDocumentPickerWrapped(_ sender: Any) {
        let documentPicker = DocumentPickerViewController()
        navigationController?.present(documentPicker, animated: true)
    }
    
    @IBAction func presentDocumentPickerDirectly(_ sender: Any) {
        let picker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        picker.delegate = self
        picker.allowsMultipleSelection = false
        picker.modalPresentationStyle = .formSheet

        navigationController?.present(picker, animated: true)
    }
}

extension ViewController: UIDocumentPickerDelegate {}

class DocumentPickerViewController: UIViewController, UIDocumentPickerDelegate {
    private var picker: UIDocumentPickerViewController?
    weak var delegate: UIDocumentPickerDelegate?

    override func viewDidLoad() {
        super.viewDidLoad()
        print("📄 DocumentPickerViewController - viewDidLoad() called")
        setupDocumentPicker()
    }

    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        print("📄 DocumentPickerViewController - viewDidAppear() called")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        print("📄 DocumentPickerViewController - viewWillAppear() called")
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        print("📄 DocumentPickerViewController - viewWillDisappear() called")
    }

    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        print("📄 DocumentPickerViewController - viewDidDisappear() called")
    }

    deinit {
        print("🗑 DocumentPickerViewController - deinit() called")
    }

    // MARK: - Setup Document Picker
    private func setupDocumentPicker() {
        picker = UIDocumentPickerViewController(forOpeningContentTypes: [.pdf])
        picker?.delegate = self
        picker?.allowsMultipleSelection = false
        picker?.modalPresentationStyle = .formSheet

        if let picker = picker {
            present(picker, animated: false) {
                print("📄 Document Picker fully presented")
            }
        }
    }

    // MARK: - UIDocumentPickerDelegate Methods
    func documentPicker(_ controller: UIDocumentPickerViewController, didPickDocumentsAt urls: [URL]) {
        print("✅ User selected document(s): \(urls)")
        delegate?.documentPicker?(controller, didPickDocumentsAt: urls)
        dismissSelf()
    }

    func documentPickerWasCancelled(_ controller: UIDocumentPickerViewController) {
        print("❌ User cancelled document selection")
        delegate?.documentPickerWasCancelled?(controller)
        dismissSelf()
    }

    private func dismissSelf() {
        DispatchQueue.main.async { [weak self] in
            self?.dismiss(animated: true)
        }
    }
}
