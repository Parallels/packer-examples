iso_url      = "" #path to your generated iso
iso_checksum = "" #the generated iso checksum in this format "sha256:xxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxxx", check readme in how to generate
machine_specs = {
  cpus      = 2,
  memory    = 2048,
  disk_size = "65536",
}
addons             = []    # list of addons to be installed, check readme for more info
create_vagrant_box = false # set to true if you want to create a vagrant box

