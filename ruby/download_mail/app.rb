require 'yaml'
require 'gmail'
require 'pry'
require 'kconv'

config = YAML.load_file('./config.yml')
binding.pry
mails = []
Gmail.new(config["gmail"]["name"], config["gmail"]["password"]) do |gmail|
  gmail.mailbox('rails-error').emails.each do |mail|
    mail.subject
    mail.message_id
    maill.body.raw_source
    maill.body.decoded.toutf8
  end
end
