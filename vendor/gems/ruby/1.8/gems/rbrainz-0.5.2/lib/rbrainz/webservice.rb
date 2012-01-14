# -*- coding: utf-8 -*-
# $Id: webservice.rb 254 2009-05-13 20:04:36Z phw $
#
# Author::    Philipp Wolfer (mailto:phw@rubyforge.org)
# Copyright:: Copyright (c) 2007, Nigel Graham, Philipp Wolfer
# License::   RBrainz is free software distributed under a BSD style license.
#             See LICENSE[file:../LICENSE.html] for permissions.

module MusicBrainz # :nodoc:

  # Classes for interacting with the MusicBrainz XML web service.
  # 
  # The WebService class talks to a server implementing the MusicBrainz XML
  # web service. It mainly handles URL generation and network I/O. Use this
  # if maximum control is needed.
  # 
  # The Query class provides a convenient interface to the most commonly used
  # features of the web service. By default it uses Webservice to retrieve data
  # and the MBXML parser to parse the responses. The results are object trees
  # using the MusicBrainz domain model.
  # 
  # See:: Model
  module Webservice
    
    # Base exception class for all webservice errors.
    class WebserviceError < ::Exception
    end

    # Connecting to the web service failed.
    #
    # This exception is raised if the connection to the server can not be
    # established due to networking problems (e.g. wrong port number or
    # server down).
    class ConnectionError < WebserviceError
    end
    
    # An invalid request was made.
    # 
    # This exception is raised if the client made an invalid request. That could
    # be syntactically invalid identifiers or unknown or invalid parameter values.
    class RequestError < WebserviceError
    end
    
    # Client requested a resource which requires authentication via HTTP
    # Digest Authentication.
    # 
    # If sent even though user name and password were given: user name and/or
    # password are incorrect. 
    class AuthenticationError < WebserviceError
    end
    
    # The requested resource doesn't exist.
    class ResourceNotFoundError < WebserviceError
    end

    # The returned resource was invalid.
    # 
    # This may be due to a malformed XML document or if the requested data
    # wasn't part of the response. It can only occur in case of bugs in the web
    # service itself.
    class ResponseError < WebserviceError
    end
    
  end 
end

require 'rbrainz/webservice/query'
