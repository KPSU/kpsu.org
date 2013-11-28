xml.instruct!
xml.rss "xmlns:itunes" => "http://www.itunes.com/dtds/podcast-1.0.dtd" do
  xml.channel do
    # Basic info
    xml.title @program.title
    xml.link "kpsu.org"
    xml.language "en-us"
    xml.itunes :summary, strip_tags(@program.description)
   
    if @program.user.avatar.url != nil
      xml.itunes :image, "kpsu.org" + @program.user.avatar.url
    end

    @playXML.each do |list|
      xml.item do
        xml.title list.title
        xml.itunes :subtitle, truncate(list.description,:length => 50)
        xml.pubDate list.updated_at.to_s(:rfc822)
        if list.download.first != nil 
          xml.guid list.download.first.url
        end 
      end
    end
  end
end