module Rockstar
  
  class Auth < Base
    # Returns the token for a session. You have to use
    # TokenAuth first and then use this class with the token
    # that is given by last.fm to create a session token
    # This session token can be stored in your database, it is
    # not expiring.
    # See Rockstar::TokenAuth for a detailed example
    def session(token)
      doc = self.class.fetch_and_parse("auth.getSession", {:token => token}, true)
      Rockstar::Session.new_from_xml(doc)
    end
    
    def token
      doc = self.class.fetch_and_parse("auth.getToken", {}, true)
      token = (doc).at(:token).inner_html if (doc).at(:token)
      token
    end
  end
end
