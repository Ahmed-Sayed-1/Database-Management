#! /bin/bash

echo "Enter the name of the database"
read dbname
echo "Enter the name of the table"
read tablename
touch $dbname/$tablename
echo "Table created successfully"