# showPrayers
This script will show you the prayer times


You need to install these packages:
* curl
* jq

Debian/Ubuntu/Pop!_OS/Linux Mint
 ```
 sudo apt install curl jq
 ```

Arch Linux/Manjaro
 ```
 sudo pacman -S curl jq
 ```

Fedora
 ```
 sudo dnf install curl jq
 ```

Then clone the repository (copy this command on your Terminal)
 ```
 git clone https://github.com/samad20/showPrayers.git
 ```
go to your ` Home Directory ` and open ` showPrayers ` folder then open ` showPrayers.sh ` file 

You need to change the values of five variables (Read the comments if you need help):
* lat
* long
* country
* method
* adjustment

Go back to your terminal and then change your directory to ` showPrayers `
 ```
 cd showPrayers
 ```

Run the script 
```
./showPrayers.sh
```
