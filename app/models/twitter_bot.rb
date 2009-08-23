class TwitterBot < ActiveRecord::Base
  include TwitterAuth::BasicUser
 
  def twitter
    TwitterAuth::Dispatcher::Basic.new(self)
  end
end
