execute "sudo apt-get update"

package 'openjdk-8-jre' do
  action :install
end

execute "download solr binary" do
  run_command <<-EOH
wget http://ftp.jaist.ac.jp/pub/apache/lucene/solr/6.0.0/solr-6.0.0.tg
tar xzf solr-6.0.0.tgz solr-6.0.0/bin/install_solr_service.sh --strip-components=2
  EOH
end

execute "install" do
  not_if 'ls /etc/init.d/solr'
  run_command <<-EOH
sudo bash ./install_solr_service.sh solr-6.0.0.tgz
  EOH
end
