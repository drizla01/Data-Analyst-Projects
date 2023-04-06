"""Given the string, check if it is palindrome
    
    Example:
    - For inputString = "aabaa" the output should be checkPalindrome(inputString) = true
    - For inputString = "adaa" the output should be checkPalindrome(inputString) = false
    - For inputString = "b" the output should be checkPalindrome(inputString) = true 
"""


def checkPalindrome(inputString):
    # convert all letters to lowercase
    inp = inputString.lower()
    # remove space between letters
    inp = inp.replace(" ", "")
    # define a variable called reverse to mirror our original inputted String
    reverse = inp[::-1]
    # if the reverse and the input are thesame return true otherwise false
    if reverse == inp:
        return True
    return False


pal = checkPalindrome(inputString="aba")
pal2 = checkPalindrome(inputString="aab  aaa")
pal3 = checkPalindrome(inputString="abdjbnla")
pal4 = checkPalindrome(inputString="aabaabaaba  a")
print(pal, pal2, pal3, pal4)
