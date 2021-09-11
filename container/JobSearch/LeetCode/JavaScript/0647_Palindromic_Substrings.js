// Given a string, your task is to count how many palindromic substrings in this string.

// The substrings with different start indexes or end indexes are counted as different substrings even they consist of same characters.

// Example 1:

// Input: "abc"
// Output: 3
// Explanation: Three palindromic strings: "a", "b", "c".
 

// Example 2:

// Input: "aaa"
// Output: 6
// Explanation: Six palindromic strings: "a", "a", "a", "aa", "aa", "aaa".
 

// Note:

// The input string length won't exceed 1000.
/**
 * @param {string} s
 * @return {number}
 */

function countSubstrings(s) {
  let count = 0
  for (let i = 0; i < s.length; i++){
    count += countPalindromes(s, i, i)     // for odd length palindromes
    count += countPalindromes(s, i, i + 1) // for even length palindromes
  }
  return count;
}
  
function countPalindromes(s, l, r){
  let count = 0
  while (l >= 0 && r < s.length && s[l] === s[r]) { count++; l--; r++ }
  return count;
}

console.log(countSubstrings("abc"))
console.log(countSubstrings("aaa"))
console.log(countSubstrings("aaaa"))
console.log(countSubstrings("tracecars"))