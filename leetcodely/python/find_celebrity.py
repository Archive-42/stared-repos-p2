"""Created by sgoswami on 7/11/17."""
"""Suppose you are at a party with n people (labeled from 0 to n - 1) and among them, there may exist one celebrity. 
The definition of a celebrity is that all the other n - 1 people know him/her but he/she does not know any of them.

Now you want to find out who the celebrity is or verify that there is not one. The only thing you are allowed to do is 
to ask questions like: "Hi, A. Do you know B?" to get information of whether A knows B. You need to find out the 
celebrity (or verify there is not one) by asking as few questions as possible (in the asymptotic sense).

You are given a helper function bool knows(a, b) which tells you whether A knows B. 
Implement a function int findCelebrity(n), your function should minimize the number of calls to knows.

Note: There will be exactly one celebrity if he/she is in the party. Return the celebrity's label if there is a 
celebrity in the party. 
If there is no celebrity, return -1."""

# The knows API is already defined for you.
# @param a, person a
# @param b, person b
# @return a boolean, whether a knows b


def knows(a, b):
    pass


class Solution(object):
    def findCelebrity(self, n):
        """
        :type n: int
        :rtype: int
        """
        x = 0
        for i in range(n):
            if knows(x, i):
                x = i
        for i in range(n):
            if i != x and (knows(x, i) or not knows(i, x)):
                return -1
        return x


