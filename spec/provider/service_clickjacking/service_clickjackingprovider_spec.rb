require 'spec_helper'

provider_class = Puppet::Type.type(:service_clickjacking).provider(:service_clickjackingprovider)

describe provider_class do
  let(:resource) {
    Puppet::Type.type(:service_clickjacking).new(
    name:'httpsApp1',
    status:'On',
    options:'Never'
    )
  }

  let(:provider) { resource.provider }
  it 'should be an instance of the service_clickjackingprovider' do
    expect(provider).to be_an_instance_of Puppet::Type.type(:service_clickjacking).provider(:service_clickjackingprovider)
  end
end

