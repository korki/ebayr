# -*- encoding : utf-8 -*-
module Ebayr #:nodoc:
  # Encapsulates a request which is sent to the eBay Trading API.
  class ReturnsRequest < Request

    # Gets the headers that will be sent with this request.
    def headers
      {
        'X-EBAY-SOA-SERVICE-NAME' => 'ReturnManagementService',
        'X-EBAY-SOA-OPERATION-NAME' => @command.to_s,
        'X-EBAY-SOA-SERVICE-VERSION' => '1.0.0',
        'X-EBAY-SOA-SECURITY-TOKEN' => @auth_token.to_s,
        'X-EBAY-SOA-REQUEST-DATA-FORMAT' => 'XML',
        'Content-Type' => 'text/xml'
      }
    end

    # Gets the body of this request (which is XML)
    def body
      <<-XML
        <?xml version="1.0" encoding="utf-8"?>
        <#{@command}Request xmlns="http://www.ebay.com/marketplace/returns/v1/services">
          #{input_xml}
        </#{@command}Request>
      XML
    end
  end
end
