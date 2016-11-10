### Shows Endpoint
A small service which transforms a provided JSON.

#### Prerequists
1. Ruby 2.3.0

#### Install
1. run `gem bundler install`
2. run `bundle install --path vendor/bundle`

#### Run the app
1. run `bundle exec rackup config.ru`
2. hit the endpoint
```shell
curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -H "Postman-Token: 1cc21021-04ac-d748-7ab9-395ebfaef848" -d '{
    "payload": [
        {
            "country": "UK",
            "description": "What'"'"'s life like when you have enough children to field your own football team?",
            "drm": true,
            "episodeCount": 3,
            "genre": "Reality",
            "image": {
                "showImage": "http://catchup.ninemsn.com.au/img/jump-in/shows/16KidsandCounting1280.jpg"
            },
            "language": "English",
            "nextEpisode": null,
            "primaryColour": "#ff7800",
            "seasons": [
                {
                    "slug": "show/16kidsandcounting/season/1"
                }
            ],
            "slug": "show/16kidsandcounting",
            "title": "16 Kids and Counting",
            "tvChannel": "GEM"
        }
    ],
    "skip": 0,
    "take": 10,
    "totalRecords": 75
}' "http://localhost:9292"
```

#### Run the tests
1. run `rspec`

#### Use the app on Heroku
1. Do a POST request to: `https://intense-savannah-56279.herokuapp.com/`
```shell
curl -X POST -H "Content-Type: application/json" -H "Cache-Control: no-cache" -H "Postman-Token: 1cc21021-04ac-d748-7ab9-395ebfaef848" -d '{
    "payload": [
        {
            "country": "UK",
            "description": "What'"'"'s life like when you have enough children to field your own football team?",
            "drm": true,
            "episodeCount": 3,
            "genre": "Reality",
            "image": {
                "showImage": "http://catchup.ninemsn.com.au/img/jump-in/shows/16KidsandCounting1280.jpg"
            },
            "language": "English",
            "nextEpisode": null,
            "primaryColour": "#ff7800",
            "seasons": [
                {
                    "slug": "show/16kidsandcounting/season/1"
                }
            ],
            "slug": "show/16kidsandcounting",
            "title": "16 Kids and Counting",
            "tvChannel": "GEM"
        }
    ],
    "skip": 0,
    "take": 10,
    "totalRecords": 75
}' "https://intense-savannah-56279.herokuapp.com/"
```
