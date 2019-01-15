module Web
  module Controllers
    module Projects
      class New
        include Web::Action
        include Import[projects_operation: 'projects.operations.list']

        expose :projects

        def call(params)
          @projects = projects_operation.call(account_id: current_account.id).value!
        end
      end
    end
  end
end
