class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception #CSRF対策
  before_action :configure_permitted_parameters, if: :devise_controller?
  helper_method :current_cart

    def after_sign_in_path_for(resource)
      case resource
      when Admin
        admin_orders_path
      when Customer
        root_path
      end
    end

    def after_sign_out_path_for(resource)
      root_path
    end

    def current_cart
      if session[:customer_id]
        @cart = CartProduct.find(session[:customer_id])
      else
        @cart = CartProduct.create
        session[:customer_id] = @cart.id
      end
    end

  protected

  def configure_permitted_parameters
    devise_parameter_sanitizer.permit(:sign_up,
                                      keys: [:last_name, :first_name, :last_name_kana, :first_name_kana,
                                            :postal_code, :address, :telephone_number])
  end
end
