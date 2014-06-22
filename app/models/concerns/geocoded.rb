require 'geocoder'

module Geocoded
  extend ActiveSupport::Concern

  DELAY = 0.15 # adjust this higher if you are seeing rate limit warnings, lower if the app is starting to lag noticeably

  included do
    
    before_save :geocode!
    geocoded_by :location

  end

  def geocode!( force = false )
    if Rails.env.test?
      latitude, longitude = Faker::Address.latitude, Faker::Address.longitude
    elsif( force || !( geocoded? && !geocoding_attributes_changed? ) )
      geocode
      sleep DELAY
    end
  end

  protected

  def geocoding_attributes_changed?
    ( self.line1_changed? || self.city_changed? || self.state_changed? || self.zip_changed? )
  end

  def meters_to!( site )
    raise "Can only get distance to another #{self.class.to_s}!" unless site.kind_of? self.class
    raise "Both sites must already be geocoded!" unless site.geocoded? && self.geocoded?
    ( self.distance_to( site.to_coordinates, :km ) * 1000 ).round
  end

  def meters_to( site )
    meters_to!( site )
  rescue
    -1
  end

end
