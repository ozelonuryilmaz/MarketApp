//
//  BaseViewModel.swift
//  MarketApp
//
//  Created by Onur Yılmaz on 26.07.2025.
//

import Combine

typealias ErrorStateSubject = CurrentValueSubject<NetworkError?, Never>
typealias ScreenStateSubject<T> = CurrentValueSubject<T?, Never>

class BaseViewModel {

    var cancelBag = Set<AnyCancellable>()

    deinit {
        print("killed: \(type(of: self))")
    }

    func handleResourceFirestore<CONTENT: Codable, RESPONSE: Codable>(
        request: PassthroughSubject<CONTENT, Error>,
        response: CurrentValueSubject<RESPONSE?, Never>,
        errorState: ErrorStateSubject,
        callbackLoading: ((Bool) -> Void)? = nil,
        callbackSuccess: (() -> Void)? = nil,
        callbackComplete: (() -> Void)? = nil
    ) {

        callbackLoading?(true)

        request.sink(receiveCompletion: { result in

            switch result {
            case .failure(let error):
                errorState.value = .unknown(error)
                callbackLoading?(false)
                callbackComplete?()
            case .finished:
                callbackLoading?(false)
                callbackComplete?()
            }

        }, receiveValue: { value in
            if let castValue = value as? RESPONSE {
                response.value = castValue
                callbackSuccess?()
            } else {
                errorState.value = .decodingError
            }
        }).store(in: &cancelBag)
    }
}
