require_relative '../../../puppet_x/modules/server/service_api.rb'
require_relative '../../../puppet_x/modules/server/adaptive_profiling_api.rb'
require_relative '../../../puppet_x/modules/login_info.rb'

require 'json'
require 'base64'
require 'logger'
require 'uri'
#require 'rest-client'

Puppet::Type.type(:service_adaptive_profiling).provide(:service_adaptive_profilingprovider) do

  Puppet.debug("Inside service_adaptive_profilingprovider: ")

  mk_resource_methods

  def exists?
    Puppet.debug("Calling exists method of service_adaptive_profilingprovider: ")
    @property_hash[:ensure] == :present

    # getting waf authorization token
    login_instance = Login.new
    auth_header = login_instance.get_auth_header
    Puppet.debug("WAF authorization token:  #{auth_header}")
    service_profling_instance=SwaggerClient::AdaptiveProfilingApi.new
    #call get service_adaptive_profiling
    svcName=@resource[:name]
    Puppet.debug("WAF service name in manifest:  #{svcName}")
    data,status_code,headers=service_profling_instance.services_web_application_name_adaptive_profiling_get(auth_header,svcName)
    if status_code == 200
       true
    elsif status_code == 404
      false
    else
      fail("Not able to process the request. Pleae check your request parameters.")
    end

  end


  def self.instances

    Puppet.debug("Calling instances method of service_adaptive_profilingprovider: ")
    instances = []
    login_instance = Login.new
    auth_header = login_instance.get_auth_header
    service_instance = SwaggerClient::ServiceApi.new
    # get all service_adaptive_profiling from WAF
    data,status_code,headers = service_instance.services_get(auth_header,{})
    Puppet.debug("WAF Get all services response:    #{data}")
    
    unless data == '{}'
    if status_code == 200
      response = JSON.parse(data)
      svcobj = response["object"]
      Puppet.debug("Object is  #{svcobj}")
      svcData = response["data"]
      Puppet.debug("Service  data:  #{svcData}")
      svcData.each do |key,value|
        val= value
        instances <<  new(
          :ensure => :present,
          :name => val["name"],
        ) 
      end
   end # if end
  end  # unless end

    return instances
  end


  def self.prefetch(resources)

    Puppet.debug("Calling prefetch method of service_adaptive_profilingprovider: ")
    services = instances
    resources.keys.each do |name|
    if provider = services.find { |service| service.name == name}
       resources[name].provider=provider
    end
  end

  end


  def flush

    Puppet.debug("Calling flush method of service_adaptive_profilingprovider: ")

    if @property_hash != {}

    login_instance = Login.new
    auth_header = login_instance.get_auth_header
    service_profling_instance=SwaggerClient::AdaptiveProfilingApi.new
    
    svcName=@resource[:name]
    data,status_code,headers= service_profling_instance.services_web_application_name_adaptive_profiling_put(auth_header,svcName,message(resource),{})
    Puppet.debug("WAF services PUT response:  #{data}")
    end
    return data
  end


  def message(object)

    opts=object.to_hash
    opts.delete(:provider)
    opts.delete(:ensure)
    opts.delete(:loglevel)
    opts=convert_underscores(opts)
    params=opts

    Puppet.debug("PARAM....................#{params}")
    return params

  end


  def convert_underscores(hash)

    hash.each_with_object({}) do |(k ,v), obj|
      key = k.to_s.gsub(/_/, '-').to_sym
      obj[key] = v

    end

  end


  def create

    Puppet.debug("Calling create method of service_adaptive_profilingprovider: ")
=begin
    login_instance = Login.new
    auth_header = login_instance.get_auth_header
    service_instance = SwaggerClient::ServiceApi.new
    svcName=@resource[:name]
    data,status_code,headers= service_instance.services_web_application_name_put(auth_header,svcName,message(resource),{})
    Puppet.debug("WAF services CREATE response:  #{data}"
    if status_code == 201
      @property_hash.clear
      return data
    else
      fail("Not able to create the service. Please check the service api parameters")
    end
=end
  end


  def destroy

    Puppet.debug("Calling destroy method of service_adaptive_profilingprovider: ")

=begin
    login_instance = Login.new
    auth_header = login_instance.get_auth_header
    service_instance = SwaggerClient::ServiceApi.new
    svcName=@resource[:name]
    data,status_code,headers= service_instance.services_web_application_name_put(auth_header,svcName,message(resource),{})
      @property_hash.clear
      return data
=end
  end


end
