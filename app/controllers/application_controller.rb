class ApplicationController < ActionController::API
  include AuthorizeRequest
  
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  rescue_from JWT::DecodeError, with: :decode_error

  rescue_from JWT::ExpiredSignature, with: :expired_Signature

  private

  def record_not_found(exception)
    render json: { 
      errors: exception.message
    }, status: :not_found
  end

  def record_invalid(exception)
    render json: {
      errors: exception.message
    }, status: :unprocessable_entity
  end

  def authorize_admin
    unless @current_user.admin? || @current_user.super_admin?
      render json: {
        message: "Only Admin or Super Admin Allowed To Do..."
      }, status: :forbidden
    end
  end

  def authorize_super_admin
    unless @current_user.super_admin?
      render json: {
        message: "Only Super Admin Allowed To Do..."
      }, status: :forbidden
    end
  end

  def decode_error
    render json: { 
      message: "Unauthorized..."
    }, status: :unauthorized
  end

  def expired_Signature
    render json: { 
      message: "Token Expired..."
    }, status: :unauthorized
  end
end


#Expired token - eyJhbGciOiJIUzI1NiJ9.eyJ1c2VyX2lkIjoxNSwiZXhwIjoxNzg0OTU0MzIwfQ.hK5RR65lB01js5jVYJBNF4WthfaztHq-fUnmkhKGP8Q