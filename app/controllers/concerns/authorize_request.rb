module AuthorizeRequest extend ActiveSupport::Concern
  included do 
    before_action :authenticate_request 
  end

  private 

  def authenticate_request
    header = request.headers["Authorization"]

    token = header&.split(" ")&.last

    decoded = JsonWebToken.decode(token)

    user_id = decoded.first["user_id"]

    @current_user = User.find(user_id)

  rescue JWT::DecodeError, JWT::ExpiredSignature, ActiveRecord::RecordNotFound
    render json: {
      message: "Unauthorized!!!"
    }, status: :unauthorized
  end
end