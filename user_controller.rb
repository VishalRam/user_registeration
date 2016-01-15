class UserController < ApplicationController

  skip_before_filter :authorize

  # endpoint to register a User
  def register
    if register_check_params
      begin
        # Register user
        return_msg = User.register(params)
        render json: { message: return_msg }, status: :ok
      rescue Exception => e
        render json: { message: 'User registeration failed, param values incorrect!!' }, status: :false
      end
    else
      render_missing_params
    end
  end

  #endpoint to login a user
  def login
    if login_check_params
      user = User.login(params)
      if user.present?
        render json: { message: "User logged in!!" }, status: :ok
      else
        render json: { message: "Invalid email and/or password" }, status: :false
      end
    else
      render_missing_params
    end
  end

private

    def register_check_params
      ["password", "email", "type"].all? {|s| params.key? s}
    end

    def login_check_params
      ["password", "email"].all? {|s| params.key? s}
    end

    def render_missing_params
      render json: { message: 'Params missings' }, status: :false
    end
end
