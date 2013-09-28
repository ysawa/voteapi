module DeviseAuthenticationHelper
  def user_sign_in(user = nil)
    @request.env["devise.mapping"] = Devise.mappings[:user]
    unless user
      @user ||= Fabricate(:user)
      user = @user
    end
    sign_in user
  end
end
