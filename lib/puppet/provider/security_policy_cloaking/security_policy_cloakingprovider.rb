require_relative '../../../puppet_x/modules/security_policy/security_policy_api.rb'
require_relative '../../../puppet_x/modules/login_info.rb'
require_relative '../../../puppet_x/modules/security_policy/security_policy_cloaking_api.rb'
require 'json'
require 'base64'
require 'logger'
require 'uri'

Puppet::Type.type(:security_policy_cloaking).provide(:security_policy_cloakingprovider) do
  Puppet.debug("Inside security_policy_cloakingprovider: ")
  mk_resource_methods

 # this method will get security_policy_cloaking and return true or false 

def exists?
    Puppet.debug("Calling exists method of security_policy_cloakingprovider: ")
    @property_hash[:ensure] == :present
end

#this method get all secuirty policys from WAF system and builds the instances array 
def self.instances
  Puppet.debug("Calling instances method of security_policy_cloakingprovider: ")
  instances = []
  login_instance = Login.new
  auth_header = login_instance.get_auth_header
  security_policy_instance = SwaggerClient::SecurityPolicyApi.new
  # get all security_policy_cloaking from WAF
  data,status_code,headers = security_policy_instance.security_policies_get(auth_header,{})
  Puppet.debug("WAF Get all security_policy_cloaking response:    #{data}")
  unless data == '{}'
    if status_code == 200
       response = JSON.parse(data)
       policyobj = response["object"]
       Puppet.debug("Object is  #{policyobj}")
       policyData = response["data"]
       Puppet.debug("Service  data:  #{policyData}")
       policyData.each do |key,value|
         Puppet.debug("The value........ #{value}")
         policyName=value["name"]
         val= value["Cloaking"]
         instances <<  new(
           :ensure => :present,
           :name => policyName,
           :filter_response_header => val["filter-response-header"],
           :headers_to_filter => val["headers-to-filter"],
           :return_codes_to_exempt => val["return-codes-to-exempt"],
           :suppress_return_code => val["suppress-return-code"]
         )
      end
    end # if end
  end# unless end
return instances
end

# this method compares the name attribute from instances and resources. If it matches then sets the provider
def self.prefetch(resources)
  Puppet.debug("Calling prefetch method of security_policy_cloakingprovider: ")
  secuirty_policies = instances
  resources.keys.each do |name|
    if provider = secuirty_policies.find { |secuirty_policy| secuirty_policy.name == name}
       resources[name].provider=provider
    end
  end
end

# this method does a put call to wafsecurity_policy_cloaking. This will be triggered with ensure is present and exists method return true
def flush
  Puppet.debug("Calling flush method of security_policy_cloakingprovider: ")
  if @property_hash != {}
    login_instance = Login.new
    auth_header = login_instance.get_auth_header
    security_policy_cloaking_instance = SwaggerClient::SecurityPolicyCloakingApi.new
    policyName=@resource[:name]
    data,status_code,headers= security_policy_cloaking_instance.security_policies_policy_name_cloaking_put(auth_header,policyName,message(resource),{})
    Puppet.debug("WAF services PUT response:  #{data}")
  end
  return data
end

# this is a util method to build the JSON array to post the request to WAF
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

# util method to refactor the underscores
def convert_underscores(hash)
  hash.each_with_object({}) do |(k ,v), obj|
    key = k.to_s.gsub(/_/, '-').to_sym
    obj[key] = v
  end
end

# this method does a POST call to create a security_policy_cloaking in WAF.this method will be called if the ensure is present and exists method return false 
def create
  Puppet.debug("Calling create method of security_policy_cloakingprovider: ")
end

# this method will call the delete api of a WAF security_policy_cloaking 
def destroy
  Puppet.debug("Calling destroy method of security_policy_cloakingprovider: ")
end

end
