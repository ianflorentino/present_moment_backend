require 'rails_helper' 

describe UpdateUserOp do
  include RequestSpecHelper
  context "with valid parameters" do

    let!(:user) { FactoryBot.create(:user) }
    let!(:user_params) {
      {
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
      }
    }
    before do
      sign_in user
      @op = UpdateUserOp.new(user, user_params)
      @op.submit
    end
    it "is valid" do
      expect(@op.valid?).to eq true
    end
    it "updates the user" do
      updated_user = @op.updated_user
      expect(updated_user.first_name).to eq user_params[:first_name]
      expect(updated_user.last_name).to eq user_params[:last_name]
      expect(user.email).to eq user_params[:email]
    end
  end
  context "with invalid parameters" do
    let!(:user) { FactoryBot.create(:user) }
    let!(:user_params) {
      {
        email: "fakeemail"
      }
    }
    before do
      sign_in user
      @op = UpdateUserOp.new(user, user_params)
      @op.submit
    end
    it "returns an error" do
      expect(@op.errors.blank?).to be false
    end
    it "does not update the user" do
      expect(user.reload.attributes).to eq (User.first.attributes)
    end
  end
end
