//MARK: - Binary Tree

class TreeNode<T> {
  let value: T
  var leftChild: TreeNode?
  var rightChild: TreeNode?
  
  init(value: T) {
    self.value = value
  }
}

//A balanced but unsorted Binary Tree
class BinaryTree<T> {
  private var root: TreeNode<T>?
  var count = 0
  private var visitationQueue = Queue<TreeNode<T>>()
  
  func addNode(value: T) {
    if root == nil {
      root = TreeNode(value: value)
    }
    else {
      visitAndAdd(self.root!, value: value)
    }
    
    self.count += 1
  }
  
  //perform BFS, adding node to first open child
  //TODO: generalize the "visit" action by accepting a block
  private func visitAndAdd(atNode: TreeNode<T>, value: T) {
    if atNode.leftChild == nil {
      let newNode = TreeNode(value: value)
      atNode.leftChild = newNode
    }
    else if atNode.rightChild == nil {
      let newNode = TreeNode(value: value)
      atNode.rightChild = newNode
    }
    else {
      self.visitationQueue.enqueue(atNode.leftChild!)
      self.visitationQueue.enqueue(atNode.rightChild!)
      visitAndAdd(visitationQueue.dequeue()!, value: value)
    }
  }
  
  //TODO: implement removal of a node
}

//MARK: - Queue

class QueueNode<T> {
  let value: T
  var next: QueueNode?
  
  init(value: T) {
    self.value = value
  }
}

class Queue<T> {
  private var head: QueueNode<T>?
  private var end: QueueNode<T>?
  var count = 0 //Who doesn't want a count?
  
  func enqueue(element: T) {
    if head == nil {
      head = QueueNode(value: element)
      end = head
    }
    else {
      let newNode = QueueNode(value: element)
      //direct the current end node to point to our new node
      end?.next = newNode
      //now we have a new end node
      end = newNode
    }
    count += 1
  }
  
  func dequeue() -> T? {
    var value: T?
    //0 nodes in queue: nothing to return
    guard let headNode = self.head else { return nil }
    
    value = headNode.value
    //advance head to next node if extant, else nullify head
    self.head = (headNode.next == nil ? nil : headNode.next)
    
    count -= 1
    return value
  }
  
  //Check what's in front without removing
  func peek() -> T? {
    guard let headNode = self.head else { return nil }
    return headNode.value
  }
}

//MARK: - Tests

//A bunch of cars stop at a red light.
let trafficLane = Queue<String>()
trafficLane.enqueue("Toyota Corolla")
trafficLane.enqueue("Honda Civic")
print(trafficLane)
//Cars in opposite direction wonder which car is at the intersection?
if let frontCar = trafficLane.peek() { print(frontCar + " is at front of queue.") }
//a green left arrow occurs; the Corolla turns left
if let car = trafficLane.dequeue() { print(car + " dequeued.") }
//Civic now in front. It will also turn left.
if let frontCar = trafficLane.peek() { print(frontCar + " is at front of queue.") }
if let car = trafficLane.dequeue() { print(car + " dequeued.") }
//queue now empty; peek and dequeue will return nil
if let car = trafficLane.dequeue() { print(car + " dequeued.") }
