require 'rails_helper'

describe API::V1::Me do
  let(:user) { create(:user) }
  let(:doorkeeper_application) { create_doorkeeper_application }
  let(:access_token) { create_doorkeeper_access_token(doorkeeper_application, user) }

  describe 'GET /' do
    describe 'アクセストークンあり' do
      before do
        get '/api/v1/me', format: :json, access_token: access_token.token
      end

      context 'response' do
        let(:body) { {id: user.id.to_s, user: {email: user.email}} }

        subject { response }
        its(:response_code) { is_expected.to eq 200 }
        its(:body) { is_expected.to match_json_expression body }
      end
    end

    describe 'アクセストークンなし' do
      before do
        get '/api/v1/me', format: :json
      end

      context 'response' do
        subject { response }
        its(:response_code) { is_expected.to eq 401 }
      end

      context 'response.headers' do
        subject { response.headers }
        its(['Content-Type']) { is_expected.to match(/json/) }
      end
    end

  end
end
