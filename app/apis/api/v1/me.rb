module API
  module V1
    class Me < API::V1::Root
      include API::V1::Defaults

      resource :me do
        
        before do
          doorkeeper_authorize!
        end

        get '/' do
          result = {
            id: current_user.id.to_s,
            user: {
              email: current_user.email
            }
          }
        end
      end

    end
  end
end

