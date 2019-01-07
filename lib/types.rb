# frozen_string_literal: true

require 'dry-types'

# Module with all project types
#
# {http://dry-rb.org/gems/dry-types/ Dry-types documentation}
module Core
  module Types
    include Dry::Types.module

    # System types
    LoggerLevel = Symbol.constructor(proc { |value| value.to_s.downcase.to_sym })
      .default(:info)
      .enum(:trace, :unknown, :error, :fatal, :warn, :info, :debug)

    UUID = Strict::String.constrained(
      format: /\A(\h{32}|\h{8}-\h{4}-\h{4}-\h{4}-\h{12})\z/
    )

    # Toggle and envs
    ToggleStatuses = String.constructor(proc { |value| value.to_s.downcase })
      .default('disable')
      .enum('enable', 'disable')

    ToggleTypes = String.constructor(proc { |value| value.to_s.downcase })
      .default('boolean')
      .enum('boolean')

    # accounts
    AccountRoles = String.constructor(proc { |value| value.to_s.downcase })
      .default('user')
      .enum('user')

    AuthIdentityTypes = String.constructor(proc { |value| value.to_s.downcase })
      .default('google')
      .enum('google')

    # projects
    ProjectMemberRoles = String.constructor(proc { |value| value.to_s.downcase })
      .default('member')
      .enum('admin', 'member')
  end
end
