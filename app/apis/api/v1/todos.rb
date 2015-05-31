module API
  module V1
    class Todos < API::V1::Root
      include API::V1::Defaults

      helpers do
        def set_todo
          @todo = Todo.find(params[:id])
          raise ActiveRecord::RecordNotFound unless @todo.user_id == current_user.try(:id)
        end

        def create_todo
          @todo = Todo.new(todo_params)
          @todo.user = current_user
          @todo.save
        end

        def update_todo
          @todo.update(todo_params)
        end

        def todo_params
          ActionController::Parameters.new(params[:todo]).
            permit([
              :title,
              :description,
              :state
            ])
        end

        def get_todo_errors
          @todo.errors.keys.each_with_object({}) do |key, errors|
            errors[key] = @todo.errors.full_messages_for(key)
          end
        end
      end

      resource :todos do
        before do
          doorkeeper_authorize!
        end

        desc "Return Todo list"
        params do
          optional Kaminari.config.param_name, type: Integer
        end
        get '/' do
          @todos = Todo.where(user: current_user).order(:created_at).page(params[Kaminari.config.param_name])
          @todos.as_json(except: [:user_id])
        end

        desc "Return a Todo"
        params do
          requires :id, type: Integer
        end
        get ':id' do
          set_todo
          @todo.as_json(except: [:user_id])
        end

        desc "Create a Todo"
        params do
          requires :todo, type: Hash
        end
        post '/' do
          if create_todo
            status 201
            response_data = @todo.as_json(except: [:user_id])
          else
            status 422
            response_data = get_todo_errors
          end
          response_data
        end

        desc "Update a Todo"
        params do
          requires :id, type: Integer
          requires :todo, type: Hash
        end
        put '/:id' do
          set_todo
          if update_todo
            status 200
            response_data = @todo.as_json(except: [:user_id])
          else
            status 422
            response_data = get_todo_errors
          end
          response_data
        end

        desc "Delete a Todo"
        params do
          requires :id, type: Integer
        end
        delete '/:id' do
          set_todo
          @todo.destroy
          status 204
          {}
        end

      end
    end
  end
end
