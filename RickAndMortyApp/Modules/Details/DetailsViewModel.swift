//
//  DetailsViewModel.swift
//  RickAndMortyApp
//
//  Created by Lena Vorontsova on 16.09.2022.
//

import Foundation
import UIKit

final class CharacterViewModel: DetailViewModelProtocol {
    private var character: Character
    private var analytic: AnalyticsServies
    var image: UIImage? {
        character.image
    }
    var titleLabel: [String]? {
        var arr = [String]()
        arr.append(character.name ?? "")
        arr.append(character.gender ?? "")
        arr.append(character.location?.name ?? "")
        arr.append(character.species ?? "")
        return arr
    }
    
    required init(character: Character, analytic: AnalyticsServies) {
        self.character = character
        self.analytic = analytic
        self.analytic.sendEvent(AnalyticsEvents.detailPage, "Character")
    }
}

final class LocationViewModel: DetailViewModelProtocol {
    private var analytic: AnalyticsServies
    private var location: LocationInfo
    var image: UIImage?
    var titleLabel: [String]? {
        var arr = [String]()
        arr.append(location.name ?? "")
        arr.append(location.type ?? "")
        arr.append(location.dimension ?? "")
        return arr
    }
    
    required init(location: LocationInfo, analytic: AnalyticsServies) {
        self.location = location
        self.analytic = analytic
        self.analytic.sendEvent(AnalyticsEvents.detailPage, "Location")
    }
}

final class EpisodeViewModel: DetailViewModelProtocol {
    private var analytic: AnalyticsServies
    private var episode: EpisodeInfo
    var image: UIImage?
    var titleLabel: [String]? {
        var arr = [String]()
        arr.append(episode.name ?? "")
        arr.append(episode.air_date ?? "")
        arr.append(episode.episode ?? "")
        return arr
    }
    
    required init(episode: EpisodeInfo, analytic: AnalyticsServies) {
        self.episode = episode
        self.analytic = analytic
        self.analytic.sendEvent(AnalyticsEvents.detailPage, "Episode")
    }
}
