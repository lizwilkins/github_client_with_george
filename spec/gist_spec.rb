require 'spec_helper'

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
      Gist.create(gist)

      stub.should have_been_requested
    end

    it 'GETs a Gist in the user\'s account' #Read
    it 'PATCHes a Gist in the user\'s account' #Update
    it 'DELETEs a Gist in the user\'s account' #Destroy
    
  end
end

