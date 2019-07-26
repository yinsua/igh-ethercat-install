## 1. 环境配置
* 默认使用Ubuntu16.04LTS及linux-image-4.4.0-140-lowlatency内核（下称“指定内核”）。（编写此文档时，igh最新版本为1.5.2，stable 1.5，内核最高支持4.4.x）
* 使用此脚本前，先确认已安装指定内核，安装内核方法如下：  
##### a. 正常启动到任意版本系统  
##### b. 执行`sudo apt-get install linux-image-4.4.0-140-lowlatency linux-image-extra-4.4.0-140-generic`  
##### c. 编辑grub启动文件：`sudo vim /etc/default/grub`  
注释掉GRUB_HIDDEN_TIMEOUT=0  
GRUB_HIDDEN_TIMEOUT=true改为false  
保存并退出编辑，执行`sudo update-grub`  
##### d. 重启：`sudo reboot`，重新进入系统时选择Advanced一项，而非默认Ubuntu一项，然后选择指定内核一项，启动系统  
##### e. 如果不想每次都选择系统启动，可以通过`sudo apt-get remove linux-image-<version>`来卸载内核，当然最好也卸载掉相应header，使用`sudo update-grub`可以查看当前可供启动的内核列表，或者你可以通过其他方式（例如编辑/etc/default/grub文件指定默认启动的内核）来实现自动启动指定内核。  
如果发现有些内核始终没办法从`sudo update-grub`显示的列表中去掉，则检查一下是否有linux-headers-unsigned-xxx未卸载干净。  
##### f. 卸载完成后编辑/etc/default/grub还原配置：  
取消注释GRUB_HIDDEN_TIMEOUT=0  
GRUB_HIDDEN_TIMEOUT=false改为true  
保存并退出编辑，执行`sudo update-grub`  
##### g. 环境配置完成  

## 2. 执行脚本
##### a. 我使用的网卡是Intel PRO/1000 82571千兆双网口网卡，因此igh_install_e1000e_lowlatency.sh文件里面是按照此硬件来配置的。  
##### b. 编辑igh_install_e1000e_lowlatency.sh文件，将MASTER0_DEVICE修改为你对应网卡网口的MAC地址，将驱动类型修改为你的网卡的类型，不确定就修改为generic  
`cd ~`  
`chmod +x igh_install_e1000e_lowlatency.sh`  
`./igh_install_e1000e_lowlatency.sh`  

## 3. 补充
##### a. 执行过多次脚本之后，建议清理一下/etc/ld.so.conf文件，去掉重复行  
##### b. 如果想要开机ethercat服务自启动，则在/etc/rc.local文件中加入如下行：  
`<your-etherlab-prefix>/etc/init.d/ethercat restart`   
##### c. 如需使用多个网口，则修改/etc/sysconfig/ethercat文件和/opt/etherlab/etc/ethercat.conf文件，例如：  
`MASTER0_DEVICE="12:34:56:78:99:ff"`  
`MASTER1_DEVICE="12:34:56:78:99:00"`  
类型也在这两个文件里修改，例如将e1000e修改为generic  
