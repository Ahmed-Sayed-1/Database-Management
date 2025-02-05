#! /bin/bash

    dataType(){
        select choice in string integer boolean
			do
				case $choice in
				"string")
					colDataType="string"
					break
					;;
				"integer")
					colDataType="integer"
					break
					;;
				"boolean")
					colDataType="boolean"
					break
					;;
				*)
					echo "Invalid choice, please select again."
                    dataType
					break
					;;
				esac
			done
    }

    read -p "Please Enter Table Name: " TBName
	if [[ -e ./DataBase/$dbname/$TBName ]]
	then
		echo "Table is Already Exist"
	else
        while true; do
            read -p "Please Enter Columns numbers: " colNum
            if [[ $colNum =~ ^[1-9][0-9]*$ ]]; then
                break
            else
                echo "Invalid input. Please enter a positive number."
            fi
        done
		flag=0
		for ((i=0;i<$colNum;i++))
		do
			line=""
			read -p "Please Enter name of Column number $(($i+1)): " colName
			line+=$colName:
			dataType
			line+=$colDataType:
			if [[ flag -eq 0 ]]
			then
            while true; do
                read -p "Do you want to make this column a primary key ? (y/n): " check
                if [[ $check == "y" || $check == "n" ]]; then
                    break
                else
                    echo "Invalid input. Please enter 'y' or 'n'."
                fi
            done
				if [[ yes =~ $check ]]
				then
					line+=pk
					flag=1
				fi
			fi
            echo $line >> ./DataBase/$dbname/.$TBName-metadata
		done
		touch ./DataBase/$dbname/$TBName
		echo "table created successfully"
	fi