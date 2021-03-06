require 'spec_helper'

provider_class = Puppet::Type.type(:security_policy_parameter_protection).provider(:security_policy_parameter_protectionprovider)

describe provider_class do
  let(:resource) {
    Puppet::Type.type(:security_policy_parameter_protection).new(
	name:'owa',
	maximum_instances:1,
	maximum_parameter_value_length:1056,       
    )
  }

  let(:provider) { resource.provider }
  it 'should be an instance of the security_policy_parameter_protectionprovider' do
    expect(provider).to be_an_instance_of Puppet::Type.type(:security_policy_parameter_protection).provider(:security_policy_parameter_protectionprovider)
  end
end

