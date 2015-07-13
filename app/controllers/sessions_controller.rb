class SessionsController < ApplicationController
  def new
  end
  
  # def create
  #   user = User.find_by(email:params[:session][:email].downcase)
  #   if user && user.authenticate(params[:session][:password])
  #     #登陆用户
  #     log_in user
  #     #remember user
  #     params[:session][:remember_me] == '1' ? remember(user) : forget(user)
  #     redirect_to user
  #   else
  #     flash.now[:danger] = "Invalid email/password combination!"
  #     render 'new'
  #   end
  # end
  def create
    @user = User.find_by(email:params[:session][:email].downcase)
    if @user && @user.authenticate(params[:session][:password])
      #登陆用户
      log_in @user
      #remember user
      params[:session][:remember_me] == '1' ? remember(@user) : forget(@user)
      #redirect_to @user
      #如果用户登录前访问过未授权的页面，此时跳转到该页面中，否则跳到用户资料页
      redirect_back_or @user
    else
      flash.now[:danger] = "Invalid email/password combination!"
      render 'new'
    end
  end
  
  def destroy
    log_out if logged_in?
    redirect_to root_url
  end
end
