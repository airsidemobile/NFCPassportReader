//
//  NFCViewDisplayMessage.swift
//  NFCPassportReader
//
//  Created by Andy Qua on 09/02/2021.
//

import Foundation

@available(iOS 13, macOS 10.15, *)
public enum NFCViewDisplayMessage {
    case requestPresentPassport
    case authenticatingWithPassport
    case paceAuthenticationPercentage(Int)
    case successfulBACAuthentication
    case successfulComFileRead
    case readingDataGroupBytes(DataGroupId, Int)
    case error(NFCPassportReaderError)
    case successfulRead
}

@available(iOS 13, macOS 10.15, *)
extension NFCViewDisplayMessage {
    public var description: String {
        switch self {
            case .requestPresentPassport:
                return "Hold your iPhone near an NFC enabled passport."
            case .authenticatingWithPassport:
                return "Authenticating with passport....."
            case .paceAuthenticationPercentage(let percentage):
                return "PACE authentication progress: \(percentage)%"
            case .successfulBACAuthentication:
                return "Passport authentication successful."
            case .successfulComFileRead:
                return "COM file read successful."
            case .readingDataGroupBytes(let dataGroup, let byteSize):
                return "Reading \(dataGroup)....."
            case .error(let tagError):
                switch tagError {
                    case NFCPassportReaderError.TagNotValid:
                        return "Tag not valid."
                    case NFCPassportReaderError.MoreThanOneTagFound:
                        return "More than 1 tags was found. Please present only 1 tag."
                    case NFCPassportReaderError.ConnectionError:
                        return "Connection error. Please try again."
                    case NFCPassportReaderError.InvalidMRZKey:
                        return "MRZ Key not valid for this document."
                    case NFCPassportReaderError.ResponseError(let description, let sw1, let sw2):
                        return "Sorry, there was a problem reading the passport. \(description) - (0x\(sw1), 0x\(sw2)"
                    default:
                        return "Sorry, there was a problem reading the passport. Please try again"
                }
            case .successfulRead:
                return "Passport read successfully"
        }
    }
}
