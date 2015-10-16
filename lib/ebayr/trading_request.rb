# -*- encoding : utf-8 -*-
module Ebayr #:nodoc:
  # Encapsulates a request which is sent to the eBay Trading API.
  class TradingRequest < Request

    # Gets the headers that will be sent with this request.
    def headers
      {
        'X-EBAY-API-COMPATIBILITY-LEVEL' => @compatability_level.to_s,
        'X-EBAY-API-DEV-NAME' => dev_id.to_s,
        'X-EBAY-API-APP-NAME' => app_id.to_s,
        'X-EBAY-API-CERT-NAME' => cert_id.to_s,
        'X-EBAY-API-CALL-NAME' => @command.to_s,
        'X-EBAY-API-SITEID' => @site_id.to_s,
        'Content-Type' => 'text/xml'
      }
    end

    # Gets the body of this request (which is XML)
    def body
      <<-XML
        <?xml version="1.0" encoding="utf-8"?>
        <#{@command}Request xmlns="urn:ebay:apis:eBLBaseComponents">
          #{requester_credentials_xml}
          #{input_xml}
        </#{@command}Request>
      XML
    end

    # Returns eBay requester credential XML if @auth_token is present
    def requester_credentials_xml
      return "" unless @auth_token && !@auth_token.empty?

      <<-XML
      <RequesterCredentials>
        <eBayAuthToken>#{@auth_token}</eBayAuthToken>
      </RequesterCredentials>
      XML
    end
  end
end
