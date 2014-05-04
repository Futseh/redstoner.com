class SessionsController < ApplicationController

  def new
    if current_user
      flash[:alert] = "You are already logged in!"
      redirect_to current_user
    else
      cookies[:return_path] = params[:return_path] if params[:return_path]
    end
  end

  def create
    unless current_user
      user = User.find_by_email(params[:email])
      if user && user.authenticate(params[:password])
        if user.disabled?
          flash[:alert] = "Your account has been disabled!"
        elsif user.banned?
          flash[:alert] = "You are banned!"
        else
          session[:user_id] = user.id
          flash[:alert] = "Remember to validate your email! Your account may be deleted soon!" if !user.confirmed?
          flash[:notice] = "Logged in!"
        end
      else
        flash[:alert] = "You're doing it wrong!"
        render action: 'new'
        return
      end
    else
      flash[:alert] = "You are already logged in!"
    end
    if cookies[:return_path]
      redirect_to cookies[:return_path]
      cookies.delete(:return_path)
    else
      redirect_to blogposts_path
    end
  end

  def destroy
    if original_user = User.find_by_id(session[:original_user_id])
      logout_user = current_user
      session[:user_id] = original_user.try(:id)
      session.delete(:original_user_id)
      flash[:notice] = "You are no longer '#{logout_user.name}'!"
      redirect_to original_user
    else
      session.delete(:user_id)
      redirect_to login_path, :notice => "Logged out!"
    end
  end

  def become
    original_user = current_user
    new_user = User.find_by_id(params[:user])
    if original_user && new_user && admin? && current_user.role >= new_user.role
      if original_user == new_user
        flash[:alert] = "You are already '#{new_user.name}'!"
      else
        if session[:original_user_id]
          flash[:alert] = "Please revert to your account first"
        else
          session[:original_user_id] = original_user.id
          session[:user_id] = new_user.id
          flash[:notice] = "You are now '#{new_user.name}'!"
        end
      end
    else
      flash[:alert] = "You are not allowed to become this user"
    end
    redirect_to new_user
  end

  def revert
    if old_user = current_user
      original_user = User.find_by_id(session[:original_user_id])
      if original_user && original_user.try(:admin?)
        session.delete(:original_user_id)
        session[:user_id] = original_user.try(:id)
        flash[:notice] = "You are no longer '#{old_user.name}'!"
      end
      redirect_to old_user
    else
      redirect_to login_path
    end
  end
end