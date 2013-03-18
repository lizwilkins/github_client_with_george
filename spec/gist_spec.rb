require 'spec_helper'

LOGIN = {:username => 'username', :password => 'password'}

describe Gist do
  context '.create' do
    it 'POSTs a new Gist to the user\'s account' do #Create
      stub = stub_request(:post, "https://username:password@api.github.com/gists").
         with(:body => {"{\"public\":\"true\",\"description\":\"a test gist\",\"files\":{\"test_file.rb\":{\"content\":\"puts \\\"hello world!\\\"\"}}}"=>true},
              :headers => {'Accept'=>'*/*', 'Content-Type'=>'application/x-www-form-urlencoded', 'User-Agent'=>'Faraday v0.8.6'}).
         to_return(:status => 200, :body => "", :headers => {})

      gist = {:public => 'true',
              :description => 'a test gist',
              :files => {'test_file.rb' => {:content => 'puts "hello world!"'}}}
      Gist.create(gist, LOGIN)

      stub.should have_been_requested
    end
  end

  context '.list' do
    it 'GETs a Gist in the user\'s account' do #Read
      stub = stub_request(:get, "https://username:password@api.github.com/users/username/gists").
         with(:headers => {'Accept'=>'*/*', 'Accept-Encoding'=>'gzip;q=1.0,deflate;q=0.6,identity;q=0.3', 'User-Agent'=>'Faraday v0.8.6'}).
         to_return(:status => 200, :body => "", :headers => {})
      Gist.list(LOGIN)
      stub.should have_been_requested
    end

    it 'returns a hash of valid Gist contents'

  end

  context '.delete' do #Destroy
    it 'DELETEs a Gist in the user\'s account' do
      stub = stub_request(:delete, "https://username:password@api.github.com/gists/282322").
         with(:headers => {'Accept'=>'*/*', 'User-Agent'=>'Faraday v0.8.6'}).
         to_return(:status => 200, :body => "", :headers => {})
      Gist.delete(LOGIN,'282322')
      stub.should have_been_requested      
    end 
  end



  it 'PATCHes a Gist in the user\'s account' #Update

end


