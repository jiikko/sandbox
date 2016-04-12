directory "rails_app"
remote_directory "rails_app" do
  action :create
  source "files/rails_app" # 必須指定。再帰的にコピーされる
  mode "755" # アクセス権の指定
  owner user # 所有者
  owner user # 所有グループ
end

execute "make sunspot config files" do
  run_command <<-EOH
cd rails_app
bundle exec sunspot:start
bundle exec sunspot:stop
  EOH
end

execute "copy sunspot config files" do
  run_command <<-EOH
sed 's/HOME//var/solr/server/solr/' /etc/defaults/solr.sh
sudo rm /var/solr/server/solr
sudo ln -s rails_app/solr /var/solr/server/solr
sudo chown -R solr /var/solr/server/solr
  EOH
end

execute "sudo sevice solr restart"
