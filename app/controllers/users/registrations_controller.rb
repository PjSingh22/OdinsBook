class Users::RegistrationsController < Devise::RegistrationsController
  after_action :set_avatar, :send_welcome_email, :create_friend_invitations, only: :create, if: -> { @user.persisted? }
end