include_recipe 'xinetd'

['check-mk-agent', 'check-mk-agent-logwatch'].each do |p|
  package p
end

template '/etc/xinetd.d/check_mk' do 
  notifies :reload, 'service[xinetd]'
end
