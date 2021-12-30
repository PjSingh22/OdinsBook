class Users::RegistrationsController < Devise::RegistrationsController
  after_action :send_welcome_email, only: :create, if: -> { @user.persisted? }
end