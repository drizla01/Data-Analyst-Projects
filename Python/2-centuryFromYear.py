""" Given a year, return the the century it is in. 
    The first century spans from the year 1 up to and including the year 100,
    the second from the year 101 up to and including the year 200. etc

    Example:
    - For year = 1905, the output should be centuryFromYear(year) = 20;
    - For year = 1700, the output should be centuryFromYear(year) = 17
"""


def centuryFromYear(year):
    # Firstly, we get the integer quotient of the division of the year by 100
    # This will give us the first two digits, which would be the century
    cen = int(year / 100)
    # keep in mind that we only refer to 1701-1800 or 1901-2000 as 18th or 20th century
    # so we implement a while loop to make sure the year is always positive integer start from 1
    # if the remainder of the year by 100 is 0, then the century is the first two digits
    # otherwise we add 1 to the first two digits to give us the century.
    while year >= 1:
        if year % 100 == 0:
            return cen
        else:
            return cen + 1


ans = centuryFromYear(2001)
ans2 = centuryFromYear(1890)
ans3 = centuryFromYear(1501)
print(ans, ans2, ans3)
