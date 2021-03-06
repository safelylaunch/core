# frozen_string_literal: true

require 'dry/system/container'
require 'dry/system/hanami'
require_relative '../lib/types'
require_relative '../lib/core/libs/operation'
require_relative './core_ext'

# General container class for project dependencies
#
# {http://dry-rb.org/gems/dry-system/ Dry-system documentation}
class Container < Dry::System::Container
  extend Dry::System::Hanami::Resolver

  # use :bootsnap
  use :env

  #  Core
  register_folder! 'core/repositories'

  #  toggles
  register_folder! 'toggles/operations'

  #  environments
  register_folder! 'environments/operations'
  register_folder! 'environments/libs'

  #  projects
  register_folder! 'projects/operations'

  configure do |config|
    config.env = Hanami.env
  end
end
