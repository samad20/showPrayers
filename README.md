# showPrayers
This script will show you the prayer times
******************

![Screenshot_showPrayers ](https://raw.githubusercontent.com/samad20/showPrayers/main/Screenshot_showPrayers.png)

******************

You need to install these packages:
* curl
* jq
* coreutils (for macOS only)

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

macOS
 ```
 brew install coreutils jq
 ```

Then clone the repository (copy this command on your Terminal)
 ```
 git clone https://github.com/samad20/showPrayers.git
 ```
go to your ` Home Directory ` and open ` showPrayers ` folder then open ` showPrayers.sh ` file (if you have Linux) Or ` showPrayersMacOS.sh ` (if you have macOS)

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

Run the script (Linux)
```
./showPrayers.sh
```

Run the script (macOS)
```
./showPrayersMacOS.sh
```
