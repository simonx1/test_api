require 'digest/md5'

class GuiProtoApp < Sinatra::Base

post '/api/login' do
  lgn = params[:login]
  if lgn == 'admin' ||  lgn == 'bob'
    { token: Digest::MD5.hexdigest(lgn), username: lgn }.to_json
  else
    error 404,  {error: "user not found"}.to_json
  end
end 

get '/api/apps' do
  if params['token']
    apps = []
    100.times do |i|
      apps << { name: "Application_#{i}", author: "Skype", category: ["Communication", "Marketing"], 
                rate: 4.5, platform: ["ios", "android"], installed: false, 
                logo: "http://media.idownloadblog.com/wp-content/uploads/2011/06/skype-icon.jpeg" }
    end
    if params[:page]
      offset = params[:offset] || 10
      page = params[:page].to_i
      s = (page-1) * offset
      e = s + offset
      resp = apps[s...e] 
    else
      resp = apps
    end
    { apps: resp, count: apps.count, page: params[:page] }.to_json
  else
    error 401, "unauthorized"
  end
end 

end
