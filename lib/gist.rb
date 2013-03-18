class Gist
  def self.create(gist, login)
    post_response = Faraday.post do |request|
      request.url 'https://api.github.com/gists'
      request.headers['Authorization'] = "Basic " + Base64.encode64("#{login[:username]}:#{login[:password]}")
      request.body = gist.to_json
    end
  end

  def self.list(login)
    post_response = Faraday.get do |request|
      request.url "https://api.github.com/users/#{login[:username]}/gists"
      request.headers['Authorization'] = "Basic " + Base64.encode64("#{login[:username]}:#{login[:password]}")
      #don't forget to convert this to has via JSON.parse
    end
    if post_response.body.class == String
      JSON.parse(post_response.body)
    else
      false
    end
  end

  def self.delete(login, id)
    post_response = Faraday.delete do |request|
      request.url "https://api.github.com/gists/#{id}"
      request.headers['Authorization'] = "Basic " + Base64.encode64("#{login[:username]}:#{login[:password]}")
    end
  end
end