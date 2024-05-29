class StaticPagesController < ApplicationController
  before_action :initialize_flickr

  def index
    flickr_id = params[:flickr_id]

    begin
      if flickr_id.present?
        @photos = @flickr.photos.search user_id: flickr_id
      else
        @photos = @flickr.photos.getRecent
      end
    rescue Flickr::FailedResponse => e
      @error = "There was an error with the Flickr API: #{e.message}"
      @photos = []
    end
  end

  private

  def initialize_flickr
    @flickr = Flickr.new Figaro.env.flickr_key, Figaro.env.flickr_secret
  end
end
