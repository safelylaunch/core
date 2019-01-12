module Web
  module Controllers
    module Toggles
      class Create
        include Web::Action

        def call(params)
          self.body = 'OK'
        end
      end
    end
  end
end
