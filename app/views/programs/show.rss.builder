xml.instruct!
xml.rss "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd" do
  xml.channel do
    xml.title @program.title
    xml.link "kpsu.org"
    xml.language "en-us"
    xml.itunes :summary, strip_tags(@program.description)

    xml.itunes :owner do
      xml.itunes :name, @program.user.dj_name
      xml.itunes :email, @program.user.email
    end
   
    if @program.user.avatar.url != nil
     xml.itunes :image, :href => "kpsu.org" + @program.user.avatar.url
    end

    @playXML.each do |list|
      xml.item do
        xml.title list.title
        xml.itunes :subtitle, truncate(list.description,:length => 50)
        xml.pubDate list.updated_at.to_s(:rfc822)
        xml.itunes :duration, "1:00:00"
        if list.download.first != nil 
          xml.guid list.download.first.url
          xml.enclosure :url => list.download.first.url, :length => list.download.first.file_size, :type => 'audio/mpeg'
        end 
      end
    end
  end
end