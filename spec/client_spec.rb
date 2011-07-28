require 'spec_helper'
require 'nodester'

describe Nodester::Client do
  before(:each) do
    fake_it_all
    @client = Nodester::Client.new("arthur","dent")
  end
  

  context "when invoking platform_coupon_request" do
    it "should be a success" do
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

  # Need testing:
  #platform_create_user
  #update_user
  #platform_delete_user

  context "when invoking create_app" do
    it "should create an app" do
      res = @client.create_app "testapp","server.js"
      res['status'].should == "success"
      res['port'].should > 0
      res['gitrepo'].start_with?('git@nodester.com:/node/git/').should == true
      res['start'].should == 'server.js'
      res['running'].should == false
      res['pid'].should == 'unknown'
      
    end
  end

=begin
  context "when invoking update_app" do
    it "should update an app" do
      res = @client.update_app
    end
  end

  context "when invoking start_stop_app" do
    it "should start an app" do
      res = @client.start_stop_app('testapp',true)
    end
  end
  
  context "when invoking delete_app" do
    it "should delete an app" do
      res = @client.delete_app
    end
  end
=end

  context "when invoking app" do
    it "should return app info" do
      res = @client.app 'a1234'
      res['status'].should == "success"
      res['port'].should > 0
      res['gitrepo'].start_with?('git@nodester.com:/node/git/').should == true
      res['start'].should == 'server.js'
      res['running'].should == false
      res['pid'].should == 'unknown'
      
    end
  end

  context "when invoking apps" do
    it "should return a list of apps" do
      res = @client.apps
      res.length.should == 2
      res[0]['name'].should == 'a1234'
    end
  end

=begin
  context "when invoking update_env" do
    it "should set an env value" do
      res = @client.update_env
    end
  end
  
  context "when invoking delete_env" do
    it "should remove an env value" do
      res = @client.delete_env
    end
  end

  context "when invoking env" do
    it "should return an env value" do
      res = @client.env
    end
  end
=end

  context "when invoking update_npm" do
    it "should perform an op against the npm" do
      res = @client.update_npm 'myappname','install','express'
      res['output'].length.should > 0
      res['status'].should == 'success'
    end
  end

=begin
  context "when invoking create_appdomain" do
    it "should create an app domain" do
      res = @client.create_appdomain
    end
  end

  context "when invoking delete_appdomain" do
    it "should delete an app domain" do
      res = @client.delete_appdomain
    end
  end

  context "when invoking appdomains" do
    it "should list all available appdomains" do
      res = @client.update_npm
    end
  end
=end

end