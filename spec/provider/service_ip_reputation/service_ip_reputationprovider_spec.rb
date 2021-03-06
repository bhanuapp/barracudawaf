require 'spec_helper'

provider_class = Puppet::Type.type(:service_ip_reputation).provider(:service_ip_reputationprovider)

describe provider_class do
  let(:resource) {
    Puppet::Type.type(:service_ip_reputation).new(
	name:'service_ip_reputation',
	tor_nodes:'Allow',
	satellite_provider:'Allow',
	geoip_action:'Block',       
    )
  }

  let(:provider) { resource.provider }
  it 'should be an instance of the service_ip_reputationprovider' do
    expect(provider).to be_an_instance_of Puppet::Type.type(:service_ip_reputation).provider(:service_ip_reputationprovider)
  end
end

