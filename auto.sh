#!/bin/bash

tmpConfigs=`ls .config`
update=""

while IFS= read -r config; do
    for tmpConfig in $tmpConfigs; do
      if (($config == $tmpConfig)); then 
        update="$update $config"
        break
      fi
    done
done < config

folder=$(pwd)

for tmp in ${update[@]};  do 
  if [ "$tmp" == "vscode" ]; then 
    echo $tmp
    rm -rf "$folder/.config/vscode"
    mkdir "$folder/.config/vscode"
    cp "$HOME/.config/Code/User/settings.json" "$folder/.config/vscode"
    cp "$HOME/.config/Code/User/keybindings.json" "$folder/.config/vscode"
  else
    rm -rf ".config/$tmp"
    cp -r "$HOME/.config/$tmp" "$folder/.config/"
  fi 
done 

git add . 
git commit -m "update"
git push 
