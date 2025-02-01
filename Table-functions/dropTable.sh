#! /bin/bash

read -p "Enter the name of the database: " db_name
if [[ -e ./DataBase/$db_name ]]
	then
		read -p "Enter the Table name : " tb_name
        if [[ -e ./DataBase/$db_name/$tb_name ]]
            then
                rm -i DataBase/$db_name/$tb_name
                rm -i DataBase/$db_name/.$tb_name-metadata
                clear
                echo "Table deleted successfully"
             else
                echo "Table dose not existing"
        fi
    else
        echo "database dose not existing"
fi