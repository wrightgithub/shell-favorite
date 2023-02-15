#!/bin/bash

ROOT_DIR=./
COMMAND=vi
unset FILE_NAME 

while getopts ":f:p:o:h" opt_name
do
    case $opt_name in
        f) FILE_NAME=$OPTARG
           ;;
        p) ROOT_DIR=$OPTARG
           ;;
        o) COMMAND=$OPTARG
           ;;
        h) echo "-f 要搜索的文件名 , -p 搜索的文件夹路径"
           exit 0
           ;;
    esac
done

if [[ -z ${FILE_NAME} ]]; then
    echo "请输入-f 要搜索的文件名，支持模糊匹配，忽略大小写"
    exit 1;
fi


findResult=`find  "${ROOT_DIR}" -iname "*${FILE_NAME}*"`

filePathArray=(`echo ${findResult}|tr '\n' ' '`)

for i in "${!filePathArray[@]}";   
do   
    printf "[%s]:%s\n" "$i" "${filePathArray[$i]}"  
done
read -p "请选择要打开的文件:" number 

finalFile=${filePathArray[$number]}

echo "filepath is ${finalFile}"


if [[ $COMMAND == "sub" ]]; then
    /Applications/Sublime\ Text.app/Contents/SharedSupport/bin/subl $finalFile
elif [[ $COMMAND == "vscode"  ]]; then
    /Applications/Visual\ Studio\ Code.app/Contents/Resources/app/bin/code $finalFile
elif [[ $COMMAND == "idea" ]]; then
    /Applications/IntelliJ\ IDEA.app/Contents/MacOS/idea $finalFile
else 
    vi $finalFile
fi

