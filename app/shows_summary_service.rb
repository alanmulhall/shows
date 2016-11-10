class ShowsSummaryService
  prepend SimpleCommand

  def initialize(request)
    @request = request
  end

  def call
    begin
      JSON.parse(@request.body.read)
        .fetch('payload')
        .select{ |show| show['drm'] == true && show['episodeCount'] > 0 }
        .map{ |show| {
          slug: show.fetch('slug'),
          title: show.fetch('title'),
          image: show.fetch('image').fetch('showImage')
        }
      }
    rescue
      errors.add(:parse, 'Could not decode request: JSON parsing failed')
    end
  end
end
