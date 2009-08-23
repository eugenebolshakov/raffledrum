Factory.define :user do |u|
  u.sequence(:twitter_id) { |i| i.to_s }
  u.sequence(:login) { |i| "login#{i}" }
end
