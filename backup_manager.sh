#!/bin/bash


#calling helper function

header() {
	clear
	echo "==============================="
	echo "  ROYALTEE BACKUP MANAGER"
	echo "==============================="
	echo
}

success() {
	echo
	echo "Operation completed successfully!"
	echo
}

pause() {
	read -p  "Press Enter to continue....."
}

# using while loop 
while true
do
	header

	echo "1. Create Folder"
	echo "2. Create File"
	echo "3. View Files"
	echo "4. Copy File"
	echo "5. Backup FIle"
	echo "6. Delete File"
	echo "7. Exit"
	echo
	read -p "Choose an option:" option
	case $option in
		1)
		read -p "Enter folder name: " folder
		if mkdir "$folder" 2>/dev/null
		then
			echo "Folder '$folder' created successfully"
		else
			echo
			echo "Folder already exists or could not be created"
		fi

		echo
		ls -lh

		pause ;;

		2)
		read -p "Enter file name: " file
		if touch "$file"
		then
			echo
			echo "File '$file' created successfully."
		else
			echo
			echo "Could not create file"
		fi
		echo
		ls -lh

		pause ;;

		3)
		echo
		echo "Current Directory:"
		pwd

		echo
		echo "Files:"
		ls -lh

		pause ;;

		4)
		read -p "Enter source file: " source
		read -p "Enter destination file: " destination

		if [ -f "$source" ]
		then
			if cp "$source" "$destination"
			then
				success
			else
				echo "Copy Operation failed."
			fi
			ls -lh
		else
			echo "Source file does not exist."
		fi
		pause ;;


		5)
		read -p "Enter file to backup: " file

		if [ -f "$file" ]
		then
			if [ ! -d "backups" ]	#add the backup code here
			then
				mkdir -p backups
				echo "Backup folder created."
			fi

		timestamp=$(date +"%Y%m%d_%H%M%S")
		filename=$(basename "$file")

		if cp "$file" "backups/${filename}_$timestamp"
		then
			echo
			echo "Backup completed successfully."
			success
		else
			echo
			echo "Backup operation failed"
		fi
		else
			echo "File does not exist."
			echo "Backup Cancelled"
		fi
		pause ;;

		6)
		read -p "Enter file to delete: " delete
		read -p "Are you sure you want to delete $delete? (y/n): " confirm

		if [ "$confirm" = "y" ]
		then
			if rm -- "$delete"
		then
			success
		else
			echo
			echo "Delete operation failed."
		fi
		else
			echo "Deletion Cancelled."
		fi
		pause ;;

		7)
		echo " Goodbye!"
		sleep 2
		break ;;

		*)
		echo "Invalid Option"
		pause ;;
esac

done
