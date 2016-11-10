require 'sinatra/base'
require 'sinatra/cross_origin'
require_relative 'shows_summary_service'

class Server < Sinatra::Base
	register Sinatra::CrossOrigin
	set :allow_origin, :any
  set :allow_methods, [:post, :options]
	enable :cross_origin

  get '/' do
    'This app only accepts POST requests.'
  end

  post '/' do
    shows_summary_service = ShowsSummaryService.call(request)
    if shows_summary_service.success?
      playlist = { response: shows_summary_service.result }
    else
      playlist = { error: shows_summary_service.errors[:parse].first }
    end
    content_type :json
    status shows_summary_service.success? ? 200 : 400
    playlist.to_json
  end

  options '*' do
    response.headers['Allow'] = 'POST,OPTIONS'
    response.headers['Access-Control-Allow-Headers'] = 'X-Requested-With, X-HTTP-Method-Override, Content-Type, Cache-Control, Accept'
    200
  end
end
