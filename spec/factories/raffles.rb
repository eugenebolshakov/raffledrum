Factory.define :raffle do |r|
  r.user       nil
  r.prize      'iPhone'
  r.start_time { Time.now }
  r.end_time   { Time.now + 1.day }
  r.hashtag    'iwannaiphone'
end
