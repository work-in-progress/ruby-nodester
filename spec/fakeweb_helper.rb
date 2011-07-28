require 'fakeweb'

FakeWeb.allow_net_connect = false

def stub_file(stub)
  File.join(File.dirname(__FILE__), 'stubs', stub)
end

def fake_it_all
  FakeWeb.clean_registry
  #FakeWeb.register_uri :head, %r{http://(api.)|(www.)?nodester.com(/items)?}, :status => ["200", "OK"]
 
  {
    # GET URLs
    :get => {
      'http://nodester.com/status' => 'platform_get_status'
    },
    # POST URLs
    :post => {
      'http://nodester.com/coupon' => 'platform_post_coupon'
    },
    # PUT URLs
    :put => {
    },
    # DELETE URLs
    :delete => {
    }
  }.each do |method, requests|
    requests.each do |url, response|
      FakeWeb.register_uri(method, url, :response => stub_file(response))
    end
  end
end

