//
//  String.swift
//  CuteWeather
//
//  Created by Filipe Nunes on 19/02/22.
//

import Foundation

extension String {
    func removeDiacritics(sentence: String) -> String {
        
        let newSentence = sentence.folding(options: .diacriticInsensitive, locale: .current)
        return newSentence
    }
}

