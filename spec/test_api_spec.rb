require File.dirname(__FILE__) + '/../config/boot'
require File.dirname(__FILE__) + '/../gui_proto_app'
require 'rspec'
require 'rack/test'

ENV['RACK_ENV'] = 'test'

def app
  @app ||= GuiProtoApp
end

describe "gui proto app test" do
  include Rack::Test::Methods

  describe "POST on /api/login" do
    it "should return token if login == 'admin'" do
      post '/api/login', { login: 'admin', password: 'pwdpwd'}
      last_response.should be_ok
      resp = JSON.parse(last_response.body)
      resp['token'].should_not be_nil
      resp['username'].should == 'admin'  
    end
 
    it "should return error if login different" do
      post '/api/login', { login: 'zzz', password: 'pwdpwd'}
      last_response.status.should == 404
      resp = JSON.parse(last_response.body)
      resp['token'].should be_nil
      resp['error'].should_not be_nil
    end

  end 
 
end
