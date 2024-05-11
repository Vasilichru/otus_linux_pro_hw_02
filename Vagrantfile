# -*- mode: ruby -*-
# vi: set ft=ruby :

# Описываем Виртуальные машины
MACHINES = {
  # Указываем имя ВМ "kernel update"
  :"kernel-update" => {
              #Какой vm box будем использовать
              :box_name => "ubuntu/jammy64",
              #Указываем box_version
              #:box_version => "4.3.4",
              #Указываем количество ядер ВМ
              :cpus => 4,
              #Указываем количество ОЗУ в мегабайтах
              :memory => 16384,
              #размер диска
              #:disk => 5000 #Mb
              #ip address
              #:ip_addr = >192.168.1.66

            }
}

Vagrant.configure("2") do |config|
  MACHINES.each do |boxname, boxconfig|
    #проброс общей папки в ВМ
    config.vm.synced_folder "vagrant_data", "/vagrant_data" #, disabled: true
    # Применяем конфигурацию ВМ
    config.vm.define boxname do |box|
      box.vm.box = boxconfig[:box_name]
      box.vm.box_version = boxconfig[:box_version]
      box.vm.host_name = boxname.to_s
      box.vm.provider "virtualbox" do |v|
        v.memory = boxconfig[:memory]
        v.cpus = boxconfig[:cpus]
        v.gui = true
        v.name = "kernel update test"
      #box.vm.network("private_network"), type: dhcp  #, ip: boxconfig[:ip_addr])
      
        
      end
    end
  end
end

