#! /bin/bash

read -p "Enter the Table name : " tb_name

if [[ -e ./DataBase/$1/$tb_name ]]
then
    rm -i DataBase/$1/$tb_name
    if [[ ! -e ./DataBase/$1/$tb_name ]]
    then
        rm  DataBase/$1/.$tb_name-metadata
        echo "Table deleted successfully"
    else 
        echo "Table not deleted"
    fi
else
    echo "Table dose not existing"
fi

tableMenu