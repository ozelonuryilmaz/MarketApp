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

    func handleResourceDataSource<RESPONSE: Codable>(
        request: AnyPublisher<RESPONSE, NetworkError>,
        errorState: ErrorStateSubject,
        callbackLoading: ((Bool) -> Void)? = nil,
        callbackSuccess: ((RESPONSE?) -> Void)? = nil,
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
                callbackSuccess?(castValue)
            } else {
                errorState.value = .decodingError
            }
        }).store(in: &cancelBag)
    }
}
