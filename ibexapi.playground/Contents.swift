class IbexHubController {
    private let baseUrl: String = "https://ibexhub.ibexmercado.com"
    private let accessToken: String = "eyJhbGciOiJSUzI1NiIsInR5cCI6IkpXVCJ9.eyJleHAiOjE2NjAyNTQ0NTIsIklEIjoiIiwiVHlwZSI6ImFjY2VzcyIsIlVzZXJJRCI6IjE5ZjUyMDY0LWM4MTUtNDc0Yy1iNGRkLTgwNTUyYzMwYjc4MyIsIlBlcm1pc3Npb25zIjpudWxsLCJQb29sIjoiSUJFWF9IVUIifQ.oVWRC8N-kxseyXQB-ITmER9lsKglD0Foq4bHzSl1aw4qAWmo3YLDh_OdXghfqHWke5tvHTIF6Z-PyJ3qblLidse98oDjeZij9VLoDTuuGgdYj15y_l1-A4pF63AQipyGZEVbKJ-xh2nbpk2w7YYNTh5ZUDVC7XlVNAtTtJSOFi1SddGqfUQwi6fhOIJPVaDowBmvomasuq8LLiHvCMlpJCmUUO73k91A-5bnJd0C6-DzpAqjsnIY1Olx4Vm0OOX0ewBBf2WGr1mpKE-62UreTF0ocNmZeIyorRGYi6tBYWph-O-RxK6ZzUolF7FHZh7UAQkxyXXdBWz4PInSSyQgPBmJYm8doUzvvio0lElV7UD4Qgi7j369hTnP0FmHlK9mfMBqNyjEhBIlZI0wpz-zIms2XlgMPtxCFSuC11ghH8d3EbmqmerRuFaUb073_FwEL3IYoOYEf7y7HbdW9G2TWdmT_Zr0ySQ9qXeTi-rG0jEJEgPc3V35odVNtoZpbyJb1UJPvuzDc-Lplc00eHAqXIe6O2ZrO73f2vE58nVxPhbqZdvUpbzd2ok3CABftn_xrJTdlYlmeKWPp1EpCCuU2cG29N3sZ9IvR-1jyng5tU1benaZGIp43WrSre2pJjDWYJVZ3ZOXwoYCuNuxNj9tMLVWyrx4Xxn2RWtNrw_4skc"
    
    func createAccount(name: String){
        guard let url = URL(string: baseUrl + "/account/create") else {
            return
        }
        
        var request = URLRequest(url: url)
        
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue(accessToken, forHTTPHeaderField: "Authorization")
        let body: [String: AnyHashable] = [
            "name": name,
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: body, options: .fragmentsAllowed)
        
        let task = URLSession.shared.dataTask(with: request) {data, _, error in
            guard let data = data, error == nil else {
                print("Error while making request: \(String(describing: error))")
                return
            }
            
            do {
                let response = try JSONSerialization.jsonObject(with: data, options: .allowFragments)
                print("Response: \(response)")
            }
            catch let error{
                print("Error while parsing response data: \(error)")
            }
            
        }
        task.resume()
    }
}

let ibexHub = IbexHub()
ibexHub.createAccount(name: "swift test")
