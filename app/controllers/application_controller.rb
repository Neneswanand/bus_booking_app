class ApplicationController < ActionController::API
  rescue_from ActiveRecord::RecordNotFound, with: :record_not_found
  
  rescue_from ActiveRecord::RecordInvalid, with: :record_invalid

  private

  def record_not_found(exception)
    render json: { 
      # errors: exception.message
    }, status: :not_found
  end

  def record_invalid(exception)
    render json: {
      # errors: exception.message
      errors: exception.record.errors.messages       # Returns structured errors: { "errors": { "name": ["can't be blank"], "email": ["is invalid"] } } 
    }, status: :unprocessable_entity
  end
end
