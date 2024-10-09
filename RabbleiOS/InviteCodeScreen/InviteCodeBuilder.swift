//
//  InviteCodeBuilder.swift
//  RabbleiOS
//
//  Created by PraveenKumar on 08/10/24.
//

import Foundation

class InviteCodeBuilder {
    
    class func createVC() -> InviteCodeVC {
        let networkService = NetworkService()
        let viewModel = InviteCodeViewModel(networkService: networkService)
        return InviteCodeVC(viewModel: viewModel)
    }
    
}
