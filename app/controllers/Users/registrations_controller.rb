# frozen_string_literal: true

class Users::RegistrationsController < Devise::RegistrationsController
  add_breadcrumb '<i class="bi bi-house"></i>'.html_safe, :root_path
end
