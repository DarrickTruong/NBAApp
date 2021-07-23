//
//  Models.swift
//  NBAAppChallenge
//
//  Created by Darrick_Truong on 7/7/21.
//

import Foundation

class Teams : Decodable, Identifiable, ObservableObject {
    
    @Published var imageData:Data?
    
    var id:Int?
    var Key:String?
    var City:String?
    var Name:String?
    var Conference:String?
    var ConferenceRank:Int?
    var Wins:Int?
    var Losses:Int?
    var PrimaryColor:String?
    var SecondaryColor:String?
    var TertiaryColor:String?
    var QuaternaryColor:String?
    
    enum CodingKeys: String, CodingKey {
        case id = "TeamID"
        
        case Key
        case City
        case Name
        case Conference
        case ConferenceRank
        case Wins
        case Losses
        case PrimaryColor
        case SecondaryColor
        case TertiaryColor
        case QuaternaryColor
    }
    
    func getLogoImageData(urlString:String) {
                
        if let url = URL(string: urlString) {
                        
            let data = try? Data(contentsOf: url)
            
            DispatchQueue.main.async {
                self.imageData = data!
            }

        }
    }
    
}

struct TeamDetails : Decodable {
    
    var Key:String?
    var WikipediaLogoUrl:String?
    var PrimaryColor:String?
    var SecondaryColor:String?
    var TertiaryColor:String?
    var QuaternaryColor:String?
}


struct Games : Decodable, Identifiable {
    var id:Int?
    var DateTime:String?
    var AwayTeam:String?
    var HomeTeam:String?
    var Channel:String?
    var AwayTeamScore:Int?
    var HomeTeamScore:Int?
    
    enum CodingKeys: String, CodingKey {
        case id = "GameID"
        
        case DateTime
        case AwayTeam
        case HomeTeam
        case Channel
        case AwayTeamScore
        case HomeTeamScore
        
    }
}


