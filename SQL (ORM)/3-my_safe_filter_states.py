#!/usr/bin/python3
"""Display all values in the states table of the database
whose name matches that supplied as argument
Safe from SQL injections

    Usage ./3-my_safe_filter_states.py  <mysql username>
                                        <mysql password>
                                        <database name>
"""
import sys
import MySQLdb

if __name__ == "__main__":
    db = MySQLdb.connect(user=sys.argv[1], passwd=sys.argv[2], db=sys.argv[3])
    c = db.cursor()
    c.execute("SELECT * FROM `states`")
    [print(state) for state in c.fetchall() if state[1] == sys.argv[4]]
# if state[1] == sys.argv[4] checks if the second element (index 1) of the state tuple is equal to the value of the fourth command line argument (sys.argv[4]).
# This means that the code is filtering the data to only include rows where the second column matches a specific value passed in as an argument when the script is run.
