require 'spec_helper'

RSpec.describe Server do

  def app
    Server
  end

  def response
    last_response.as_json.fetch('response').first
  end

  def playlist(show)
    { payload: [show] }
  end

  def bad_show(show, key, value = nil)
    if value.nil?
      show.reject{ |k| k == key.to_sym }
    else
      show.merge(key.to_sym => value)
    end
  end

  describe 'GET /' do
    before do
      get '/'
    end
    it 'displays the correct message' do
      expect(last_response.body).to eq('This app only accepts POST requests.')
    end
  end

  describe 'POST /' do
    let(:headers) { { 'CONTENT_TYPE': 'application/json' } }
    let(:show) do
      {
        country: 'UK',
        description: "What's life like when you have enough children to field your own football team?",
        drm: true,
        episodeCount: 3,
        genre: 'Reality',
        image: {
          showImage: 'http://catchup.ninemsn.com.au/img/jump-in/shows/16KidsandCounting1280.jpg'
        },
        language: 'English',
        nextEpisode: nil,
        primaryColour: '#ff7800',
        seasons: [
          {
            slug: 'show/16kidsandcounting/season/1'
          }
        ],
        slug: 'show/16kidsandcounting',
        title: '16 Kids and Counting',
        tvChannel: 'GEM'
      }
    end

    context 'success' do
      before do
        post '/', playlist(show).to_json, headers
      end

      it 'has the correct status code' do
        expect(last_response.status).to eq(200)
      end

      it 'is valid json' do
        expect(last_response).to be_json
      end

      it 'has a response key' do
        response_key = last_response.as_json.has_key?('response')
        expect(response_key).to be_truthy
      end

      it 'has the correct title' do
        title = response.fetch('title')
        expect(title).to eq('16 Kids and Counting')
      end

      it 'has the correct slug' do
        slug = response.fetch('slug')
        expect(slug).to eq('show/16kidsandcounting')
      end

      it 'has the correct image' do
        image = response.fetch('image')
        image_url = 'http://catchup.ninemsn.com.au/img/jump-in/shows/16KidsandCounting1280.jpg'
        expect(image).to eq(image_url)
      end
    end

    context 'failure' do
      it 'has the correct status code' do
        post '/', nil, headers
        expect(last_response.status).to eq(400)
      end

      it 'has the correct error message' do
        post '/', nil, headers
        expect(last_response.as_json.fetch('error')).to eq('Could not decode request: JSON parsing failed')
      end

      it 'is valid json' do
        post '/', nil, headers
        expect(last_response).to be_json
      end

      it 'fails when request has no payload' do
        post '/', nil, headers
        expect(last_response.status).to eq(400)
      end

      it 'fails when playlist object is missing title' do
        playlist = playlist(bad_show(show, 'title')).to_json
        post '/', playlist, headers
        expect(last_response.status).to eq(400)
      end

      it 'fails when playlist object is missing slug' do
        playlist = playlist(bad_show(show, 'slug')).to_json
        post '/', playlist, headers
        expect(last_response.status).to eq(400)
      end

      it 'requires drm to be true' do
        playlist = playlist(bad_show(show, 'drm', false)).to_json
        post '/', playlist, headers
        expect(last_response.as_json.fetch('response').size).to eq(0)
      end

      it 'requires episodeCount > 0' do
        playlist = playlist(bad_show(show, 'episodeCount', 0)).to_json
        post '/', playlist, headers
        expect(last_response.as_json.fetch('response').size).to eq(0)
      end

      it 'fails when playlist object is missing image' do
        playlist = playlist(bad_show(show, 'slug')).to_json
        post '/', playlist, headers
        expect(last_response.status).to eq(400)
      end
    end
  end
end
