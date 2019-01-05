# frozen_string_literal: true

RSpec.describe Projects::Operations::List, type: :operation do
  let(:operation) { described_class.new(project_repo: project_repo) }
  let(:env_repo) { instance_double('ProjectRepository') }
end
