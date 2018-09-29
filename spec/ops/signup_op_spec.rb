require 'rails_helper' 

describe SignupOp do
  context "with valid parameters" do
    let!(:user_params) {
      {
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: "password1"
      }
    }
    before do
      @op = SignupOp.new(user_params)
      @op.submit
    end
    it "is valid" do
      expect(@op.valid?).to eq true
    end
    it "creates a new user" do
      expect(User.count).to eq 1
    end
  end
  context "with invalid parameters" do
    let!(:params) {
      {
        first_name: Faker::Name.first_name,
        last_name: Faker::Name.last_name,
        email: Faker::Internet.email,
        password: "password1"
      }
    }
    ["first_name", "last_name", "password", "email"].each do |param|
      it "is not valid" do
        expect(op.valid?).to eq false
      end
      it "returns blank if #{param} is missing" do
        user_params = params.except(param.to_sym)
        op = SignupOp.new(user_params)
        op.submit
        expect(op.errors.full_messages).to include "#{param.humanize} can't be blank"
      end
      it "does not create a new user" do
        expect(User.count).to eq 0
      end
    end
  end
end
