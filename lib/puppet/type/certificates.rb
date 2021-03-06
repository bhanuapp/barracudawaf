Puppet::Type.newtype(:certificates) do
  @doc = 'Defines all possible types for Creation/Upload of a Certificate object on the Barracuda Web Application Firewall.'

  ensurable


  newparam(:name, :namevar => true) do
    desc "Certificate Name"
    validate do |value|
      fail("Invalid name #{value}, Illegal characters present") unless value =~ /^[a-zA-Z][a-zA-Z0-9\._\-]*$/
      fail("Invalid name #{value}, Must be no longer than 512 characters") if value.length > 512
    end
  end


  newproperty(:country_code) do
    desc "Country"
    validate do |value|
      fail("Invalid country_code #{value}, Illegal characters present") unless value =~ /^[A-Za-z0-9\.\_\s\@\/\*\-]+$/
      fail("Invalid country_code #{value}, Must be no longer than 2 characters") if value.length > 2
      fail("Invalid country_code #{value}, Must be no shorter than 2 characters") if value.length < 2
    end
  end


  newproperty(:allow_private_key_export) do
    desc "Allow Private Key Export"
    defaultto :Yes 
    newvalues(:Yes, :No)
  end


  newproperty(:key_type) do
    desc "Select Key Type:"
    defaultto :rsa
    newvalues(:rsa, :ecdsa)
  end


  newproperty(:key_size) do
    desc "Key Size"
    defaultto 1024
    newvalues(1024, 2048, 4096)
  end


  newproperty(:organization_name) do
    desc "Organization Name"
    validate do |value|
      fail("Invalid organization_name #{value}, Illegal characters present") unless value =~ /^[A-Za-z0-9\.\,\_\&\'\(\)\-\s\@\/\*]+$/
      fail("Invalid organization_name #{value}, Must be no longer than 64 characters") if value.length > 64
    end
  end


  newproperty(:san_certificate) do
    desc "san certificate"
  end


  newproperty(:state) do
    desc "State or Province"
    validate do |value|
      fail("Invalid state #{value}, Illegal characters present") unless value =~ /^[A-Za-z0-9\.\_\s\@\/\*\-]+$/
      fail("Invalid state #{value}, Must be no longer than 128 characters") if value.length > 128
    end
  end


  newproperty(:common_name) do
    desc "Common Name"
    validate do |value|
      fail("Invalid common_name #{value}, Illegal characters present") unless value =~ /^[A-Za-z0-9\.\_\s\@\/\*\-]+$/
      fail("Invalid common_name #{value}, Must be no longer than 64 characters") if value.length > 64
    end
  end


  newproperty(:city) do
    desc "Locality Name"
    validate do |value|
      fail("Invalid city #{value}, Illegal characters present") unless value =~ /^[A-Za-z0-9\.\_\s\@\/\*\-]+$/
      fail("Invalid city #{value}, Must be no longer than 128 characters") if value.length > 128
    end
  end


  newproperty(:organization_unit) do
    desc "Organizational Unit Name"
    validate do |value|
      fail("Invalid organizational_unit #{value}, Illegal characters present") unless value =~ /^[A-Za-z0-9\.\_\'\s\@\/\*\-]+$/
      fail("Invalid organizational_unit #{value}, Must be no longer than 64 characters") if value.length > 64
    end
  end


  newproperty(:curve_type) do
    desc "Elliptic Curve Name"
    defaultto :secp256r1
    newvalues(:secp256r1, :secp384r1, :secp521r1)
  end


  newproperty(:signed_certificate) do
    desc "Signed Certificate File Path"
  end


  newproperty(:assign_associated_key) do
    desc "Assign Associated Key"
    defaultto :No
    newvalues(:No, :Yes)
  end


  newproperty(:key) do
    desc "Certificate Key"
  end


  newproperty(:intermediary_certificate) do
    desc "Intermediary Certificate File Path"
  end


  newproperty(:password) do
    desc "Certificate Password"
  end


  newproperty(:upload) do
    desc 'Upload Type'
    defaultto :signed
    newvalues(:signed, :trusted, :trusted_server)
  end


  newproperty(:trusted_certificate) do
    desc 'Trusted Certificate File Path'
  end


  newproperty(:trusted_server_certificate) do
    desc 'Trusted Server Certificate File Path'
  end

 
  newproperty(:type) do
    desc 'Certificate Type'
    defaultto :pem
    newvalues(:pem, :pkcs12)
  end


end

