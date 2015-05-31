require 'doorkeeper/grape/helpers'

module API
  class Root < Grape::API
    class BadRequest         < StandardError; end
    class Unauthorized       < StandardError; end
    class NotFound           < StandardError; end
    class ServiceUnavailable < StandardError; end

    default_error_formatter :json
    content_type :json, 'application/json'
    helpers Doorkeeper::Grape::Helpers
    helpers do
      def logger
        API.logger
      end
    end
    self.logger Rails.logger

    rescue_from :all do |e|
      API::Root.logger.error("#{e.class} - #{e.message}\n #{e.backtrace.join "\n"}") 

      message = nil
      case e.class
      when BadRequest, Grape::Exceptions::ValidationErrors
        status = 400
      when Unauthorized
        status = 401
      when NotFound, ActiveRecord::RecordNotFound
        status = 404
      when ServiceUnavailable
        status = 503
      else
        status = (e.respond_to? :status) && e.status || 500
      end
      opts = { message: "#{message || e.message}" }
      opts[:trace] = e.backtrace[0,10] unless Rails.env.production?
      Rack::Response.new(opts.to_json, status, {
        'Content-Type' => "application/json",
        'Access-Control-Allow-Origin' => '*',
        'Access-Control-Request-Method' => '*',
      }).finish
    end

    mount API::V1::Root

    format :json

    route :any, '*path' do
      raise NotFound, "Not found"
    end

  end
end

