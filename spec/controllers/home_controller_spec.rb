require 'rails_helper'

RSpec.describe HomeController, type: :controller do

  describe "GET #index" do
    before do
      get :index
    end

    context 'response' do
      it { is_expected.to respond_with(:success) }
      it { is_expected.to render_with_layout(:application) }
      it { is_expected.to render_template(:index) }
    end
  end

end
