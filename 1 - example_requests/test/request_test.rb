require_relative 'spec_helper'
require_relative '../lib/request'

class RequestTest < Minitest::Test

  #  def test_parses_http_method_from_simple_get
  #    request_string = File.read('../get-index.request.txt')
  #    request = Request.new(request_string)

  #    assert_equal 'GET', request.method
  #  end

  #  def test_parses_resource_from_simple_get
  #    request_string = File.read('../get-index.request.txt')
  #    request = Request.new(request_string)

  #    assert_equal '/', request.resource
  #  end

  #  def test_parses_version_from_simple_get
  #    request_string = File.read('../get-index.request.txt')
  #    request = Request.new(request_string)

  #    assert_equal 'HTTP/1.1', request.version

  #  end

  def test_parses_http_method_from_simple_get_request
    request_string = File.read('../post-login.request.txt')
    request = Request.new(request_string)

    assert_equal 'POST', request.method
  end

  def test_parses_http_resource_from_simple_get_request
    request_string = File.read('../post-login.request.txt')
    request = Request.new(request_string)

    assert_equal '/login', request.resource
  end

   def test_parses_http_version_from_simple_get_request
     request_string = File.read('../post-login.request.txt')
     request = Request.new(request_string)

    assert_equal 'HTTP/1.1', request.version
   end

   def test_parses_http_headers_from_simple_get_request
    request_string = File.read('../post-login.request.txt')
     request = Request.new(request_string)
     hash = {"Host"=>"foo.example", "Content-Type"=>"application/x-www-form-urlencoded", "Content-Length"=>"39"}
     assert_equal hash, request.headers
   end

   def test_parses_http_params_from_simple_get_request
     request_string = File.read('../get-fruits-with-filter.request.txt')
     request = Request.new(request_string)
     hash = {'type' => 'bananas', 'minrating' => '4'}
     assert_equal hash, request.params
   end




end