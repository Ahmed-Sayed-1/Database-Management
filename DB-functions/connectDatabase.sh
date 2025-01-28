#! /bin/bash

 read -p "Enter the name of the database" dbname
   cd ./DataBase
    if [ -d $dbname ]
    then
        echo "Database selected successfully"
        select TableChoice in CreateTable ListTables DropTable InsertIntoTable SelectFromTable DeleteFromTable UpdateTable Exit
        do
        case $TableChoice in        
        CreateTable)
             . ../Table-functions/createTable.sh
            ;;
        ListTables)
            echo "Enter the name of the database"
            read dbname
            ls $dbname
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
            echo "Enter the name of the database"
            read dbname
            echo "Enter the name of the table"
            read tablename
            echo "Enter the data to insert"
            read data
            echo $data >> $dbname/$tablename
            echo "Data inserted successfully"
            ;;
        SelectFromTable)
            echo "Enter the name of the database"
            read dbname
            echo "Enter the name of the table"
            read tablename
            cat $dbname/$tablename
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
            break
            ;;
            esac
            done
    else
        echo "Database does not exist"
    fi