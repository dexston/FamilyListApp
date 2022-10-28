//
//  MainListViewController.swift
//  FamilyListApp
//
//  Created by Admin on 24.10.2022.
//

import UIKit

protocol MainListViewProtocol: AnyObject {
    func updateTable()
    func updateButtons()
    func scrollToTop()
}

class MainListViewController: UIViewController {
    
    var presenter: MainListViewPresenterProtocol?

    private let parentTitle: UILabel = {
        let label = UILabel()
        label.prepareForAutoLayout()
        label.text = K.String.Parent.blockTitle
        return label
    }()
    
    private let parentNameField = CustomTextField(type: .name)
    private let parentAgeField = CustomTextField(type: .olderAge)
    
    private let parentBlock: UIStackView = {
        let stack = UIStackView()
        stack.prepareForAutoLayout()
        stack.axis = .vertical
        stack.spacing = K.Value.halfBasicSpacing
        stack.isLayoutMarginsRelativeArrangement = true
        stack.layoutMargins = UIEdgeInsets(top: K.Value.Margin.basic,
                                           left: K.Value.Margin.basic,
                                           bottom: .zero,
                                           right: K.Value.Margin.basic)
        return stack
    }()
    
    private let childrenHeader = ChildrenHeader()
    
    private let childrenBlock: UITableView = {
        let table = UITableView()
        table.prepareForAutoLayout()
        table.register(ChildrenTableViewCell.self, forCellReuseIdentifier: K.Value.reusableCellIdentifier)
        table.separatorInset = UIEdgeInsets(top: .zero,
                                            left: K.Value.Margin.basic,
                                            bottom: .zero,
                                            right: K.Value.Margin.basic)
        return table
    }()
    
    private let clearButton = CustomButton(title: K.String.Buttons.clearAll,
                                           color: .systemRed)
    
    private let clearAlert = UIAlertController(title: K.String.ClearAlert.title,
                                               message: K.String.ClearAlert.message,
                                               preferredStyle: .actionSheet)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(parentBlock)
        view.addSubview(childrenHeader)
        view.addSubview(childrenBlock)
        view.addSubview(clearButton)
        view.backgroundColor = .systemBackground
        childrenBlock.dataSource = self
        setupParentBlock()
        setupButtons()
        setupConstraints()
    }
    
    private func setupParentBlock() {
        parentBlock.addArrangedSubview(parentTitle)
        parentBlock.setCustomSpacing(K.Value.basicSpacing, after: parentTitle)
        parentBlock.addArrangedSubview(parentNameField)
        parentBlock.addArrangedSubview(parentAgeField)
        parentNameField.delegate = self
        parentAgeField.delegate = self
    }
    
    private func setupButtons() {
        clearButton.addAction(UIAction{ [weak self] _ in
            guard let self = self else { return }
            self.present(self.clearAlert, animated: true, completion: nil)
        }, for: .touchUpInside)
        clearAlert.addAction(UIAlertAction(title: K.String.ClearAlert.destructiveButton,
                                           style: .destructive,
                                           handler: { [weak self] _ in
            guard let self = self else { return }
            self.presenter?.clearAll()
            self.parentNameField.setValue(with: nil)
            self.parentAgeField.setValue(with: nil)
        }))
        clearAlert.addAction(UIAlertAction(title: K.String.ClearAlert.cancelButton, style: .cancel, handler: nil))
        childrenHeader.addButtonAction = presenter?.addChild ?? { return }
        updateButtons()
    }
    
    private func setupConstraints() {
        let constraints = [
            parentBlock.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            parentBlock.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            parentBlock.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            //
            childrenHeader.topAnchor.constraint(equalTo: parentBlock.bottomAnchor),
            childrenHeader.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            childrenHeader.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            //
            childrenBlock.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            childrenBlock.trailingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.trailingAnchor),
            childrenBlock.topAnchor.constraint(equalTo: childrenHeader.bottomAnchor),
            childrenBlock.bottomAnchor.constraint(equalTo: clearButton.topAnchor, constant: -K.Value.halfBasicSpacing),
            //
            clearButton.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            clearButton.bottomAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -K.Value.basicSpacing)
        ]
        NSLayoutConstraint.activate(constraints)
    }
}

extension MainListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.childrens.count ?? .zero
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: K.Value.reusableCellIdentifier, for: indexPath) as! ChildrenTableViewCell
        if let presenter = presenter {
            cell.child = presenter.childrens[indexPath.row]
            cell.setDeleteAction { cellToDelete in
                if let index = tableView.indexPath(for: cellToDelete) {
                    presenter.deleteChild(at: index.row)
                }
            }
            cell.setUpdateAction { cellToUpdate, value, type in
                if let index = tableView.indexPath(for: cellToUpdate) {
                    presenter.updateChild(at: index.row, with: value, for: type)
                }
            }
        }
        return cell
    }
}

extension MainListViewController: MainListViewProtocol {
    func updateTable() {
        childrenBlock.reloadData()
    }
    
    func updateButtons() {
        guard let presenter = presenter else { return }
        clearButton.isEnabled = presenter.isClearButtonEnabled
        childrenHeader.isAddButtonEnabled = presenter.isAddButtonEnabled
    }
    
    func scrollToTop() {
        let indexPath = IndexPath(row: .zero, section: .zero)
        childrenBlock.scrollToRow(at: indexPath, at: .top, animated: true)
    }
}

extension MainListViewController: CustomTextFieldDelegate {
    func update(value: String, for type: CustomTextField.TextFieldType) {
        guard let presenter = presenter else { return }
        presenter.updateParent(with: value, for: type)
    }
}
