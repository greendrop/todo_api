require 'rails_helper'

RSpec.describe "todos/show", type: :view do
  before(:each) do
    @todo = assign(:todo, Todo.create!(
      :user => nil,
      :title => "Title",
      :description => "MyText",
      :state => 1
    ))
  end

  it "renders attributes in <p>" do
    render
    expect(rendered).to match(//)
    expect(rendered).to match(/Title/)
    expect(rendered).to match(/MyText/)
    expect(rendered).to match(/1/)
  end
end
