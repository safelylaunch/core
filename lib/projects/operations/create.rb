# frozen_string_literal: true

module Projects
  module Operations
    class Create < Libs::Operation
      include Import[
        project_repo: 'repositories.project',
        env_repo: 'repositories.environment'
      ]

      DEFAULT_ENV_NAME = 'production'
      DEFAULT_ENV_COLOR = 'ff0000'

      def call(name:, owner_id:)
        project = yield create_project(name, owner_id)
        yield create_default_environment(project.id)

        Success(project)
      end

      def create_project(name, owner_id)
        Try(Hanami::Model::UniqueConstraintViolationError) do
          project_repo.create_for_member(owner_id, name)
        end.to_result
      end

      def create_default_environment(project_id)
        Success(env_repo.create(project_id: project_id, color: DEFAULT_ENV_COLOR, name: DEFAULT_ENV_NAME))
      end
    end
  end
end
