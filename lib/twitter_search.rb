class TwitterSearch
  include HTTParty

  base_uri 'search.twitter.com'
  headers 'User-Agent' => 'Raffle Drum App'

  def initialize(keyword)
    @keyword = keyword
  end

  def results(options = {})
    self.class.get('/search.json', party_options(options))
  end

  private

    def default_query
      {
        :q   => @keyword,
        :rpp => 100
      }
    end

    def party_options(options)
      {:query => options.merge(default_query)}
    end
end
