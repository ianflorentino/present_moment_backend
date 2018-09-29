module Api
  module V1
    class UsersController < ApplicationController
      def index
        @users = User.all
        render json: @users
      end

      def show
        render json: current_user
      end

      def create
        op = SignupOp.new(nil, user_params)
        op.submit

        return render json: return_error(op), status: 400 unless op.errors.blank?
        render json: op.user
      end

      def update
        op = UpdateUserOp.new(current_user, user_params)
        op.submit

        return render json: return_error(op), status: 400 unless op.errors.blank?
        render json: op.updated_user
      end

      private
        def user_params
          _params = params.permit(:first_name, :last_name, :email, :password, :password_confirmation, :username)
          params_hash(_params)
        end
    end
  end
end
