#! /bin/bash

PS1="DBMS> "

shopt -s extglob

select Choice in CreateDatabase ListDatabases SelectDB DropDatabase Exit

do

case $Choice in 

CreateDatabase)
    echo "Enter the name of the database"
    read dbname
    mkdir $dbname
    echo "Database created successfully"
    ;;
ListDatabases)
    ls -d */
    ;;
DropDatabase)
    echo "Enter the name of the database"
    read dbname
    rm -r $dbname
    echo "Database deleted successfully"
    ;;
SelectDB)
    echo "Enter the name of the database"
    read dbname
    if [ -d $dbname ]
    then
        echo "Database selected successfully"
        select TableChoice in CreateTable ListTables DropTable InsertIntoTable SelectFromTable DeleteFromTable UpdateTable Exit
        do
        case $TableChoice in        
        CreateTable)
            echo "Enter the name of the database"
            read dbname
            echo "Enter the name of the table"
            read tablename
            touch $dbname/$tablename
            echo "Table created successfully"
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
    ;;
Exit)
    break
    ;;
*)
    echo "Unknown choice"
    ;;
esac
done
