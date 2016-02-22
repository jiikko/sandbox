class CommandTemplate < ActiveRecord::Base
  serialize :dependency_cmds, Array
end
