#!/usr/bin/python3
"""Displays all values in the states table of the database
    whose name matches that supplied as argument
    
    Usage ./2-filter_states.py  <mysql username>
                                <mysql password>
                                <database name>
"""

import sys
import MySQLdb

if __name__ == "__main__":
    db = MySQLdb.connect(user=sys.argv[1], passwd=sys.argv[2], db=sys.argv[3])
    c = db.cursor()
    c.execute(
        "SELECT * \
              FROM `states` \
              WHERE BINARY `name` = '{}'".format(
            sys.argv[4]
        )
    )
    [print(state) for state in c.fetchall()]
