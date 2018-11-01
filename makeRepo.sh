#!/bin/bash


# Enter your username here
USERNAME=JulianKeller

# get the name of the directory
echo "What is the name of the repo?"
read REPO

# check if the directory already exists
if [ -d $PWD/$REPO ]
then
	echo "A folder with that name already exists."
	exit 1
else
	# create the new directory
	# mkdir $PWD/$REPO 		# mkdir at the current directory
	mkdir $REPO
fi

# navigate into the folder
cd $REPO

echo "README.md and .gitignore have been created for you."
echo "Would you like to create any other files in your repo? (y/n)"
read ANSWER

# Get files to be added to repo
if [ "$ANSWER" = "Y" ] || [ "$ANSWER" = "y" ]
then
	FILENAME="file"
	while [ "$FILENAME" != "q" ]; do
		echo "Enter filename with extension: ('q' to continue)"
		read FILENAME
		if [ "$FILENAME" = "" ] || [ "$FILENAME" = "q" ]
		then
			break
		fi
		touch $FILENAME
	done
fi


# initialize the git repo
git init

# create files
touch README.md
touch .gitignore

# add the files to the git repo
git add .
git commit -m "initial commit"


# Create the repo on github
curl -u $USERNAME https://api.github.com/user/repos -d '{"name":"'$REPO'"}'

# push to github
git remote add origin https://github.com/${USERNAME}/${REPO}.git
git remote -v
git push -u origin master





