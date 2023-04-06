"""Given a sequence of integers as an array, determine whether it is possible to obtain a strictly
increasing sequence by removing no more than one element from the array

Note: sequence a0, a1, ..., an is considered to be a strictly increasing if a0<a1< ... < an
Sequence containing only one element is also considered to be strictly increasing 

Example:
- For sequence = [1, 3, 2, 1], the output should be almostIncreasingSequence(sequence) = false
There is no one element in this array that can removes in order to get a strictly increasing sequence
- For sequence = [1, 3, 2] the output should be almostIncreasingSequence(sequence) = true
You can remove 3 from the array to get the strictly increasing sequence [1,2]
Alternately, you can remove 2 to get strictly increasing sequence [1,3].
"""


def almostIncreasingSequence(sequence):
    # firstly, we assign the length of the sequence to a variable n
    n = len(sequence)
    # by definition if the sequence contain up to 1 element, it is considered to be strictly increasing
    if n <= 2:
        return True
    # we set up two count c1 and c2 to count how many elements should be removed.
    # Note: c1 refers only to adjacent elements and c2 refers to elements just before and after i-th element
    c1 = 0
    c2 = 0
    # the for loop start from 1 to n-1, n-1 because we dont want our index to go out of loop range of n
    for i in range(1, n - 1):
        # if the element after the index i is bigger than i, we add 1 to the counter c1
        if sequence[i - 1] >= sequence[i]:
            c1 += 1
        # if the element just before the index i is bigger than the element after the index i, we add 1 to counter c2
        if sequence[i - 1] >= sequence[i + 1]:
            c2 += 1
        # if the element two place to the left is bigger than the element one place to the left
        # we add 1 to counter 1
    if sequence[n - 1] <= sequence[n - 2]:
        c1 += 1
    # if both counter have up to 1 hit (i.e 0 or 1 each), then the sequence is almost increasing.
    if c1 <= 1 and c2 <= 1:
        return True
    False


test = almostIncreasingSequence(sequence=[1, 3, 2, 1])
print(test)
