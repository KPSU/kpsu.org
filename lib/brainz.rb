require 'rbrainz'
require 'amazon/aws'
require 'amazon/aws/search'
include Amazon::AWS
include Amazon::AWS::Search

class BrainzAPI
  include MusicBrainz
  
  attr_writer :name, :releases
  attr_reader :name, :releases

  def initialize=(login, password)
    @login = 'kpsu'
    @password = 'kpsu.org2010'
    @brainz =  MusicBrainz::Client.new(@login, @password)
  end
  
  def add_brainz_to_artist(id)
    @artist = Artist.find(id)
    artists = query.get_artists(:query => @artist.name)
    a = artists.to_collection
    @uuid = a.first.id.uuid
    if @uuid
      @artist.brainz_id = @uuid
      @artist.save
      puts "#{@artist.name} saved w/ uuid: #{@artist.brainz_id}"
    end
  end
  
  def add_brainz_to_many_artists(artists)
    @artists.each do |artist|
      artists = query.get_artists(:query => artist.name)
      a = artists.to_collection
      @uuid = a.first.id.uuid
      if @uuid
        artist.brainz_id = @uuid
        artist.save
        puts "#{artist.name} saved w/ uuid: #{artist.brainz_id}"
      end
    end
  end
  
  def lookup_artist(artist_brainz_id)
    artist_includes = Webservice::ArtistIncludes.new(
       :aliases      => true,
       :releases     => ['Album', 'Official'],
       :artist_rels  => true,
       :release_rels => true,
       :track_rels   => true,
       :label_rels   => true,
       :url_rels     => true,
       :discs        => true,
       :ratings		   => true
    )
    brainz = query.get_artist_by_id(artist_brainz_id, artist_includes)
  end
  
  def lookup_album_art(release)
    @release = release
    rg = ResponseGroup.new( 'Large' )
    req = Request.new
    il = ItemLookup.new( 'ASIN', { 'ItemId' => @release.asin,
                                    'MerchantId' => 'Amazon' } )
    begin
      @req = req.search( il, rg, 1 )
      @medium = @req.item_lookup_response.items.item.first.medium_image.url.to_s
      @large = @req.item_lookup_response.items.item.first.large_image.url.to_s 
      @image = {}
      @image[:small] = @medium
      @image[:large] = @large
    rescue      
      @image = nil
    end
    return @image                          
  end
  
  def query
    query  = Webservice::Query.new
  end
  
  def official_albums()
    
  end
  
  def band_members(artist_id)
      @band_members = []
      @artist = lookup_artist(artist_id)
      @relations = @artist.get_relations(:relation_type => 'MemberOfBand')
      @relations.each do |r|
        @band_members << r.target.name
      end
      return @band_members
  end
  
  def lookup_release(release_id)
    release_includes = Webservice::ReleaseIncludes.new(
    :artist       => true,
    :counts       => true,
    :tracks       => true,
    :url_rels     => true,
    :track_rels   => true,
    :label_rels   => true,
    :url_rels     => true,
    :discs        => true,
    :ratings		   => true
    )
    brainz = query.get_release_by_id(release_id, release_includes)
  end
  
  def lookup_release_group(release_id)
    
  end
  
end
