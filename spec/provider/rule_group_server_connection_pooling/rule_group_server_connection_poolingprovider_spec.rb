require 'spec_helper'

provider_class = Puppet::Type.type(:rule_group_server_connection_pooling).provider(:rule_group_server_connection_poolingprovider)

describe provider_class do
  let(:resource) {
    Puppet::Type.type(:rule_group_server_connection_pooling).new(
	name:'rgServer1',
	service_name:'httpsApp1',
	rule_group_name:'Rule1',
	keepalive_timeout:900001,       
    )
  }

  let(:provider) { resource.provider }
  it 'should be an instance of the rule_group_server_connection_poolingprovider' do
    expect(provider).to be_an_instance_of Puppet::Type.type(:rule_group_server_connection_pooling).provider(:rule_group_server_connection_poolingprovider)
  end
end

