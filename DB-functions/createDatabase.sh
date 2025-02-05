#! /bin/bash

read -p "Enter the name of the database: " dbname
	if [[ ! -d ./DataBase ]]
		then 
			mkdir ./DataBase
	fi
		
	if [[ -d ./DataBase/$dbname ]]
	then
		echo Database is already exist
	else
		cd ./DataBase
        mkdir $dbname
		echo "Database is created successfully"
        cd ../
	fi
	