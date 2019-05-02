#Created by Gayan Kavirathne on 25th February 2019. Version 01

#sample Code as follows

#First give shell script permission to execute by
#sudo chmod +x clone_or_update.sh

#Now run the script as follows
#./clone_or_update.sh repo "Repo Url" "Username" "password" "branch(If not set defaulting to master)"

directory="/home/gayankavirathne/PDRMax/pdrmax-backend/"
# directory="/home/gayan/Desktop/CiperLabs/PDRmax/pdrmax-backend/"
repository="bitbucket.org/zoomidev/pdrmax-backend"
username="gayansandaruwan"
password="*****"
branch="${5:-master}"

echo "Moving/Creating to Directory : ${directory}"
# mkdir $directory
cd $directory

# echo "Initializing an empty git repository, won't effect if there is already one"
# git init					#Initializing an empty git repository, won't effectif there is one already

# echo "Adding git remote : ${repository}"
# git remote add origin $repository		#Adding remote address
# echo "Using default/ user input branch  ${branch}"
# git reset --hard $branch  			#Ignoring any local changes

git config user.name $username
git config user.password $password


rawurlencode() {
  local string="${1}"
  local strlen=${#string}
  local encoded=""
  local pos c o

  for (( pos=0 ; pos<strlen ; pos++ )); do
     c=${string:$pos:1}
     case "$c" in
        [-_.~a-zA-Z0-9] ) o="${c}" ;;
        * )               printf -v o '%%%02x' "'$c"
     esac
     encoded+="${o}"
  done
  echo "$encoded"    				# You can either set a return variable (FASTER) 
 # RESULT="${encoded}"  			#+or echo the result (EASIER)... or both... :p
}

echo "Url encoding password and username"
encoded_password="$(rawurlencode "$password")"
#echo "${encoded_password}"
encoded_username="$(rawurlencode "$username")"

# arrIN=(${repository//@/ })
# echo "${arrIN[1]}"

url="https://"$encoded_username":"$encoded_password"@"${repository}
#echo "${url}"

git pull $url $branch				#pulling from git

process_details=$(ps -ef | grep "/usr/bin/node /home/gayankavirathne/PDRMax/pdrmax-backend/server/server.js")
array_by_space=($process_details)
echo ${array_by_space[1]}
echo process_details >> test.txt
# kill ${array_by_space[1]}



