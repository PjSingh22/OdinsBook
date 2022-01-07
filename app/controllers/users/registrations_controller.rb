class Users::RegistrationsController < Devise::RegistrationsController
  after_action :create_friend_invitations, only: :create, if: -> { @user.persisted? }
end