class ApplicationController < ActionController::Base  
  protect_from_forgery
  require 'httparty'

  class ITunesSearch
    include HTTParty
    base_uri 'http://ax.itunes.apple.com/WebObjects/MZStoreServices.woa/wa'
    format :json

    class << self
      def search(query={})
        get("/wsSearch", :query => query)["results"]
      end
      
      def lookup(query={})
        if results = get("/wsLookup", :query => query)["results"]
          results[0]
        end
      end

      def lookup_all(query={})
          results = get("/wsLookup", :query => query)["results"]
      end

      def lookup_artist_image(query={})
        if results = get("/wsLookup", :query => query)["results"]
          results.delete_at(0)
          results.sort_by! { |a| a["releaseDate"] }
          #the issue here is that we're running through all of results and using the last one.
          #also - if no elements of results has an "artworkUrl100" value it might throw an error.
          @image = nil
          
          results.each do |result|
            @image = result["artworkUrl100"]
          end
          
          return @image    
          
        end
      end
      
      def lookup_artist_albums(query={})
        #It would be nice to combine this with lookup_artist_image
        if results = get("/wsLookup", :query => query)["results"]
          results.delete_at(0)
          results.sort_by! { |a| a["releaseDate"]}.reverse!
          
          #@albums = nil
          
          @albums = results
          #results.each do |result|
          #  @albums = result["artworkUrl100"]
          #end
          
          return @albums    
          
        end
      end  
          
    end
  end  
end
