#!/usr/bin/python3
"""
list all states from the database hbtn_0e_0_usa
    Usage: ./0-select_states.py <mysql username>
                                <mysql password>
                                <database name>

"""
import sys
import MySQLdb

if __name__ == "__main__":
    db = MySQLdb.connect(user=sys.argv[1], passwd=sys.argv[2], db=sys.argv[3])
    c = db.cursor()
    c.execute("SELECT * FROM `states` ")
    [print(state) for state in c.fetchall()]


# Line 12: This line of code checks whether the script is being executed as the main program.
# This is a standard way of writing Python scripts that can be imported and reused in other programs.

# Line 13:This line connects to a MySQL database using the MySQLdb library. It takes three arguments:
"""
user: the username used to connect to the database, passed as a command-line argument to the script (sys.argv[1]).
passwd: the password used to connect to the database, passed as a command-line argument to the script (sys.argv[2]).
db: the name of the database to connect to, passed as a command-line argument to the script (sys.argv[3]).
"""
# Line 14:This line creates a cursor object that allows us to interact with the database
# Line 15:This line executes a SQL query to select all records from a table named 'states'.
# The query is passed as a string to the execute() method of the cursor object.
# Line 16:This line fetches all the records returned by the SQL query and prints each of them on a new line using the print() function.
# It uses a list comprehension to loop through the records returned by the fetchall() method of the cursor object.
# The variable state is used to represent each record, and the print() function is called for each record.
