//: ## Generics
//:
//: Write a name inside angle brackets to make a generic function or type.
//:
func repeatItem<Item>(item: Item, numberOfTimes: Int) -> [Item] {
    var result = [Item]()
    for _ in 0..<numberOfTimes {
         result.append(item)
    }
    return result
}
repeatItem("knock", numberOfTimes:4)
repeatItem(4, numberOfTimes: 2)

//: You can make generic forms of functions and methods, as well as classes, enumerations, and structures.
//:
// Reimplement the Swift standard library's optional type
enum OptionalValue<Wrapped> {
    case None
    case Some(Wrapped)
}
var possibleInteger: OptionalValue<Int> = .None
possibleInteger = .Some(100)


//: Use `where` after the type name to specify a list of requirements—for example, to require the type to implement a protocol, to require two types to be the same, or to require a class to have a particular superclass.
//:
func anyCommonElements <T: SequenceType, U: SequenceType where T.Generator.Element: Equatable, T.Generator.Element == U.Generator.Element> (lhs: T, _ rhs: U) -> Bool {
    for lhsItem in lhs {
        for rhsItem in rhs {
            if lhsItem == rhsItem {
                return true
            }
        }
    }
   return false
}
anyCommonElements([1, 2, 3], [4])

//: - Experiment:
//: Modify the `anyCommonElements(_:_:)` function to make a function that returns an array of the elements that any two sequences have in common.
//:
//: Writing `<T: Equatable>` is the same as writing `<T where T: Equatable>`.
//:
// ------ Tutorial section ------
var numbersAgain = Array<Int>() // any difference from the following declaration?
//var numbersAgain = [Int]()
numbersAgain.append(1)
numbersAgain.append(2)
numbersAgain.append(3)
let firstNumberAgain = numbersAgain[0]


let countryCodes = ["Austria": "AT", "United States of America": "US", "Turkey": "TR"]
let at = countryCodes["Austria"]


let optionalName = Optional<String>.Some("John")
let anotherOptName : String? = "Jonh"
if let name = optionalName {
    print("John")
}


func pairsFromDictionary<KeyType, ValueType>(dictionary: [KeyType: ValueType]) -> [(KeyType, ValueType)] {
    return Array(dictionary)
}
let pairs = pairsFromDictionary(["minimum": 199, "maximum": 299])
let anotherPairs = pairsFromDictionary([1:"first", 2:"second", 3:"third"])


struct Queue<Element:Equatable> {
    private var elements = Array<Element>()
//    private var elements = [Element]()
    mutating func enqueue (newElement : Element){
        elements.append(newElement)
    }
    
    mutating func dequeue () -> Element? {
        guard !elements.isEmpty else {
            return nil
        }
        return elements.removeAtIndex(0)
    }
}
var q = Queue<Int>()
q.enqueue(2)
q.enqueue(6)
q.enqueue(5)
q.enqueue(9)
//q.enqueue("string")
q.dequeue()
q.dequeue()
//q.dequeue()
//q.dequeue()
//q.dequeue()
extension Queue{
    func peek() -> Element? {
        return elements.first
    }
}
q.peek()
extension Queue{
    func homogeneous() -> Bool {
        if let first = elements.first {
            return !elements.contains { $0 != first }
        }
        return true
    }
}
q.homogeneous()


func mid</*T where*/ T:Comparable> (anArray: [T]) ->T{
    return anArray.sort()[(anArray.count - 1) / 2]
}
mid([5,2,1,4,3])


protocol Summable { func +(lhs: Self, rhs: Self) -> Self }
extension Int: Summable {}
extension Double: Summable {}
func adder<T: Summable>(x: T, _ y: T) -> T {
    return x + y
}
let adderIntSum = adder(1, 2)
let adderDoubleSum = adder(1.0, 2.0)
extension String: Summable {}
let adderString = adder("Generics", " are Awesome!!! :]")


class Box<T> {
    
}
class Gift<T>: Box<T> {
    //This is a generic subclass subclassing from a generic superclass
}
class StringBox: Box<String> {
    //This is a string-specific subclass subclassing from a generic superclass which has been specified to be String type. This subclass is not generic anymore
}
let box = Box<Int>()
let gift = Gift<Double>()
let string = StringBox()


enum result<valueType, errorType> {
    case success(valueType)
    case failure(errorType)
}
func divideOrError(x: Int, y:Int) -> result<Int, String> {
    guard y != 0 else{
        return result.failure("Division by 0 in undefined.")
    }
    return result.success(x / y)
}
let result1 = divideOrError(10, y: 5)
let result2 = divideOrError(10, y: 0)




/*
    Generic function application
 */
protocol mapping {
    func mapping (dict: [String:String]) -> AnyObject
}
class user : mapping{
    var name : String?
    func mapping(dict: [String:String]) -> AnyObject{
        name = dict["name"]
        return self
    }
}
class car : mapping{
    var brand : String?
    func mapping(dict: [String:String]) -> AnyObject{
        brand = dict["brand"]
        return self
    }
}
func aGenericFunc<aType:mapping> (theObj:aType, dict: [String:String]) -> AnyObject {
    return theObj.mapping(dict)
}
var aUser = user()
if let mappedUser = aGenericFunc(aUser, dict: ["name":"Carson"]) as? user{
    print(mappedUser.name)
}
//a car
var aCar = car()
//aCar = aGenericFunc(aCar, dict: ["brand":"benz"]) as! car
//print(aCar.brand)
if let mappedCar = aGenericFunc(aCar, dict: ["brand":"benz"]) as? car{
    print(mappedCar.brand)
}
//: [Previous](@previous)
