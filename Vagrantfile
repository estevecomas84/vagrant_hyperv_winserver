servers = [
   { :host => "server-1",
     :type => "node",
     :box => "StefanScherer/windows_2019",
     :ip => "192.168.10.186",
     :cpu => 4,
     :ram => 3048
   },
   { :host => "server-2",
     :type => "node",
     :box => "gusztavvargadr/windows-server-2022-standard",
     :ip => "192.168.10.187",
     :cpu => 2,
     :ram => 2048
   },
  
]
Vagrant.configure("2") do |config|
 # The main cluster node loop
   servers.each do |mv|

    # The per node 'config' loop
      config.vm.define mv[:host] do |config|

       # Setup the mv distribution and network
       config.vm.box = mv[:box]
       config.vm.network "public_network", :dev => "VIRTUAL", ip: mv[:ip], :netmask => "255.255.255.0"
       config.vm.hostname = "#{mv[:host]}"
       config.vm.synced_folder ".", "/vagrant", disabled: true
       config.winrm.username = "vagrant"
       config.winrm.password = "vagrant"
       config.winrm.ssl = true
       #config.vm.boot_timeout = 600
       #   vagrant plugin install vagrant-rdp (terminal)
       #config.vm.network :forwarded_port, guest: 3389, host: 3389, auto_correct: true
       config.vm.network :forwarded_port, guest: 5985, host: 5987, id: "winrm", auto_correct: true
       config.vm.communicator = "winrm"  #"winssh"  
       config.vm.provider "hyperv" do |vb|
        vb.cpus = mv[:cpu]
        vb.memory = mv[:ram]
       end 
       config.vm.provision :shell, privileged: "true", path: "./setup.ps1"
      end
   end       
end
