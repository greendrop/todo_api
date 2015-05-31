module API
  module V1
    module Defaults
      extend ActiveSupport::Concern
      included do 
        
        before do
          header['Access-Control-Allow-Origin'] = '*'
          header['Access-Control-Request-Method'] = '*'
        end

        helpers do
          def current_token
            doorkeeper_token
          end
          
          def current_user
            User.find(current_token.resource_owner_id)
          end

          def current_scopes
            current_token.scopes
          end
        end
      
      end
    end
  end
end

