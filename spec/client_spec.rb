require 'spec_helper'
require 'nodester'

describe Nodester::Client do
  before(:each) do
    fake_it_all
    @client = Nodester::Client.new("arthur","dent")
  end
  

  context "when invoking platform_coupon_request" do
    it "should return a status" do
      res = @client.platform_coupon_request "arthur@dent.com"
      res['status'].start_with?('success').should == true
    end
  end
  
  context "when invoking platform_status" do
    it "should return a status" do
      res = @client.platform_status
      res['status'].should == "up"
      res['appshosted'].should == 1599
      res['appsrunning'].should == 988
    end
  end

end