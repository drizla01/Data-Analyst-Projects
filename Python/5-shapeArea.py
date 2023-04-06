"""Below we define an n-interesting polygon. your task is to find the area of 
polygon for a given n. A 1-interesting polygon is just a square with a side of length 1.
An n-interesting polygon is obtained by taking the (n-1)- interesting polygon and appending
1-interesting polygons to its rim, side by side (picture provided at www.codesignal.com)

    Example:
    For n=2, the output should be shapeArea(n)=5
    For n=3, the output should be shapeArea(n)=13,
"""


def shapeArea(n):
    # for polygon with 0-interesting, it has an area of 0
    if n == 0:
        return None
    # with polygon of 1-interesting, has area of 1
    elif n == 1:
        return 1
    # for polygon of n-interesting, it has an area equal to the sum of square n and
    # the square of n-1, based on the picture, the assumption is as follows
    # n**2 counts the number of blue square from the middle line upwards (including the blue squares of middle line)
    # (n-1)**2 counts the number of blue square from the middle line downward(excluding the blue squares of the middle line)
    # of course you can easily check the terms "upwards/downwards" could be inverted, without affecting the validity of your counting
    elif n > 1:
        return n**2 + ((n - 1) ** 2)


test = shapeArea(n=6)
print(test)
