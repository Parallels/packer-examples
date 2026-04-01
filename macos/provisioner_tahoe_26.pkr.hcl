source "parallels-ipsw" "tahoe_26" {
  output_directory = local.output_dir
  boot_command     = local.boot_command

  boot_screen_config {
    boot_command     = ["<wait1s><enter>"]
    screen_name      = "Empty"
    matching_strings = []
    execute_only_once = true
  }

  boot_screen_config {
    boot_command     = ["<wait1s><enter>"]
    screen_name      = "GetStarted"
    matching_strings = ["Get Started"]
    execute_only_once = true
  }

  boot_screen_config {
    boot_command     = ["<wait1s><enter>"]
    screen_name      = "GetStarted1"
    matching_strings = ["hola"]
    execute_only_once = true
  }

  boot_screen_config {
    boot_command     = ["<wait1s><enter>"]
    screen_name      = "GetStarted2"
    matching_strings = ["hallo"]
    execute_only_once = true
  }


  boot_screen_config {
    boot_command     = ["<leftShiftOn><tab><leftShiftOff><spacebar>"]
    screen_name      = "Language"
    matching_strings = ["English", "Language", "Australia", "India"]
    execute_only_once = true
  }

  boot_screen_config {
    boot_command     = ["<leftShiftOn><tab><leftShiftOff><spacebar>"]
    screen_name      = "Country"
    matching_strings = ["Select Your Country or Region"]
  }

  boot_screen_config {
    boot_command = ["<tab><tab><tab><spacebar><tab><tab><spacebar>"]
    screen_name = "Data"
    matching_strings = ["transfer", "information"]
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
    boot_command     = ["<tab><tab><tab><tab><tab><tab>${local.ssh_username}<tab>${local.ssh_password}<tab>${local.ssh_password}<tab>${local.ssh_username}<tab><tab><tab><tab><spacebar>"]
    screen_name      = "CreateAccount"
    matching_strings = ["Create a Mac Account", "The password you create here"]
  }

  boot_screen_config {
    boot_command     = ["<leftCtrlOn><f7><leftCtrlOff><wait2s><leftShiftOn><tab><leftShiftOff><spacebar>"]
    screen_name      = "SignInToApple"
    matching_strings = ["Sign In to Your Apple Account", "Sign in to use iCloud"]
  }

  boot_screen_config {
    boot_command     = ["<tab><spacebar>"]
    screen_name      = "SignInWithApplePopup"
    matching_strings = ["Are you sure you want to skip", "signing in with an Apple ID?"]
  }

 boot_screen_config {
    boot_command     = ["<tab><tab><spacebar><wait2s><tab><spacebar>"]
    screen_name      = "TermsAndConditionsUK"
    matching_strings = ["Terms and Conditions", "macOS Software Licence Agreement", "Tahoe 26"]
  }
 
  boot_screen_config {
    boot_command     = ["<tab><tab><spacebar><wait2s><tab><spacebar>"]
    screen_name      = "TermsAndConditionsUS"
    matching_strings = ["Terms and Conditions", "macOS Software License Agreement", "Tahoe 26"]
  }

  boot_screen_config {
    boot_command     = ["<leftShiftOn><tab><leftShiftOff><spacebar><wait2s><tab><spacebar>"]
    screen_name      = "LocationServices"
    matching_strings = ["Enable Location Services", "About Location Services"]
  }
 
  # Time Zone Selection
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
 
  # Screen Time
  boot_screen_config {
    boot_command     = ["<leftShiftOn><tab><leftShiftOff><spacebar>"]
    screen_name      = "ScreenTime"
    matching_strings = ["Screen Time", "Get insights about your"]
  }
 
  # Siri Configuration
  boot_screen_config {
    boot_command     = ["<tab><spacebar><tab><tab><tab><spacebar>"]
    screen_name      = "Siri"
    matching_strings = ["Siri", "Siri helps you get things done"]
  }
 
  boot_screen_config {
    boot_command     = ["<tab><tab><spacebar><wait2s><tab><spacebar>"]
    screen_name      = "FileVault"
    matching_strings = ["Your Mac is Ready for FileVault", "encrypting your data", "Not Now"]
  }
 
  boot_screen_config {
    boot_command     = ["<tab><tab><tab><tab><spacebar>"]
    screen_name      = "Looks"
    matching_strings = ["Choose your look", "Select an appearance"]
  }

    boot_screen_config {
    boot_command     = ["<tab><tab><tab><spacebar>"]
    screen_name      = "UpdateMacAutomatically"
    matching_strings = ["Update Mac Automatically", "Software Update settings", "Only Download Automatically"]
  }

   boot_screen_config {
    boot_command     =  [
      "<leftShiftOn><leftSuperOn>G<leftSuperOff><leftShiftOff>/Applications/Utilities/Terminal.app<enter><leftSuperOn>o<leftSuperOff>", # Open terminal
      ]
    screen_name      = "Desktop"
    matching_strings = ["Finder", "Go"]
    execute_only_once = true
  } 
  
    # 1. SETUP & REBOOT 
  boot_screen_config {
    boot_command = [
      "<leftCtrlOn>c<leftCtrlOff><enter><wait2s>", 
      "sudo visudo /private/etc/sudoers.d/${local.ssh_username}<enter><wait5s>",
      "${local.ssh_password}<enter><wait3s>",
      "i${local.ssh_username} ALL = (ALL) NOPASSWD: ALL<esc>:wq!<enter><wait2s>",
      
      #Turn on SSH without needing 'Full Disk Access'
      "sudo launchctl load -w /System/Library/LaunchDaemons/ssh.plist<enter><wait2s>",
      
      # Reset the Privacy Database to ensure Parallels isn't blocked
      "sudo tccutil reset All com.parallels.desktop.mobile<enter><wait1s>",
      
      #Restart the IP reporter
      "sudo launchctl stop com.parallels.desktop.mobile.launchdaemon<enter><wait1s>",
      "sudo launchctl start com.parallels.desktop.mobile.launchdaemon<enter><wait1s>",
      
      "sudo reboot<enter>"
    ]
    screen_name      = "TerminalSetup"
    matching_strings = ["${local.ssh_username}@macos-26", "Last login", "%"]
    execute_only_once = true
  }

  boot_screen_config {
    boot_command     = ["<wait5s>${local.ssh_password}<enter>"]
    screen_name      = "PostRebootLogin"
    matching_strings = ["parallels", "Enter Password"]
  }


    # 3. THE UNSTUCK FIX (The macOS 26 Network & SSH Fix)
    boot_screen_config {
    boot_command = [
    "<leftCtrlOn>c<leftCtrlOff><enter><wait2s>", 
    # Fix 1: Create directory AND file in one go
    "mkdir -p ~/.ssh && printf 'Host *\\n    StrictHostKeyChecking no\\n    UserKnownHostsFile=/dev/null\\n' > ~/.ssh/config<enter><wait1s>",
    
    # Fix 2: Pipe the password directly so it isn't "typed" as a new command
    "echo '${local.ssh_password}' | sudo -S ipconfig set en0 DHCP<enter><wait2s>",
    
    "sudo ipconfig set en1 DHCP<enter><wait2s>", 
    "sudo launchctl stop com.parallels.desktop.mobile.launchdaemon && sudo launchctl start com.parallels.desktop.mobile.launchdaemon<enter><wait5s>", 
    
    # Start the install
    "sudo '/Volumes/Parallels Tools/Install.app/Contents/MacOS/PTIAgent' --install<enter>"
  ]
    screen_name      = "UnstuckTerminal"
    matching_strings = ["Restored", "parallels@macos-26", "zsh"]
    execute_only_once = true
  }

  # 4. SUCCESS HANDLER (Keep this to catch the final reboot)
  boot_screen_config {
    boot_command     = ["<spacebar><wait2s><enter>"]
    screen_name      = "PDSuccess"
    matching_strings = ["Installed successfully", "Restart"]
    is_last_screen   = true
  }

  boot_screen_config {
    boot_command     = ["<wait3s><spacebar>"]
    screen_name      = "WelcomeScreen"
    matching_strings = ["Welcome to mac", "Continue"]
    execute_only_once = true
  }


  boot_wait        = "${var.boot_wait}"
  shutdown_command = "sudo shutdown -h now"
  ipsw_url         = local.ipsw_url
  ipsw_checksum    = local.ipsw_checksum
  ssh_username     = "${local.ssh_username}"
  ssh_password     = "${local.ssh_password}"
  vm_name          = "${local.machine_name}"
  cpus             = "${var.machine_specs.cpus}"
  memory           = "${var.machine_specs.memory}"
}
