"""Created by sgoswami on 8/8/17."""
"""Merge two sorted linked lists and return it as a new list. The new list should be made by splicing together the 
nodes of the first two lists."""

# Definition for singly-linked list.


class ListNode(object):
    def __init__(self, x):
        self.val = x
        self.next = None


class Solution(object):
    def mergeTwoLists(self, l1, l2):
        """
        :type l1: ListNode
        :type l2: ListNode
        :rtype: ListNode
        """
        curr = head = ListNode(0)
        while l1 and l2:
            if l1.val < l2.val:
                curr.next = ListNode(l1.val)
                l1 = l1.next
            else:
                curr.next = ListNode(l2.val)
                l2 = l2.next
            curr = curr.next
        curr.next = l1 or l2
        return head.next

