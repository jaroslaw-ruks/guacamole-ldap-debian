execute 'modprobe' do
  command '/sbin/modprobe usbip-core; /sbin/modprobe vhci-hcd;'
  creates '/tmp/.modprobe'
  action :run
end

%w(usbip-core , vhci-hcd).each do |k_module|
	ruby_block 'insert_line' do
		block do
	    	file = Chef::Util::FileEdit.new('/etc/modules')
	    	file.insert_line_if_no_match(k_module,k_module)
		    file.write_file
		end
	end
end

package ['pcscd','pcsc-tools', 'rdesktop','vnc4server', 'x11vnc','x11vnc-data','usbip','guacamole','supervisor'] do
  action :install
end