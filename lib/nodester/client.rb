require 'httparty'

module Nodester
  # An API wrapper for the nodester.com API
  # @example Request a nodester.com coupon
  #   client = Nodester::Client.new("","")
  #   client.platform_coupon_request('arthur@dent.com')
  # 
  # @example Convert a coupon (received per email) to an account
  #   client = Nodester::Client.new("","")
  #   client.platform_create_user("coupon",'arthur','dent','arthur@dent.com','rsakey')
  #
  # @example Get the platform status
  #   client = Nodester::Client.new("","")
  #   res = client.platform_status()
  #   puts "Status #{res['status']} Apps Hosted #{res['appshosted']} Apps Running #{res['appsrunning']}"
  # 
  # @example Create an app
  #   client = Nodester::Client.new("arthur","dent")
  #   client.create_app 'myappname','server.js'
  #
  #   
  class Client
    include HTTParty
    base_uri 'http://api.nodester.com'

    PLATFORM_URI = 'http://nodester.com'
  
    def initialize(u, p )
      @auth = {:username => u, :password => p}
    end
          

    # Examines a bad response and raises an approriate exception
    #
    # @param [HTTParty::Response] response
    def self.bad_response(response)
      if response.class == HTTParty::Response
       raise ResponseError, response
      end
      raise StandardError, "Unkown error"
    end

    def handle_result(res)
      res.ok? ? res : bad_response(res) 
    end

    # ------------------------------------
    # Nodester.com platform specific functions
    # ------------------------------------
  
    # Creates a coupon request against nodester.com for early access
    # Flow is as follows: You post this and receive a coupon per email.
    # Parameters:
    #   email (required) : "x@y.com"
    # Returns:
    #   status : "success - you are now in queue to receive an invite on our next batch!"
    def platform_coupon_request(email)
      options={ :body => {:email => email}, :base_uri => PLATFORM_URI}
      handle_result self.class.post('/coupon', options)
    end

    # Returns the nodester.com platform status
    # {:status=>"up", :appshosted=>1599, :appsrunning=>988} 
    def platform_status()
      options = {:base_uri => PLATFORM_URI}
      handle_result self.class.get('/status', options)
    end

    # Creates a new user from the coupon given.
    def platform_create_user(coupon,user,password,email,rsakey)
      options={ :body => {:coupon => coupon,:user =>user,:password=>password,:email=>email,:rsakey=>rsakey}, :base_uri => PLATFORM_URI}
      handle_result self.class.post('/user', options)
    end
    
    # ------------------------------------
    # API specific functions
    # ------------------------------------
  
    # Updates the current user.
    def update_user(opts={})
      options={:body => opts,:basic_auth => @auth}
      handle_result self.class.put('/user', options)
    end

    # Deletes the current user.
    def platform_delete_user()
      options={:basic_auth => @auth}
      handle_result self.class.delete('/user', options)
    end
  


    # Creates a new app
    # Parameters are:
    #   appname (required). The name of the app.
    #   start (required). The file to start, for example server.js.
    # Returns:
    #   status : "success" | "failure"
    #   message : "some text" ==> Only if failure
    #   port : 12345
    #   gitrepo : 'git@nodester.com:/node/git/mwawrusch/blah.git'
    #   start : "the value of start, for example servre.js"
    #   running : true | false 
    #   pid : "unknown" | some pid 
    def create_app(appname,start)
      options={:body => {:appname=>appname,:start=>start}, :basic_auth => @auth}
      handle_result self.class.post('/app', options)
    end

    
    def update_app(appname,opts = {})
      opts.merge!({:appname => appname})
      
      options={:body=> opts, :basic_auth => @auth}
      handle_result self.class.put('/app', options)
    end

    def start_stop_app(appname,running = true)
      
      options={:body=> {:appname => appname, :running=>start}, :basic_auth => @auth}
      handle_result self.class.put('/app', options)
    end


    def delete_app(appname)
      options={:body => {:appname => appname}, :basic_auth => @auth}
      handle_result self.class.delete('/app', options)
    end
  
    def app(appname)
      options={:body => {},:basic_auth => @auth}
      handle_result self.class.get("/app/#{appname}", options)
    end
  
    # Get a list of all apps.
    # Returns:
    #   An array containing a list of apps, if any.
    #
    # App object format:
    #   name : testxyz1
    #   port : 12344
    #   gitrepo : 'git@nodester.com:/node/git/mwawrusch/blah.git'
    #   running : false
    #   pid : "unknown" | some pid 
    #   gitrepo : 'git@nodester.com:/node/git/mwawrusch/2914-2295037e88fed947a9b3b994171c5a9e.git", "running"=>false, "pid"=>"unknown"} 
    def apps()
      options={:basic_auth => @auth}
      handle_result self.class.get('/apps', options)
    end
  
  
  
    def update_env(appname,key,value)
      options={:body => {:appname => appname,:key=>key,:value=>value},:basic_auth => @auth}
      handle_result self.class.put('/env', options)
    end

    def delete_env(appname,key)
      options={:body => {:appname => appname,:key=>key},:basic_auth => @auth}
      handle_result self.class.delete('/env', options)
    end
  
    def env(appname,key)
      options={:body => {:appname => appname,:key=>key},:basic_auth => @auth}
      handle_result self.class.get('/env', options)
    end
  
  # curl -X POST -u "mwawrusch:mw09543089" -d "appname=myappname&action=install&package=express" http://api.nodester.com/npm
  
    def update_npm(appname,action,package)
      options={:body => {:appname => appname,:action => action,:package=>package},:basic_auth => @auth}
      handle_result self.class.post('/npm', options)
    end
  
  
    def create_appdomain(appname,domain)
      options={:body => {:appname => appname,:domain=>domain},:basic_auth => @auth}
      handle_result self.class.post('/appdomains', options)
    end
  
    def delete_appdomain(appname,domain)
      options={:body => {:appname => appname,:domain=>domain},:basic_auth => @auth}
      handle_result self.class.delete('/appdomains', options)
    end
  
    def appdomains()
      options={:basic_auth => @auth}
      handle_result self.class.get('/appdomains', options)
    end
  
  
  end

end

