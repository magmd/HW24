import Foundation

struct Cards: Decodable {
    let cards: [Card]
}

struct Card: Decodable {
    let id: String
    let name: String
    let type: String
    let artist: String
    let originalText: String?
}

var components = URLComponents()
components.scheme = "https"
components.host = "api.magicthegathering.io"
components.path = "/v1/cards"
components.queryItems = [
    URLQueryItem(name: "name", value: "Black Lotus")
//    URLQueryItem(name: "name", value: "Opt")
]

let url = components.string ?? ""

getData(urlRequest: url) { response, data, error in
    if error.isEmpty {
        let decoder = JSONDecoder()
        decoder.keyDecodingStrategy = .convertFromSnakeCase

        do {
            let cards: Cards = try decoder.decode(Cards.self, from: Data(data.utf8))

            for card in cards.cards {
                print("ID карты: \(card.id)")
                print("Название карты: \(card.name)")
                print("Тип: \(card.type)")
                print("Артист: \(card.artist)")
                print("Оригинальный текст: \(card.originalText ?? "")")
                print()
            }

        } catch let parsingError as NSError {
            print(parsingError)
        }

    } else {
        print(error)
    }
}
