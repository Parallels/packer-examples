# Boot Commands for Mac OS Ventura 13

This is the screen configuration to boot the Mac OS Ventura for an automated installation. While this should work in most cases as they depend on matching strings provided. If this happens you can print log by enabling logs (export PACKER_LOG=1) in the terminal, packer will print the best detected text in the logs. You can use this text to fine tune the matching_strings and restart the automation.

```text
    boot_screen_config {
    boot_command     = ["<wait1s><enter>"]
    screen_name      = "Empty"
    matching_strings = []
  }
  boot_screen_config {
    boot_command     = ["<wait1s><enter>"]
    screen_name      = "GetStarted"
    matching_strings = ["Get Started"]
  }
  boot_screen_config {
    boot_command     = ["<wait1s><enter>"]
    screen_name      = "GetStarted"
    matching_strings = ["hola"]
  }
  boot_screen_config {
    boot_command     = ["<wait1s><enter>"]
    screen_name      = "GetStarted"
    matching_strings = ["hallo"]
  }
  boot_screen_config {
    boot_command     = ["<leftShiftOn><tab><leftShiftOff><spacebar>"]
    screen_name      = "Language"
    matching_strings = ["English", "Language", "Australia", "India"]
  }
  boot_screen_config {
    boot_command     = ["<leftShiftOn><tab><leftShiftOff><spacebar>"]
    screen_name      = "Country"
    matching_strings = ["Select Your Country or Region"]
  }
  boot_screen_config {
    boot_command     = ["<leftShiftOn><tab><leftShiftOff><spacebar>"]
    screen_name      = "SpokenLanguages"
    matching_strings = ["Written and Spoken Languages"]
  }
  boot_screen_config {
    boot_command     = ["<leftShiftOn><tab><leftShiftOff><spacebar>"]
    screen_name      = "Accessibility"
    matching_strings = ["Accessibility", "Vision", "Hearing", "Motor", "Cognitive"]
  }
  boot_screen_config {
    boot_command     = ["<leftShiftOn><tab><leftShiftOff><spacebar>"]
    screen_name      = "DataAndPrivacy"
    matching_strings = ["Data", "Privacy", "This icon appears"]
  }
  boot_screen_config {
    boot_command     = ["<tab><tab><tab><spacebar>"]
    screen_name      = "MigrationAssistant"
    matching_strings = ["Migration Assistant", "From a Mac", "Time Machine backup"]
  }
  boot_screen_config {
    boot_command     = ["<leftShiftOn><tab><tab><leftShiftOff><spacebar>"]
    screen_name      = "SignInWithApple"
    matching_strings = ["Sign in with your apple ID", "Sign in to use iCloud"]
  }
  boot_screen_config {
    boot_command     = ["<tab><spacebar>"]
    screen_name      = "SignInWithApplePopup"
    matching_strings = ["Are you sure you want to skip", "signing in with an Apple ID?"]
  }
  boot_screen_config {
    boot_command     = ["<leftShiftOn><tab><leftShiftOff><spacebar><wait1s><tab><spacebar>"]
    screen_name      = "TermsAndConditions"
    matching_strings = ["Terms and Conditions", "macOS Software Licence Agreement"]
  }
  boot_screen_config {
    boot_command     = ["${local.ssh_username}<tab><tab>${local.ssh_password}<tab>${local.ssh_password}<tab><tab><tab><spacebar>"]
    screen_name      = "CreateAccount"
    matching_strings = ["Create a Computer Account", "Fill out the following information"]
  }
  boot_screen_config {
    boot_command     = ["<leftShiftOn><tab><leftShiftOff><spacebar><wait2s><tab><spacebar>"]
    screen_name      = "LocationServices"
    matching_strings = ["Enable Location Services", "About Location Services"]
  }
  boot_screen_config {
    boot_command     = ["<leftShiftOn><tab><leftShiftOff><spacebar>"]
    screen_name      = "TimeZone"
    matching_strings = ["Select your Time Zone"]
  }
  boot_screen_config {
    boot_command     = ["<leftShiftOn><tab><leftShiftOff><spacebar>"]
    screen_name      = "Analytics"
    matching_strings = ["Share Mac Analytics with Apple"]
  }
  boot_screen_config {
    boot_command     = ["<leftShiftOn><tab><leftShiftOff><spacebar>"]
    screen_name      = "ScreenTime"
    matching_strings = ["Screen Time", "Get insights about your"]
  }
  boot_screen_config {
    boot_command     = ["<tab><spacebar><tab><tab><tab><spacebar>"]
    screen_name      = "Siri"
    matching_strings = ["Siri", "Siri helps you get things done"]
  }
  boot_screen_config {
    boot_command     = ["<leftShiftOn><tab><leftShiftOff><spacebar>"]
    screen_name      = "Looks"
    matching_strings = ["Choose your look", "Select an appearance"]
  }
  boot_screen_config {
    boot_command = [
      "<leftCtrlOn><f7><leftCtrlOff>",                                                  #enable keyboard navigation
      "<leftShiftOn><leftSuperOn>G<leftSuperOff><leftShiftOff>/Applications/System<spacebar>Settings.app<enter><leftSuperOn>o<leftSuperOff><wait2s>",   #open system settings
      "<up><wait><tab><wait><leftShiftOn><tab><tab><tab><tab><leftShiftOff><spacebar>", #sharing
    ]
    screen_name      = "Desktop"
    matching_strings = ["Finder", "Go"]
  }
  boot_screen_config {
    boot_command = ["<tab><tab><tab><tab><tab><tab><tab><tab><wait><spacebar><tab><spacebar>", #remote login on
      "<tab><spacebar><esc><leftSuperOn>q<leftSuperOff>", #quit system preferences
      "<leftShiftOn><leftSuperOn>G<leftSuperOff><leftShiftOff>/Applications/Utilities/Terminal.app<enter><leftSuperOn>o<leftSuperOff>" #open terminal
    ]
    screen_name      = "Sharing"
    matching_strings = ["File Sharing", "Media Sharing", "Screen Sharing"]
  }
  boot_screen_config {
    boot_command     = ["<leftCtrlOn>cccc<leftCtrlOff><wait>sudo reboot<enter><wait>${local.ssh_password}<enter>"]
    screen_name      = "PDInstalled"
    matching_strings = ["Parallels Tools have been", "Installed successfully"]
    is_last_screen   = true
  }
  boot_screen_config {
    boot_command     = ["<spacebar>"]
    screen_name      = "RestartNotification"
    matching_strings = ["Do you want to terminate", "processes in this window"]
    is_last_screen   = true
  }
  boot_screen_config {
    boot_command     = ["<wait3s><spacebar>"]
    screen_name      = "InterruptedRestartNotification"
    matching_strings = ["interrupted restart", "Terminal"]
    is_last_screen   = true
  }
  boot_screen_config {
    boot_command = ["sudo visudo /private/etc/sudoers.d/${local.ssh_username}<enter><wait2s>",
      "${local.ssh_password}<enter><wait2s>",
      "i<wait>${local.ssh_username} ALL = (ALL) NOPASSWD: ALL",
      "<esc>:wq<enter><wait2s>",
      "sudo /Volumes/Parallels\\ Tools/Install.app/Contents/MacOS/PTIAgent<enter>"
    ]
    screen_name      = "Terminal"
    matching_strings = ["Terminal", "${local.ssh_username}@", "Last login:"]
  }
```
