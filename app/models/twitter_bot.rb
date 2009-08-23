class TwitterBot < ActiveRecord::Base
  include TwitterAuth::BasicUser
 
  def twitter
    TwitterAuth::Dispatcher::Basic.new(self)
  end

  def password
    read_attribute(:password)
  end
end