require 'rails_helper'

RSpec.describe "todos/new", type: :view do
  before(:each) do
    assign(:todo, Todo.new(
      :user => nil,
      :title => "MyString",
      :description => "MyText",
      :state => 1
    ))
  end

  it "renders new todo form" do
    render

    assert_select "form[action=?][method=?]", todos_path, "post" do

      assert_select "input#todo_user_id[name=?]", "todo[user_id]"

      assert_select "input#todo_title[name=?]", "todo[title]"

      assert_select "textarea#todo_description[name=?]", "todo[description]"

      assert_select "input#todo_state[name=?]", "todo[state]"
    end
  end
end
