require 'net/https'
require 'xmlsimple'
require 'csv'
require 'active_support'
require 'active_support/core_ext/object/blank'
require 'active_support/core_ext/hash/keys'
require 'salesforce_bulk/version'
require 'salesforce_bulk/core_extensions/string'
require 'salesforce_bulk/salesforce_error'
require 'salesforce_bulk/client'
require 'salesforce_bulk/job'
require 'salesforce_bulk/batch'
require 'salesforce_bulk/batch_result'
require 'salesforce_bulk/batch_result_collection'
require 'salesforce_bulk/query_result_collection'

# set the default @decode_content to true so that ruby 2.1.2 works the same as 1.9.3
module HTTPResponseDecodeContentOverride
  def initialize(h,c,m)
    super(h,c,m)
    @decode_content = true
  end
  def body
    res = super
    if self['content-length']
      self['content-length']= res.bytesize
    end
    res
  end
end
module Net
  class HTTPResponse
    prepend HTTPResponseDecodeContentOverride
  end
end
