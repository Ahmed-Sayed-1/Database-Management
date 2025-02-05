#! /bin/bash

read -p "Enter the name of the database: " dbname

	if [[ -z "$dbname" ]]; then
    	echo "Database name cannot be empty."
    	DB-menu
	fi

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
	