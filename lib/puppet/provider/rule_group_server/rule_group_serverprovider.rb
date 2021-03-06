require_relative '../../../puppet_x/modules/service/service_api.rb'
require_relative '../../../puppet_x/modules/rule_group_server/rule_group_server_api.rb'
require_relative '../../../puppet_x/modules/login_info.rb'
require_relative '../../../puppet_x/modules/rule_group/rule_group_api.rb'
require 'json'
require 'base64'
require 'logger'
require 'uri'

Puppet::Type.type(:rule_group_server).provide(:rule_group_serverprovider) do
  Puppet.debug("Inside rule_group_serverprovider: ")
  mk_resource_methods

  def exists?
    Puppet.debug("Calling exists method of rule_group_serverprovider: ")
    @property_hash[:ensure] == :present
  end

  def self.instances
    Puppet.debug("Calling self.instances method")

    services = getservices()
    Puppet.debug("List of services .................. #{services}")

    instances = []
    services.each do |service|
      serviceName = service
      rules = getrules(serviceName)
      rules.each do |rule|
        rule_name = rule
        Puppet.debug("Calling getInstances method of rule_group_serverprovider: ")
        Puppet.debug("Service Name : #{serviceName}")
        Puppet.debug("rule group Name : #{rule_name}")
        login_instance = Login.new
        auth_header = login_instance.get_auth_header
        rule_group_server_instance = SwaggerClient::RuleGroupServerApi.new
        # get all rule_group_server from WAF
        data,status_code,headers = rule_group_server_instance.services_web_application_name_content_rules_rule_group_name_content_rule_servers_get(auth_header,serviceName,rule_name,{})
        Puppet.debug("WAF Get all rule_group_server response:    #{data}")
        response = JSON.parse(data)
        svrData =response["data"]
        service_name = response["Service"]
        rule_group_name = response["Rule Group"]
        Puppet.debug("The DATA:::::: #{svrData}")
        if svrData
          svrData.each do |key,value|
             rule_grp_server_name = value["name"]
             val= value
             Puppet.debug("Instances method.. VAL is #{val}")
             instances <<  new(
               :ensure => :present,
               :name => rule_grp_server_name,
               :rule_group_name => rule_group_name,
               :service_name => response["Service"],
               :address_version => val["address-version"],
               :backup_server => val["backup-server"],
               :comments => val["comments"],
               :hostname => val["hostname"],
               :identifier => val["identifier"],
               :ip_address => val["ip-address"],
               :port => val["port"],
               :status => val["status"],
               :weight => val["weight"]
             )
        end
      end # if end
     end  # if end for rules
    end# do end services 
    return instances
  end

  #this method get all services from WAF system and builds the instances array
  def self.getservices
     Puppet.debug("Calling getservices  method of rule_group_serverprovider: ")
     service_instances = []
     login_instance = Login.new
     auth_header = login_instance.get_auth_header
     service_instance = SwaggerClient::ServiceApi.new
   # get all services from WAF
     data,status_code,headers = service_instance.services_get(auth_header,{})
     Puppet.debug("WAF Get all services response:    #{data}")
     unless data == '{}'
       if status_code == 200
          response = JSON.parse(data)
          svcobj = response["object"]
          Puppet.debug("Object is  #{svcobj}")
          svcData = response["data"]
         Puppet.debug("Service  data - having servers:  #{svcData}")
            svcData.each do |key,value|
               service_instances.push(value["name"])
            end
        end
     end
    return service_instances
  end
  #this method get all rules from WAF system and builds the instances array
  def self.getrules(service_name)
     Puppet.debug("Calling getrules  method of rule_group_serverprovider: ")
     rule_group_instances = []
     login_instance = Login.new
     auth_header = login_instance.get_auth_header
     rule_group_instance = SwaggerClient::RuleGroupApi.new
   # get all services from WAF
     data,status_code,headers = rule_group_instance.services_web_application_name_content_rules_get(auth_header,service_name,{})
     Puppet.debug("WAF Get all rules response:    #{data}")
     unless data == '{}'
       if status_code == 200
          response = JSON.parse(data)
          svcobj = response["object"]
          Puppet.debug("Object is  #{svcobj}")
          svcData = response["data"]
         Puppet.debug("rule group  data - having rules:  #{svcData}")
            unless svcData.nil?
              svcData.each do |key,value|
                 rule_group_instances.push(value["name"])
              end
            end
        end
     end
    return rule_group_instances
  end

  def self.prefetch(resources)
    rules = instances
    resources.keys.each do |name|
      Puppet.debug("Name is.................. #{name}")
      provider = rules.find do |rule|
        Puppet.debug("Service Name is ....................... #{rule.name} and  #{rule.service_name} and #{rule.rule_group_name}")
        resources[name][:name].to_s == rule.name.to_s &&
        resources[name][:service_name].to_s == rule.service_name.to_s &&
        resources[name][:rule_group_name].to_s == rule.rule_group_name.to_s
      end
      resources[name].provider = provider unless provider.nil?
    end
  end # self.prefetch

  def flush
    Puppet.debug("Calling flush method of rule_group_serverprovider: ")
    if @property_hash != {}
      login_instance = Login.new
      auth_header = login_instance.get_auth_header
      rule_group_server_instance = SwaggerClient::RuleGroupServerApi.new
    serviceName = @resource[:service_name]
    rule_group_name = @resource[:rule_group_name]
    rule_grp_server_Name = @resource[:name]
      data,status_code,headers = rule_group_server_instance.services_web_application_name_content_rules_rule_group_name_content_rule_servers_web_server_name_put(auth_header,serviceName,rule_group_name,rule_grp_server_Name,message(resource,"flush"),{})
      Puppet.debug("WAF services PUT response:  #{data}")
        if status_code == 200
          return data
        else
          Puppet.debug("There is some problem to process the request. status_code is #{status_code}")
          return
        end
    end
  end

  def message(object,method)
    parameters = object.to_hash

    serverName=@resource[:name]

    val = parameters.has_key?(:identifier)
    val2 = parameters[:identifier]

    if parameters.has_key?(:identifier) && parameters[:identifier] == :Hostname
      hostname = nil
      if parameters.key?:hostname
        hostname = parameters[:hostname]
      else
        fail("hostname is required parameter in the manifest if identifier is set to hostname.")
      end

      if hostname.nil?
        fail("hostname is empty. Please add a valid hostname since the identifier is set to hostname.")
      else
        parameters[:identifier]="Hostname"
        parameters[:hostname]=hostname
      end
    else
      ip_address = nil
      if parameters.key?:ip_address
        ip_address = parameters[:ip_address]

        if ip_address.nil?
          fail("ip_address is empty. Please a valid value for it.")
        else
          parameters[:identifier]="IP Address"
          parameters[:ip_address]=ip_address
        end
      else
        fail("ip_address is required parameter in the manifest.")
      end
    end

    parameters.delete(:provider)
    parameters.delete(:ensure)
    parameters.delete(:loglevel)
    parameters.delete(:service_name)
    parameters.delete(:rule_group_name)
    if method === "flush"
      parameters.delete(:address_version)
    end
    parameters=convert_underscores(parameters)
    Puppet.debug("Message method.... #{parameters}")
    return parameters

  end

  def convert_underscores(hash)
    hash.each_with_object({}) do |(k ,v), obj|
      key = k.to_s.gsub(/_/, '-').to_sym
      obj[key] = v

    end
  end

  def create
    Puppet.debug("Calling create method of rule_group_serverprovider: ")
    login_instance = Login.new
    auth_header = login_instance.get_auth_header
    rule_group_server_instance = SwaggerClient::RuleGroupServerApi.new
    serviceName = @resource[:service_name]
    rule_group_name = @resource[:rule_group_name]
    data,status_code,headers= rule_group_server_instance.services_web_application_name_content_rules_rule_group_name_content_rule_servers_post(auth_header,serviceName, rule_group_name,message(resource,"create"),{})
    Puppet.debug("WAF rule group server CREATE response:  #{data}")
    if status_code == 201
      @property_hash.clear
      return data
    else
      fail("Not able to create the rule_group_server. Please check the rule_group_server api parameters")
    end
  end

  def destroy
    Puppet.debug("Calling destroy method of rule_group_serverprovider: ")
    login_instance = Login.new
    auth_header = login_instance.get_auth_header
    rule_group_server_instance = SwaggerClient::RuleGroupServerApi.new
    serviceName = @resource[:service_name]
    rule_group_name = @resource[:rule_group_name]
    rule_grp_server_Name = @resource[:name]
    data,status_code,headers= rule_group_server_instance.services_web_application_name_content_rules_rule_group_name_content_rule_servers_web_server_name_delete(auth_header,serviceName,rule_group_name,rule_grp_server_Name,{})
    @property_hash.clear
    return data
  end
end

