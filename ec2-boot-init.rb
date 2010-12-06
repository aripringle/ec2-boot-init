#!/usr/bin/ruby

require 'ec2boot'

config = EC2Boot::Config.new
ud = EC2Boot::UserData.new(config)
md = EC2Boot::MetaData.new(config)

EC2Boot::Util.write_facts(ud, md, config)

config.actions.run_actions(ud, md, config)

if ud.fetched? && md.fetched?
  EC2Boot::Util.update_hostname(ud, md, config)
  EC2Boot::Util.update_motd(ud, md, config) 
end