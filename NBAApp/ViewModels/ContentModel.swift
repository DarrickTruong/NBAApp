//
//  ContentModel.swift
//  NBAAppChallenge
//
//  Created by Darrick_Truong on 7/7/21.
//

import Foundation

class ContentModel : ObservableObject {
    
    @Published var nbaLogo:Data = Data()
    @Published var logos = [String:[String:String]]()
    @Published var logosDone = false
    
    @Published var western = [Teams]()
    @Published var eastern = [Teams]()
    
    @Published var yesterday = [Games]()
    @Published var today = [Games]()
    @Published var tomorrow = [Games]()
    
    @Published var games:[String:[Games]] = [:]
    
    @Published var faveKey:String = ""
    @Published var faveColorString:String?
    
    init() {
        getNBALogo()
        getLogosUrl()
        getGamesWithDates()
    }
    
    func getGamesWithDates() {
        
        var dates = [String:String]()
        
        //        let dateString = "2021-JUL-10"
        let dateString = "2021-MAY-28"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MMM-dd"
        
        let today = dateFormatter.date(from: dateString)
        let yesterday = today!.addingTimeInterval(TimeInterval(-86400))
        let tomorrow = today!.addingTimeInterval(TimeInterval(86400))
        
        dates["yesterday"] = dateFormatter.string(from: yesterday)
        dates["today"] = dateFormatter.string(from: today!)
        dates["tomorrow"] = dateFormatter.string(from: tomorrow)
        
        for (key,value) in dates {
            
            getGames(date: value, key: key)
        }
    }
    
