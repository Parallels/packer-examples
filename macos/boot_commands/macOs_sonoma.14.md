# Boot Commands for Mac OS Sonoma 14

This is the key sentence to boot the Mac OS Sonoma 14 for an automated installation. While this should work in most cases as they depend in waiting times this can sometimes lead to a failed installation. If this happens you can try to increase the waiting times or add more waiting times between the commands. This will also install brew package manager and Parallels Desktop Tools.

```text
"<wait><enter><wait2s><enter><wait20s>",              # Wait for boot
"<leftShiftOn><tab><leftShiftOff><spacebar><wait5s>", # Select country
"<leftShiftOn><tab><leftShiftOff><spacebar><wait1s>", #Select language
"<leftShiftOn><tab><leftShiftOff><spacebar>",         #Accessibility
"<leftShiftOn><tab><leftShiftOff><spacebar><wait2s>", #Data and Privacy
"<tab><tab><tab><spacebar><wait2s>",                  #Migration assistant
"<leftShiftOn><tab><tab><leftShiftOff><spacebar><wait2s><tab><spacebar><wait5s>",
"<leftShiftOn><tab><leftShiftOff><spacebar><wait2s><tab><spacebar><wait2s>",                                          #Terms and Conditions
"${local.username}<tab><tab>${local.password}<tab>${local.password}<tab><tab><tab><spacebar><wait2m>", #Create a computer account
"<leftShiftOn><tab><leftShiftOff><spacebar><wait2s><tab><spacebar><wait2s>",                                          #Enable location services
"<leftShiftOn><tab><leftShiftOff><spacebar><wait20s>",                                                                #Select your time zone
"<leftShiftOn><tab><leftShiftOff><spacebar><wait2s>",                                                                 #Analytics
"<leftShiftOn><tab><leftShiftOff><spacebar><wait20s>",                                                                #Screen Time
"<tab><spacebar><tab><tab><tab><spacebar><wait10s>",                                                                  #Siri
"<leftShiftOn><tab><leftShiftOff><spacebar><wait60s>",                                                                #Choose your look
"",
"<leftCtrlOn><f7><leftCtrlOff>",                                                #enable keyboard navigation
"<leftSuperOn><spacebar><leftSuperOff>System<spacebar>Settings<enter><wait5s>", #open system settings
"Gen<tab><tab><tab><tab><tab><tab><tab><tab><spacebar><wait5s>",                #Sharing screen
"<tab><tab><tab><tab><tab><tab><tab><tab><spacebar><wait5s>",                   #turn on remote login
"<tab><spacebar>",                                                              #open dialog box
"<tab><spacebar><tab><up><tab><tab><tab><tab><spacebar><wait5s>",               #Done
"",
"<leftSuperOn><spacebar><leftSuperOff>terminal<enter><wait10s>", #open terminal
"sudo visudo /private/etc/sudoers.d/${local.username}<enter><wait2s>", #open vim
"${local.password}<enter><wait2s>", #password
"i<wait>${local.username} ALL = (ALL) NOPASSWD: ALL",
"<esc>:wq<enter><wait2s>", #save and quit
"NONINTERACTIVE=1 /bin/bash -c \"$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)\"<enter><wait3m>", #install homebrew
"(echo; echo 'eval \"$(/opt/homebrew/bin/brew shellenv)\"') >> /Users/parallels/.zprofile<enter><wait5s>",
"eval \"$(/opt/homebrew/bin/brew shellenv)\"<enter><wait5s>",

"sudo /Volumes/Parallels\\ Tools/Install.app/Contents/MacOS/PTIAgent<enter><wait2m>", #install parallels tools and restart
"<enter><wait5s><enter>"#restart
```
