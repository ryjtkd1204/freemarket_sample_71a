# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController

  # before_action :configure_sign_up_params, only: [:create]
  # before_action :configure_account_update_params, only: [:update]

  # GET /resource/sign_up
  def new
    @user = User.new
    @user.build_profile
    @user.build_deliver_adress
  end

  # POST /resource
  def create
    @user = User.new(user_params)
  if @user.save
      sign_in(@user)
      flash[:alert] = 'ようこそ！ アカウントが登録されました'
      redirect_to root_path
  else
    flash[:alert] = '必須事項を入力してください。'
    redirect_to controller: :registrations, action: :new
  end
  end

  # GET /resource/edit
  # def edit
  #   super
  # end

  # PUT /resource
  # def update
  #   super
  # end

  # DELETE /resource
  # def destroy
  #   super
  # end

  # GET /resource/cancel
  # Forces the session data which is usually expired after sign
  # in to be expired now. This is useful if the user wants to
  # cancel oauth signing in/up in the middle of the process,
  # removing all OAuth session data.
  # def cancel
  #   super
  # end

  # protected

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_sign_up_params
  #   devise_parameter_sanitizer.permit(:sign_up, keys: [:attribute])
  # end

  # If you have extra params to permit, append them to the sanitizer.
  # def configure_account_update_params
  #   devise_parameter_sanitizer.permit(:account_update, keys: [:attribute])
  # end

  # The path used after sign up.
  # def after_sign_up_path_for(resource)
  #   super(resource)
  # end

  # The path used after sign up for inactive accounts.
  # def after_inactive_sign_up_path_for(resource)
  #   super(resource)
  # end

  private

  def user_params
    params[:user][:profile_attributes][:birthday] = params[:birthday]["birthday(1i)"] + "-" + params[:birthday]["birthday(2i)"] + "-" + params[:birthday]["birthday(3i)"]
    params.require(:user).permit(:name, :email, :password,profile_attributes: [:first_name, :family_name, :first_name_kana, :family_name_kana, :birthday],deliver_adress_attributes: [:postcode, :prefecture, :city, :adress1, :adress2,])
  end
  
  # def profile_params
  #   params.require(:user).require(:profile).permit(:first_name, :family_name, :first_name_kana, :family_name_kana, :birth_year, :birth_month, :birth_day)
  #   binding.pry
  # end

  # def deliver_adress_params
  #   params.require(:deliver_adress).permit(:postcord, :prefecture, :city, :adress1, :adress2, :telephone)
  # end
end
