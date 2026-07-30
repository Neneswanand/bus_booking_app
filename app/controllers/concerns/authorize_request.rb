module AuthorizeRequest extend ActiveSupport::Concern  
  included do 
    before_action :authenticate_request 
  end

  private  #Methods below this can not be called outside

  def authenticate_request
    header = request.headers["Authorization"] 
    #request-representing incoming HTTP requests, headers-Collection of HTTP headers
    token = header&.split(" ")&.last # Safe navigator operator (no NoMethodError)   
    # Bearer asdasd = ["Bearer", "asdasd"] = "asdasd"
    decoded = JsonWebToken.decode(token)
    # decoded = JsonWebToken.decode(asdasd) = decoded = [{"user_id"=> 15, "exp"=> 1784321},{"alg"=> "HS256"}]
    user_id = decoded.first["user_id"]
    # user_id = [{"user_id"=> 15, "exp"=> 1784321},{"alg"=> "HS256"}].first["user_id"] = 15
    @current_user = User.find(user_id) 
    # @current_user = User.find(15) 
  end
end