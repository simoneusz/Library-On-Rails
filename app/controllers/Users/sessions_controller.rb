# frozen_string_literal: true

module Users
  class SessionsController < Devise::SessionsController
    add_breadcrumb '<i class="bi bi-house"></i>'.html_safe, :root_path
  end
end
