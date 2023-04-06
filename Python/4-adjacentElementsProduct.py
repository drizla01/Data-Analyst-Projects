"""Given an array of integers, find the pair of ajacent elements that has the largest product
and return the product.

    Example:
    for inputArray = [2, 6, -2, -5, 7, 3] the output should be adjacentElementsProduct(inputArray) = 21
    where 7 and 3 are the largest product
"""


def adjacentElementsProduct(inputArray):
    # intialize an empty array that will store the product of the adjacent elements in the array
    arrayEnd = []
    # use a for loop to go over all entries on the inputted array,
    # calculating the product of each adjacent elements and
    # appending it in the empty array define above
    for i in range(len(inputArray) - 1):
        arrayEnd.append(inputArray[i] * inputArray[i + 1])
    # identify the maximum product in the array and return it
    maximum = max(arrayEnd)
    return maximum


adj = adjacentElementsProduct(inputArray=[4, 2, 4, 2, 5, 3, 5, 3, -9, 4, 6, -7, 6])
print(adj)
