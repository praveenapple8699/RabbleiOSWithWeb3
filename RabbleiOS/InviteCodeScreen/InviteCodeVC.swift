//
//  InviteCodeVC.swift
//  RabbleiOS
//
//  Created by PraveenKumar on 08/10/24.
//

import UIKit

class InviteCodeVC: RabbleBaseVC {
    
    private let spaceShipImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        let spaceShipWidth: CGFloat = 142
        imageView.widthAnchor.constraint(equalToConstant: spaceShipWidth).isActive = true
        imageView.heightAnchor.constraint(equalToConstant: spaceShipWidth).isActive = true
        imageView.image = UIImage(named: "invitecodeicon")
        return imageView
    }()
    
    private let mainHeading: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Your Invite Code"
        label.textColor = UIColor.init(hex: "#F0F0F0")
        label.font = UIFont.systemFont(ofSize: 34, weight: UIFont.Weight.semibold)
        return label
    }()
    
    private let subHeading: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Please enter your invite code to get started"
        label.textColor = UIColor.init(hex: "#8C8A93")
        label.font = UIFont.systemFont(ofSize: 17, weight: UIFont.Weight.regular)
        label.numberOfLines = 0
        label.lineBreakMode = .byWordWrapping
        label.widthAnchor.constraint(equalToConstant: 204).isActive = true
        label.textAlignment = NSTextAlignment.center
        return label
    }()
    
    private let verticalStackView: UIStackView = {
        let stackView = UIStackView()
        stackView.translatesAutoresizingMaskIntoConstraints = false
        stackView.axis = NSLayoutConstraint.Axis.vertical
        stackView.alignment = UIStackView.Alignment.center
        stackView.distribution = UIStackView.Distribution.fill
        return stackView
    }()
    
    private let inviteCodeTF: UITextField = {
        let textField = UITextField()
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.widthAnchor.constraint(equalToConstant: 372).isActive = true
        let attributes:[NSAttributedString.Key:Any] = [
            NSAttributedString.Key.font: UIFont.systemFont(ofSize: 20, weight: UIFont.Weight.regular),
            NSAttributedString.Key.foregroundColor: UIColor.init(hex: "#8C8A93")
        ]
        textField.attributedPlaceholder = NSAttributedString(string: "Your Invite Code", attributes: attributes)
        textField.autocapitalizationType = UITextAutocapitalizationType.allCharacters
        let bottomLine = UIView()
        bottomLine.translatesAutoresizingMaskIntoConstraints = false
        bottomLine.backgroundColor = UIColor.init(hex: "#8C8A93")
        textField.addSubview(bottomLine)
        NSLayoutConstraint.activate([
            bottomLine.heightAnchor.constraint(equalToConstant: 1),
            bottomLine.leadingAnchor.constraint(equalTo: textField.leadingAnchor),
            bottomLine.trailingAnchor.constraint(equalTo: textField.trailingAnchor),
            bottomLine.bottomAnchor.constraint(equalTo: textField.bottomAnchor)
        ])
        return textField
    }()
    
    private let continueBtn: RabbleButton = {
        let button = RabbleButton(state: RabbleButtonState.enabled)
        button.widthAnchor.constraint(equalToConstant: 372).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        return button
    }()
    
    private let tableView: UITableView = {
        let view = UITableView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    private let keyboardAccessoryToolbar: UIToolbar = {
        let bar = UIToolbar()
        let flexibleSpace = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        bar.items = []
        bar.items?.append(flexibleSpace)
        return bar
    }()
    
//    weak var presenter: InviteCodePresenterDelegate?
//    
//    init(presenter: InviteCodePresenterDelegate) {
//        self.presenter = presenter
//        super.init(nibName: nil, bundle: nil)
//    }
    
    let viewModel: InviteCodeViewModel
    init(viewModel: InviteCodeViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setUpViews()
    }
    
    private func setUpViews() {
        view.addSubview(verticalStackView)
        NSLayoutConstraint.activate([
            verticalStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            verticalStackView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor)
        ])
        keyboardAccessoryToolbar.items?.append(UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.done, target: self, action: #selector(onClickDone(_:))))
        keyboardAccessoryToolbar.sizeToFit()
        inviteCodeTF.inputAccessoryView = keyboardAccessoryToolbar
//        inviteCodeTF.delegate = self
        continueBtn.addTarget(self, action: #selector(onClickContinue(_:)), for: UIControl.Event.touchUpInside)
        [
            spaceShipImageView,
            mainHeading,
            subHeading,
            inviteCodeTF,
            continueBtn
        ].forEach { eachView in
            verticalStackView.addArrangedSubview(eachView)
        }
        
        verticalStackView.setCustomSpacing(13, after: mainHeading)
        verticalStackView.setCustomSpacing(22, after: subHeading)
        verticalStackView.setCustomSpacing(50, after: inviteCodeTF)
//        verticalStackView.setCustomSpacing(100, after: subHeading)


    }
    
    @objc func onClickDone(_ sender: UIButton) {
        inviteCodeTF.resignFirstResponder()
    }
    
    @objc func onClickContinue(_ sender: UIButton) {
        let code = inviteCodeTF.text ?? ""
        showActivityIndicator()
        viewModel.validate(inviteCode: code) { [weak self] error in
            if error != nil {
                self?.showAlertPopUp(message: error)
            } else {
                DispatchQueue.main.async {
                    self?.onInvaiteCodeValidationSucess()
                }
            }
        }
    }
    
    private func onInvaiteCodeValidationSucess() {
        dismissActivityIndicator()
        showAlert(message: StringConstants.VALID_INVITE_CODE)
    }
    
    private func showAlertPopUp(message: String?) {
        DispatchQueue.main.async { [weak self] in
            self?.dismissActivityIndicator()
            self?.showAlert(message: message)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        activateInviteTF()
    }
    
    private func activateInviteTF() {
        inviteCodeTF.becomeFirstResponder()
    }

}
