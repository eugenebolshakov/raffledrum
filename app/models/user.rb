class User < TwitterAuth::GenericUser
  # Associations
  has_many :raffles
end