    func getGames(date:String, key:String) {
        
        // create url
        let url = URL(string: "\(Constants.gamesURL)/\(date)")
        
        // create URL Request
        if let url = url {
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            request.addValue("\(Constants.apiKey)", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
            
            // get URL session
            let session = URLSession.shared
            
            // create Data Task
            let dataTask = session.dataTask(with: request) { data, response, error in
                
                if error == nil {
                    
                    do {
                        // parse json
                        let decoder = JSONDecoder()
                        var result = try decoder.decode([Games].self, from: data!)
                        
                        guard result.count != 0 else {
                            return
                        }
                        
                        for idx in 0..<result.count {
                            
                            // format datetime
                            let df = DateFormatter()
                            df.dateFormat = "yyyy-MM-dd'T'HH:mm:ss"
                            let dateTime = df.date(from: result[idx].DateTime!)
                            
                            let newDF = DateFormatter()
                            newDF.dateFormat = "MMM dd, yyyy h:mm a"
                            let formattedDate = newDF.string(from: dateTime!)
                            
                            result[idx].DateTime = formattedDate
                            
                        }
                        
                        DispatchQueue.main.async {
                            self.games[key] = result
                        }
                        
                        
                    } catch {
                        print(String(describing: error))
                    }
                    
                } else {
                    print("error \(error!.localizedDescription)")
                }
            }
            
            dataTask.resume()
        }
        
    }
    
    func getNBALogo() {
        
        if let url = URL(string: Constants.nbaLogoUrl) {
            
            let session = URLSession.shared
            let dataTask = session.dataTask(with: url) { data, response, error in
 
                if error == nil {
                    
                    DispatchQueue.main.async {
                        self.nbaLogo = data!
                    }
                }
            }
            
            dataTask.resume()
        }
    }
    
    func getLogosUrl() {
        
        let url = URL(string: Constants.teamsDetailsURL)
        if let url = url {
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            request.addValue("\(Constants.apiKey)", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
            
            // get URL session
            let session = URLSession.shared
            
            // create Data Task
            let dataTask = session.dataTask(with: request) { data, response, error in
                
                if error == nil {
                    
                    do {
                        // parse json
                        let decoder = JSONDecoder()
                        let result = try decoder.decode([TeamDetails].self, from: data!)
                        
                        //                        var dict = [String:String]()
                        var dict:[String:[String:String]] = ["":["":""]]
                        
                        for detail in result {
                            dict[detail.Key!] = [:]
                            dict[detail.Key!]?["logo"] = detail.WikipediaLogoUrl
                            dict[detail.Key!]?["primaryColor"] = detail.PrimaryColor
                            dict[detail.Key!]?["secondaryColor"] = detail.SecondaryColor
                            dict[detail.Key!]?["tertiaryColor"] = detail.TertiaryColor
                            dict[detail.Key!]?["quaternaryColor"] = detail.QuaternaryColor
                        }
                        
                        DispatchQueue.main.async {
                            self.logos = dict
                            
                        }
                        
                        self.getTeams(logoDict: dict)
                        
                    } catch {
                        print(String(describing: error))
                    }
                    
                } else {
                    print("error \(error!.localizedDescription)")
                }
            }
            
            dataTask.resume()
        }
    }
    
    //    func getTeams(logoDict:[String:String]) {
    func getTeams(logoDict:[String:[String:String]]) {
        // create url
        
        let url = URL(string: Constants.standingsURL)
        
        // create URL Request
        if let url = url {
            var request = URLRequest(url: url)
            
            request.httpMethod = "GET"
            request.addValue("\(Constants.apiKey)", forHTTPHeaderField: "Ocp-Apim-Subscription-Key")
            
            // get URL session
            let session = URLSession.shared
            
            // create Data Task
            let dataTask = session.dataTask(with: request) { [self] data, response, error in
                
                if error == nil {
                    
                    do {
                        // parse json
                        let decoder = JSONDecoder()
                        let result = try decoder.decode([Teams].self, from: data!)
                        
                        var west = [Teams]()
                        var east = [Teams]()
                        
                        for team in result {
                            
                            // get logo from link
                            team.getLogoImageData(urlString: logoDict[team.Key!]?["logo"] ?? "")
                            team.PrimaryColor = logoDict[team.Key!]?["primaryColor"] ?? ""
                            team.SecondaryColor = logoDict[team.Key!]?["secondaryColor"] ?? ""
                            team.TertiaryColor = logoDict[team.Key!]?["tertiaryColor"] ?? ""
                            team.QuaternaryColor = logoDict[team.Key!]?["quaternaryColor"] ?? ""
                            
                            if team.Conference == "Western" {
                                west.append(team)
                            } else {
                                east.append(team)
                            }
                        }
                        
                        
                        west = self.sortStandings(teams: &west)
                        east = self.sortStandings(teams: &east)
                        
                        DispatchQueue.main.async {
                            self.western = west
                            self.eastern = east
                            self.logosDone = true
                        }
                    } catch {
                        print(String(describing: error))
                    }
                    
                } else {
                    print("error \(error!.localizedDescription)")
                }
            }
            
            dataTask.resume()
        }
    }
    
    func getTeamLogo(teamKey:String) -> Data? {
        
        for team in self.western {
            if team.Key == teamKey {
                return team.imageData!
            }
        }
        
        for team in self.eastern {
            if team.Key == teamKey {
                return team.imageData!
            }
        }
        return Data()
    }
    
    func sortStandings(teams: inout [Teams]) -> [Teams] {
        
        teams.sort { (t1, t2) -> Bool in
            return t1.ConferenceRank ?? 0 < t2.ConferenceRank ?? 0
        }
        return teams
    }
    
    func setFave(favoriteTeamKey:String) {
        
        self.faveKey = favoriteTeamKey
        getTeamColor()
    }
    
    func sortScheduleForFave() {
        
        for idx in 0..<games["yesterday"]!.count {
            
            let game = games["yesterday"]![idx]
            
            if game.AwayTeam == self.faveKey || game.HomeTeam == self.faveKey {
                // swap
                let firstGame = games["yesterday"]![0]
                games["yesterday"]![0] = game
                games["yesterday"]![idx] = firstGame
                break
            }
        }
        
        for idx in 0..<games["today"]!.count {
            
            let game = games["today"]![idx]
            
            if game.AwayTeam == self.faveKey || game.HomeTeam == self.faveKey {
                // swap
                let firstGame = games["today"]![0]
                games["today"]![0] = game
                games["today"]![idx] = firstGame
                break
            }
        }
        
        for idx in 0..<games["tomorrow"]!.count {
            
            let game = games["tomorrow"]![idx]
            
            if game.AwayTeam == self.faveKey || game.HomeTeam == self.faveKey {
                // swap
                let firstGame = games["tomorrow"]![0]
                games["tomorrow"]![0] = game
                games["tomorrow"]![idx] = firstGame
                break
            }
        }
    }
    
    func getTeamColor() {
        
        
        for idx in 0..<western.count {
            let team = western[idx]
            
            if faveKey == team.Key {
                DispatchQueue.main.async {
                    self.faveColorString = team.PrimaryColor
                }
                return
            }
            
        }
        
        for idx in 0..<eastern.count {
            let team = eastern[idx]
            
            if faveKey == team.Key {
                DispatchQueue.main.async {
                    self.faveColorString = team.PrimaryColor
                }
                return
            }
        }
    }
    
}
