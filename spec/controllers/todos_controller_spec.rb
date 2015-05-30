require 'rails_helper'

RSpec.describe TodosController, type: :controller do
  login_user

  describe "GET index" do      
    before { get :index }      

    context "response" do      
      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_with_layout(:application) }
      it { is_expected.to render_template(:index) }
    end                        

    context 'assigns' do       
      context "[:todos]" do     
        subject { assigns[:todos] }      
        it { is_expected.to be_instance_of(Todo::ActiveRecord_Relation) }
      end
    end
  end

  describe "GET new" do
    before { get :new }

    context "response" do
      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_with_layout(:application) }
      it { is_expected.to render_template(:new) }
    end

    context 'assigns' do
      context "[:todo]" do
        subject { assigns[:todo] }
        it { is_expected.to be_instance_of(Todo) }
        its(:new_record?) { should be_truthy }
      end
    end
  end

  describe "POST create" do
    context "strong parameters" do
      it do
        attributes = [:title, :description, :state]
        is_expected.to permit(*attributes).for(:create)
      end
    end

    context "入力エラーなし" do
      let(:todo_params) { attributes_for(:todo, user: nil) }

      before { post :create, todo: todo_params }

      context "response" do
        it { is_expected.to respond_with(:redirect) }
        it { is_expected.to redirect_to(todo_url(assigns[:todo])) }
      end

      context 'assigns' do
        context "[:todo]" do
          subject { assigns[:todo] }
          it { is_expected.to be_instance_of(Todo) }
          its(:persisted?) { is_expected.to be_truthy }
        end
      end

      context "flash" do
        context "[:notice]" do
          it { is_expected.to set_flash[:notice].to I18n.t('label.create_success_message', model: Todo.model_name.human) }
        end
      end
    end

    context "入力エラーあり" do
      let(:todo_params) { attributes_for(:todo, user: nil, title: nil) }

      before { post :create, todo: todo_params }

      context "response" do
        it { is_expected.to respond_with(:success) }
        it { is_expected.to render_with_layout(:application) }
        it { is_expected.to render_template(:new) }
      end

      context 'assigns' do
        context "[:todo]" do
          subject { assigns[:todo] }
          it { is_expected.to be_instance_of(Todo) }
          its(:persisted?) { is_expected.to be_falsy }
        end
      end

      context "flash" do
        context "[:notice]" do
          it { is_expected.to_not set_flash[:notice] }
        end
      end
    end
  end

  describe "GET edit" do
    let(:todo) { create(:todo, user: controller.current_user) }

    before { get :edit, id: todo }

    context "response" do
      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_with_layout(:application) }
      it { is_expected.to render_template(:edit) }
    end

    context "assigns" do
      context "[:todo]" do
        subject { assigns[:todo] }
        it { is_expected.to eq todo }
      end
    end
  end

  describe "PATCH update" do
    let(:todo) { create(:todo, user: controller.current_user) }

    context "strong parameters" do
      it do
        attributes = [:title, :description, :state]
        is_expected.to permit(*attributes).for(:update, params: {id: todo})
      end
    end

    context "入力エラーなし" do
      let(:todo_params) { attributes_for(:todo, user: nil, title: 'test') }

      before { patch :update, id: todo, todo: todo_params }

      context "response" do
        it { is_expected.to respond_with(:redirect) }
        it { is_expected.to redirect_to(todo_url(todo)) }
      end

      context "assigns" do
        context "[:todo]" do
          subject { assigns[:todo] }
          it { is_expected.to be_instance_of(Todo) }
          its(:title) { is_expected.to eq todo_params[:title] }
        end
      end

      context "flash" do
        context "[:notice]" do
          it { should set_flash[:notice].to I18n.t('label.update_success_message', model: Todo.model_name.human) }
        end
      end
    end

    context "入力エラーあり" do
      let(:todo_params) { attributes_for(:todo, user: nil, title: nil) }

      before { patch :update, id: todo, todo: todo_params }

      context "response" do
        it { is_expected.to respond_with(:success) }
        it { is_expected.to render_with_layout(:application) }
        it { is_expected.to render_template(:edit) }
      end

      context 'assigns' do
        context "[:todo]" do
          subject { assigns[:todo] }
          it { is_expected.to be_instance_of(Todo) }
          its(:valid?) { is_expected.to be_falsy }
        end
      end

      context "flash" do
        context "[:notice]" do
          it { is_expected.to_not set_flash[:notice] }
        end
      end
    end
  end

  describe "DELETE destroy" do
    let(:todo) { create(:todo, user: controller.current_user) }

    before { delete :destroy, id: todo }

    context "response" do
      it { is_expected.to respond_with(:redirect) }
      it { is_expected.to redirect_to(todos_url) }
    end

    context 'assigns' do
      context "[:todo]" do
        subject { assigns[:todo] }
        it { is_expected.to be_instance_of(Todo) }
        its(:destroyed?) { is_expected.to be_truthy }
      end
    end

    context "flash" do
      context "[:notice]" do
        it { is_expected.to set_flash[:notice].to I18n.t('label.destroy_success_message', model: Todo.model_name.human) }
      end
    end
  end

  describe "GET show" do
    let(:todo) { create(:todo, user: controller.current_user) }

    before { get :show, id: todo }

    context "response" do
      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_with_layout(:application) }
      it { is_expected.to render_template(:show) }
    end

    context 'assigns' do
      context "[:todo]" do
        subject { assigns[:todo] }
        it { is_expected.to eq todo }
      end
    end
  end
end

