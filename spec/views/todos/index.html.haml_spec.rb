require 'rails_helper'

RSpec.describe "todos/index", type: :view do
  before(:each) do
    assign(:todos, [
      Todo.create!(
        :user => nil,
        :title => "Title",
        :description => "MyText",
        :state => 1
      ),
      Todo.create!(
        :user => nil,
        :title => "Title",
        :description => "MyText",
        :state => 1
      )
    ])
  end

  it "renders a list of todos" do
    render
    assert_select "tr>td", :text => nil.to_s, :count => 2
    assert_select "tr>td", :text => "Title".to_s, :count => 2
    assert_select "tr>td", :text => "MyText".to_s, :count => 2
    assert_select "tr>td", :text => 1.to_s, :count => 2
  end
end
