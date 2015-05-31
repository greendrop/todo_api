module API
  module V1
    class Root < Grape::API
      format :json
      version 'v1'

      mount API::V1::Me

    end
  end
end

