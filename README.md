# KaoDim Test

1. Define a function `lcm(arr: [Int]) -> Int` which calculates the [lowest common multiplier(LCM)](https://en.wikipedia.org/wiki/Least_common_multiple) of a given array of `Integers`. Raise an appropriate error if any one of the integers are 0.

 ````swift
 func gcd(_ a: Int, _ b: Int) -> Int {
    if b == 0 {
        return a
    } else {
        return gcd(b, a % b)
    }
}

func lcm(arr: [Int]) -> Int {
    var result = arr.first!
    for i in 1..<arr.count {
        result = (arr[i]/gcd(arr[i], result))*result
    }
    return result
}
 ````
 2. `Human` Bob has 1000 `Pets` of random names. Optimize the following code snippet to allow Bob to print all of his pets' names in a comma-separated `String` using `.petNames`

````swift

class Pet {
    let name: String
    weak var owner: Human?
    init(name: String){
        self.name = name
    }
}

class Human {
    var name: String
    var pets: [Pet] = []
    
    
    lazy var petNames: () -> String = {
        var result = ""
        self.pets.forEach {
            result += "\($0.name), "
        }
        return result
    }
    
    init(name: String){
        self.name = name
    }
    
    func adopt(pet: Pet){
        pets.append(pet)
        pet.owner = self
    }
    
    let uppercaseLetters = Array(65...90).map {String(UnicodeScalar($0))}
}

extension Human {
    
    func randomName() -> String {
        let randomIndex = arc4random_uniform(UInt32(uppercaseLetters.count))
        return uppercaseLetters[Int(randomIndex)]
    }
    
    func createPets() {
        for _ in 1...1000 {
            let pet = Pet(name: randomName())
            adopt(pet: pet)
        }
    }
}

let bob = Human(name: "Bob")
bob.createPets()
bob.petNames()

````
3. A Class `NetworkAdapter` has three methods 
    1. `getAuthToken(email: String, password: String) -> String`
    2. `getUserProfile(token: String) -> User`
    3. `checkIfUserAvatarChanged()`
    
    Such that `getUserProfile()` must only execute if `getAuthToken()` is successful (200), and `checkIfUserAvatarChanged()` must only be called if `getUserProfile()` is successful (200).
    
    How would you invoke these methods of `NetworkAdapter` in for example, the `viewDidLoad()` of a `ViewController`? You may also respond with pseudo or design patterns, if needed. Illustrate your solution sufficiently.

````swift
class NetworkAdapter {
    func getAuthToken(email: String, password: String, completion: (String?) -> Void) {
        if statusCode == 100 {
            completion(token) //token get from api
        } else {
            completion(nil)
        }
    }
    
    func getUserProfile(token:String, completion: (User?) -> Void) {
        if statusCode == 200 {
            completion(User())
        } else {
            completion(nil)
        }
    }
    
    func checkIfUserAvatarChanged() {
        print("Avatar has changed")
    }
}

func viewDidLoad() {
  networkAdapter.getAuthToken(email: email, password: password, completion: {
      token in
      if let token = token {
          self.networkAdapter.getUserProfile(token: token, completion: {
              user in 
              if let user = user {
                  self.networkAdapter.checkIfUserAvatarChanged()
              }
          })
      }
  })
}
````
