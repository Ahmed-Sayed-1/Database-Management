#! /bin/bash

 show(){
        select TableChoice in CreateTable ListTables DropTable InsertIntoTable SelectFromTable DeleteFromTable UpdateTable Exit
        do
        case $TableChoice in        
        CreateTable)
            . ./Table-functions/createTable.sh
            show
            ;;
        ListTables)
            ls ./DataBase/$dbname
            show
            ;;
        DropTable)
            echo "Enter the name of the database"
            read dbname
            echo "Enter the name of the table"
            read tablename
            rm $dbname/$tablename
            echo "Table deleted successfully"
            ;;
        InsertIntoTable)
            . ./Table-functions/InsertIntoTable.sh
            show
            ;;
        SelectFromTable)
            . ./Table-functions/selectFromTable.sh
            ;;
        DeleteFromTable)
            echo "Enter the name of the database"
            read dbname
            echo "Enter the name of the table"
            read tablename
            echo "Enter the data to delete"
            read data
            sed -i "/$data/d" $dbname/$tablename
            echo "Data deleted successfully"
            ;;
        UpdateTable)
            echo "Enter the name of the database"
            read dbname
            echo "Enter the name of the table"
            read tablename
            echo "Enter the old data"
            read olddata
            echo "Enter the new data"
            read newdata
            sed -i "s/$olddata/$newdata/g" $dbname/$tablename
            echo "Data updated successfully"
            ;;
        Exit)
            exit
            ;;
            esac
            done
    }

    read -p "Enter the name of the database: " dbname
    echo "Database selected successfully"
    if [ -d ./DataBase/$dbname ]
    then
       show 
    else
        echo "Database does not exist"
    fi
    