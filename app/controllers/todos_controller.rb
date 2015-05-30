class TodosController < UserBaseController
  before_action :set_todo, only: [:show, :edit, :update, :destroy]

  def index
    @todos = Todo.where(user: current_user).order(:created_at).page(params[Kaminari.config.param_name])
  end

  def show
  end

  def new
    @todo = Todo.new
  end

  def edit
  end

  def create
    @todo = Todo.new(todo_params)
    @todo.user = current_user

    if @todo.save
      redirect_to @todo, notice: I18n.t('label.create_success_message', model: Todo.model_name.human)
    else
      render :new
    end
  end

  def update
    if @todo.update(todo_params)
      redirect_to (params[:return_url].presence || @todo), notice: I18n.t('label.update_success_message', model: Todo.model_name.human) 
    else
      render :edit
    end
  end

  def destroy
    @todo.destroy
    redirect_to todos_url, notice: I18n.t('label.destroy_success_message', model: Todo.model_name.human)
  end

  private
    def set_todo
      @todo = Todo.find(params[:id])
      raise ActiveRecord::RecordNotFound unless @todo.user_id == current_user.try(:id)
    end

    def todo_params
      params.require(:todo).permit(:title, :description, :state)
    end
end
