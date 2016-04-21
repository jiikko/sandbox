execute "copy sunspot config files" do
  run_command <<-EOH
sed 's/HOME//var/solr/server/solr/' /etc/defaults/solr.sh
sudo rm /var/solr/server/solr
sudo ln -s rails_app/solr /var/solr/server/solr
sudo chown -R solr /var/solr/server/solr
  EOH
end

execute "sudo sevice solr restart"
