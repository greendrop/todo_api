module DoorkeeperMacros
  extend ActiveSupport::Concern

  def create_doorkeeper_application
    Doorkeeper::Application.create(name: "MyApp", redirect_uri: "https://app.com")
  end

  def create_doorkeeper_access_token(doorkeeper_application, user, opts={})
    Doorkeeper::AccessToken.create!(application_id: doorkeeper_application.id, resource_owner_id: user.id, scopes: opts && opts[:scopes])
  end
end

