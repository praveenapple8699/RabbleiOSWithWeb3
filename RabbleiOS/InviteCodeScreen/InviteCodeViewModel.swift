//
//  InviteCodeViewModel.swift
//  RabbleiOS
//
//  Created by PraveenKumar on 08/10/24.
//

import Foundation


class InviteCodeViewModel {
    
    private let networkService: NetworkServiceDelegate
    
    init(networkService: NetworkServiceDelegate) {
        self.networkService = networkService
    }
    
}

extension InviteCodeViewModel {
    
    func validate(inviteCode: String, completion: @escaping (String?) -> ()) {
        
        guard inviteCode.count == 10 else {
            completion(StringConstants.INVITE_CODE_CLIENT_VALIDATION_MSG)
            return
        }
        
        let request = NetworkRequest(networkMethod: NetworkMethod.GET,
                                     path: APIEndpoints.validateInviteCode)
        networkService.request(networkRequest: request, completion: { data, error in
            if error != nil {
                completion(error)
            } else {
                let model = JSONDecoder.decode(responseData: data!, to: InviteCodeValidationDM.self)
                if let decodingError = model.1 {
                    completion(decodingError)
                } else if let inviteCodeFromServer = model.0?.invite_code, inviteCodeFromServer.lowercased() == inviteCode.lowercased() {
                    completion(nil)
                } else {
                    let message = model.0?.message ?? StringConstants.INVITE_CODE_MESSAGE_FROM_SERVER
                    completion(message)
                }
            }
        })
    }
    
}
