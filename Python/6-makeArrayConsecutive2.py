""" Ratiorg got statues of different sizes as a present from CodeMaster for his birthday, each statue having an non negative integer size.
Since he likes to makes things perfect, he wants to arrange them from smallest to largest soo that each statue will be bigger that the previous
one exactly by 1. He made need some additional statues to be able to accomplish that. Help him figure out the minimum number
of additional statues needed.
    Example:
    for statues = [6,4,2,3,8], the output should be makeArrayConsecutive2(statues) = 2,
    Ratiorg needs statues of sizes, 5 and 7
"""


def makeArrayConsecutive2(statues):
    # we begin by creating a variable which sort the original statues list in the right order
    stat_arr = sorted(statues)
    # next we use the first element of the sorted array as our index
    i = stat_arr[0]
    # create an empty list that will store our missing  statues
    result = list()
    # we initiate a while loop to make sure the index is not equal to the last entry (largest)
    # of the stat_arr, make sure the increament is by 1 to be able to properly count the entries
    while i != stat_arr[-1]:
        i += 1
        # use the if to determine how many skips element are in the array
        # if it not we skip to the next higher element and so on.
        if i not in stat_arr:
            result.append(i)
        continue
    # return the length or size of the missing statues
    return len(result)


test = makeArrayConsecutive2(statues=[6, 4, 2, 3, 8])
print(test)
