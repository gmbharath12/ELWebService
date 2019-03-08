//
//  ServicePassthroughDelegate.swift
//  ELWebService
//
//  Created by Angelo Di Paolo on 2/8/16.
//  Copyright © 2016 WalmartLabs. All rights reserved.
//

import Foundation

/// Defines a delegate interface for hooking into service request/response events.
public protocol ServicePassthroughDelegate: class {
    /// Called before a request is to be sent
    func requestSent(_ request: URLRequest)
    
    /// Called after a NSURLSessionDataTask has completed
    func responseReceived(_ response: URLResponse?, data: Data?, request: URLRequest?, error: Error?)
    
    /// Called before an updateUI handler is invoked
    func updateUIBegin(_ response: URLResponse?)
    
    /// Called after an updateUI handler has been invoked
    func updateUIEnd(_ response: URLResponse?)
    
    /// Called when a ServiceTask handler returns a .Failure(error) result
    func serviceResultFailure(_ response: URLResponse?, data: Data?, request: URLRequest?, error: Error)
    
    func modifiedRequest(_ request: URLRequest) -> URLRequest?

    /// Throw error to indicate response is invalid. If an error is thrown, it's set as the result of the service task.
    /// This allows all service task error handlers to handle common response errors.
    func validateResponse(_ response: URLResponse?, data: Data?, error: Error?) throws
    
    /// Called when service task metrics are available upon response completion
    func didFinishCollectingTaskMetrics(metrics: ServiceTaskMetrics, request: URLRequest, response: URLResponse?, data: Data?, error: Error?)
}

extension ServicePassthroughDelegate {
    public func validateResponse(_ response: URLResponse?, data: Data?, error: Error?) throws {
        // do nothing by default for backward-compatibility
    }
}

extension ServicePassthroughDelegate {
    func modifiedRequest(_ request: URLRequest) -> URLRequest? {
        return nil
    }
}

public protocol ServicePassthroughDataSource {
    var servicePassthroughDelegate: ServicePassthroughDelegate {get}
}
