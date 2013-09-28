# -*- coding: utf-8 -*-

config_file = File.join(Rails.root, 'config', 'config.yml')
config = YAML.load_file(config_file)

# mail config
case Rails.env
when 'development'
  mail_config = config['mail']['development']
when 'test'
  mail_config = config['mail']['test']
else
  mail_config = config['mail']['production']
end
%w(smtp_settings sendmail_settings delivery_method).each do |config_name|
  ActionMailer::Base.send(config_name + '=', mail_config[config_name])
end

Voteapi::VOTE_SPAN = config['api']['vote_span']
