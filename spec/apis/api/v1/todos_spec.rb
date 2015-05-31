require 'rails_helper'

describe API::V1::Me do
  let(:user) { create(:user) }
  let(:doorkeeper_application) { create_doorkeeper_application }
  let(:access_token) { create_doorkeeper_access_token(doorkeeper_application, user) }

  shared_examples_for "response_401" do
    context 'response' do
      subject { response }
      its(:response_code) { is_expected.to eq 401 }
    end

    context 'response.headers' do
      subject { response.headers }
      its(['Content-Type']) { is_expected.to match(/json/) }
    end
  end

  describe 'GET /' do
    let(:url) { '/api/v1/todos' }
    let!(:todos) { [create(:todo, user: user), create(:todo, user: user)] }

    describe 'アクセストークンあり' do
      before do
        get url, format: :json, access_token: access_token.token
      end

      context 'response' do
        let(:result) do
          todos.each_with_object([]) do |todo, json_data|
            data = todo.as_json(except: [:user_id, :created_at, :updated_at])
            [:created_at, :updated_at].each do |attribute|
              data[attribute] = todo.send(attribute).as_json
            end
            json_data << data
          end
        end

        subject { response }
        its(:response_code) { is_expected.to eq 200 }
        its(:body) { is_expected.to match_json_expression result }
      end
    end

    describe 'アクセストークンなし' do
      before do
        get url, format: :json
      end

      it_behaves_like "response_401"
    end
  end

  describe 'GET /:id' do
    let!(:todo) { create(:todo, user: user) }
    let(:url) { "/api/v1/todos/#{user.id}" }

    describe 'アクセストークンあり' do
      before do
        get url, format: :json, access_token: access_token.token
      end

      context 'response' do
        let(:result) do
          data = todo.as_json(except: [:user_id, :created_at, :updated_at])
          [:created_at, :updated_at].each do |attribute|
            data[attribute] = todo.send(attribute).as_json
          end
          data
        end

        subject { response }
        its(:response_code) { is_expected.to eq 200 }
        its(:body) { is_expected.to match_json_expression result }
      end
    end

    describe 'アクセストークンなし' do
      before do
        get url, format: :json
      end

      it_behaves_like "response_401"
    end
  end

  describe 'POST /' do
    let(:url) { "/api/v1/todos" }

    describe 'アクセストークンあり' do
      describe '入力エラーなし' do
        let(:todo_params) { attributes_for(:todo, user: nil) }

        before do
          post url, todo: todo_params, format: :json, access_token: access_token.token
        end

        context 'response' do
          let(:result) do
            todo = Todo.last
            data = todo.as_json(except: [:user_id, :created_at, :updated_at])
            [:created_at, :updated_at].each do |attribute|
              data[attribute] = todo.send(attribute).as_json
            end
            data
          end

          subject { response }
          its(:response_code) { is_expected.to eq 201 }
          its(:body) { is_expected.to match_json_expression result }
        end
      end

      describe '入力エラーあり' do
        let(:todo_params) { attributes_for(:todo, user: nil, title: nil) }

        before do
          post url, todo: todo_params, format: :json, access_token: access_token.token
        end

        context 'response' do
          let(:result) do
            invalid_todo = Todo.new(todo_params)
            invalid_todo.user = user
            invalid_todo.valid?
            invalid_todo.errors.keys.each_with_object({}) do |key, errors|
              errors[key] = invalid_todo.errors.full_messages_for(key)
            end
          end

          subject { response }
          its(:response_code) { is_expected.to eq 422 }
          its(:body) { is_expected.to match_json_expression result }
        end
      end
    end

    describe 'アクセストークンなし' do
      before do
        post url, format: :json
      end

      it_behaves_like "response_401"
    end
  end

  describe 'POST /' do
    let!(:todo) { create(:todo, user: user) }
    let(:url) { "/api/v1/todos/#{todo.id}" }

    describe 'アクセストークンあり' do
      describe '入力エラーなし' do
        let(:todo_params) { attributes_for(:todo, user: nil) }

        before do
          put url, todo: todo_params, format: :json, access_token: access_token.token
        end

        context 'response' do
          let(:result) do
            data = todo.as_json(except: [:user_id, :created_at, :updated_at])
            [:created_at, :updated_at].each do |attribute|
              data[attribute] = todo.send(attribute).as_json
            end
            data
          end

          subject { response }
          its(:response_code) { is_expected.to eq 200 }
          its(:body) { is_expected.to match_json_expression result }
        end
      end

      describe '入力エラーあり' do
        let(:todo_params) { attributes_for(:todo, user: nil, title: nil) }

        before do
          put url, todo: todo_params, format: :json, access_token: access_token.token
        end

        context 'response' do
          let(:result) do
            invalid_todo = Todo.new(todo_params)
            invalid_todo.user = user
            invalid_todo.valid?
            invalid_todo.errors.keys.each_with_object({}) do |key, errors|
              errors[key] = invalid_todo.errors.full_messages_for(key)
            end
          end

          subject { response }
          its(:response_code) { is_expected.to eq 422 }
          its(:body) { is_expected.to match_json_expression result }
        end
      end
    end

    describe 'アクセストークンなし' do
      before do
        put url, format: :json
      end

      it_behaves_like "response_401"
    end
  end

  describe 'DELETE /:id' do
    let!(:todo) { create(:todo, user: user) }
    let(:url) { "/api/v1/todos/#{user.id}" }

    describe 'アクセストークンあり' do
      before do
        delete url, format: :json, access_token: access_token.token
      end

      context 'response' do
        let(:result) { '' }

        subject { response }
        its(:response_code) { is_expected.to eq 204 }
        its(:body) { response.body; is_expected.to eq result }
      end
    end

    describe 'アクセストークンなし' do
      before do
        delete url, format: :json
      end

      it_behaves_like "response_401"
    end
  end

end

