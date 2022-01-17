class ApplicationController < ActionController::Base
  before_action :authenticate_user!
  before_action :configure_permitted_parameters, if: :devise_controller?

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up, keys: [:username, :name, :avatar])
    devise_parameter_sanitizer.permit(:account_update, keys: [:username, :name, :blood_type, :education, :avatar])
  end

  private

  REQUESTING_FRIENDS_IDS = [2, 8, 9, 10, 11, 12, 13, 14, 15, 16, 17, 18, 19, 20, 21, 22, 23, 24]

  def create_friend_invitations
    REQUESTING_FRIENDS_IDS.each do |requester_id|
      FriendRequest.create(user: User.find(requester_id), friend: @user)
    end
  end

  def send_welcome_email
    UserMailer.with(user: @user).welcome_email.deliver_now
  end
end

def set_avatar
  @user.add_default_avatar unless @user.avatar.attached?
end
