module Web
  module Controllers
    module Projects
      class Create
        include Web::Action

        def call(params)
          redirect_to routes.root_path
        end
      end
    end
  end
end
