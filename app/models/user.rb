class User < TwitterAuth::GenericUser
  # Associations
  has_many :raffles

  # Instance Methods

  def followers
    @followers ||= twitter.get('/followers/ids').map(&:to_s)
  end
end
