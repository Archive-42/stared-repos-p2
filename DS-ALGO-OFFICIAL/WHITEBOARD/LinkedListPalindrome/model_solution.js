/*
  The general approach we'll take for this problem is to compare
  the contents of the first half of the linked list with the second
  half. If the two halves match, then we have a palindrome. There
  are many ways to go about this. Even if your interviewee doesn't
  implement a solution quite like this, if their approach is sound
  and their code works, then they are good.




  For this problem, we'll have a fast runner and a slow runner. The
  fast runner traverses the list twice as quickly as the slow runner.
  So by the time the fast runner has reached the end of the list, the 
  slow runner has traversed half the list. As the slow runner moves,
  it adds the value of the node it is currently on to a stack. Now 
  all we have to do is continue traversing the slow runner and 
  compare the list value of the node it is currently on with the 
  top element of the stack (so we're checking the elements of the 
  first half of the linked list in reverse order).
*/

function isLinkedListPalindrome(listNode) {
  let fast = listNode;
  
  let slow = listNode;

  const stack = [];

  while (fast && fast.next) {
    stack.push(slow.value);
    slow = slow.next;
    fast = fast.next.next;
  }
  // fast is a valid node, but fast.next is not
  // this means we have a list with an odd number
  // of nodes, so we're going to skip the middle one
  if (fast) {
    slow = slow.next;
  }
  // compare each stack element with the current element
  // the slow runner sees; if there is a mismatch, return false
  while (slow) {
    const top = stack.pop();

    if (top !== slow.value) {
      return false;
    }

    slow = slow.next;
  }

  return true;
}

class ListNode {
  constructor(value) {
    this.value = value;
    this.next = null;
  }
}

const a = new ListNode(1);
const b = new ListNode(2);
const c = new ListNode(3);
const d = new ListNode(2);
const e = new ListNode(1);

a.next = b;
b.next = c;
c.next = d;
d.next = e;

const w = new ListNode(10);
const x = new ListNode(11);
const y = new ListNode(11);
const z = new ListNode(10);

w.next = x;
x.next = y;
y.next = z;

console.log(isLinkedListPalindrome(a)); // should print true
console.log(isLinkedListPalindrome(b)); // should print false since now the 'a' node is not included in the linked list

console.log(isLinkedListPalindrome(w)); // should print true
