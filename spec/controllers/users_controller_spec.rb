require 'rails_helper'
# still in RSpec land

RSpec.describe UsersController, type: :controller do
  # simulate request and test for responses

  describe "GET #new" do
    it "renders the new users template" do
      get :new
      expect(response).to render_template(:new)
    end
  end

  describe "POST #create" do
    let(:user_params) do
      { 
        user: { 
          username: "cappy",
          email: "cappy@cappy.com",
          age: 45, 
          password: "password",
          political_affiliation: "fish"
        }
      }
    end
  
    context "with valid params" do
      it "should log in the user" do
        post :create, params: user_params
        user = User.find_by(username: "cappy")
        expect(session[:session_token]).to eq(user.session_token)
      end
      
      it "redirects to the users show page" do
        post :create, params: user_params
        user = User.find_by(username: "cappy")
        expect(response).to redirect_to(user_url(user))  
      end
    end

    context "with invalid params" do
      it "validates the presence of password and renders the new template with errors" do
        post :create, params: { 
            user: { 
              username: "lazy_cappy",
              email: "cappy@cappy.com",
              age: 45, 
              password: "",
              political_affiliation: "fish"
            }
          }
        # params structure needs to be set up in the way your controller is expecting
        
        expect(response).to render_template(:new)
        expect(flash[:errors]).to be_present
        # error message needs to match exactly (caps, etc) from the specs
        # we are just checking for presence but specs can check for exact error messages
      end
    end
  end
end