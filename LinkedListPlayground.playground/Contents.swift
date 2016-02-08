class LLNode<T> {
  var value: T
  var previous: LLNode?
  var next: LLNode?
  init(value: T) {
    self.value = value
  }
}

class LinkedList<T: Equatable> { //we enforce Equatable so we can lookup elements by value later
  private var head: LLNode<T>?
  private var count = 0
  
  func addNode(value: T) {
    //if head is nil, create head node
    if head == nil {
      head = LLNode(value: value)
    }
    else {
      //traverse nodes until we find an unused one
      var current = head!
      while current.next != nil {
        current = current.next!
      }
      let newChild = LLNode<T>(value: value)
      current.next = newChild
      newChild.previous = current
    }
    count += 1
  }
  
  func removeNode(atIndex: Int)  {
    guard atIndex >= 0 && atIndex <= count else {
      return
    }
    
    var current = head
    
    if atIndex == 0 {
      //remove head
      current = current?.next
      head = current
      current?.previous = nil
    }
    else {
      //advance current pointer to node # atIndex
      for _ in 0..<atIndex {
        current = current?.next
      }
      current?.next?.previous = current?.previous
      current?.previous?.next = current?.next
    }
    count -= 1
  }
  
  //finds the first index at which this value occurs
  //if value isn't present in the list, returns -1
  func findIndex(forThisValue: T) -> Int{
    var current = head
    var currentIndex = 0
    while current?.value != forThisValue {
      if current?.next != nil {
        current = current?.next
        currentIndex += 1
      }
      else { return -1 }
    }
    return currentIndex
  }
  
  func printList() {
    guard var current = head else { return } //empty list
    print(current.value)
    while current.next != nil {
      current = current.next!
      print(current.value)
    }
  }
  
}

var myLL = LinkedList<String>()
myLL.addNode("cat")
myLL.addNode("dog")
myLL.addNode("supercat")
var evilAnimal = myLL.findIndex("dog") //oops, no dogs allowed
myLL.removeNode(evilAnimal)
evilAnimal = myLL.findIndex("manatee") //no manatees either!
myLL.removeNode(evilAnimal) //no error, even though index is invalid (-1)
myLL.addNode("mountain lion")
myLL.printList() //cat, supercat, mountain lion