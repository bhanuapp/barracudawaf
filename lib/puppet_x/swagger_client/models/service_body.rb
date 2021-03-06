=begin
#Service API

#No description provided (generated by Swagger Codegen https://github.com/swagger-api/swagger-codegen)

OpenAPI spec version: 3.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 2.2.3

=end

require 'date'

module SwaggerClient

  class ServiceBody
    # Version
    attr_accessor :address_version

    # Status
    attr_accessor :status

    # Web Application Name
    attr_accessor :name

    # Port
    attr_accessor :port

    # Comments
    attr_accessor :comments

    # Enable Access Logs
    attr_accessor :enable_access_logs

    # Session Timeout
    attr_accessor :session_timeout

    # Service App Id
    attr_accessor :app_id

    # Service Group
    attr_accessor :group

    # Vsite
    attr_accessor :vsite

    # Type
    attr_accessor :type

    # Enable DDoS Prevention Service
    attr_accessor :dps_enabled

    # VIP
    attr_accessor :ip_address

    # Mask
    attr_accessor :mask

    class EnumAttributeValidator
      attr_reader :datatype
      attr_reader :allowable_values

      def initialize(datatype, allowable_values)
        @allowable_values = allowable_values.map do |value|
          case datatype.to_s
          when /Integer/i
            value.to_i
          when /Float/i
            value.to_f
          else
            value
          end
        end
      end

      def valid?(value)
        !value || allowable_values.include?(value)
      end
    end

    # Attribute mapping from ruby-style variable name to JSON key.
    def self.attribute_map
      {
        :'address_version' => :'address-version',
        :'status' => :'status',
        :'name' => :'name',
        :'port' => :'port',
        :'comments' => :'comments',
        :'enable_access_logs' => :'enable-access-logs',
        :'session_timeout' => :'session-timeout',
        :'app_id' => :'app-id',
        :'group' => :'group',
        :'vsite' => :'vsite',
        :'type' => :'type',
        :'dps_enabled' => :'dps-enabled',
        :'ip_address' => :'ip-address',
        :'mask' => :'mask'
      }
    end

    # Attribute type mapping.
    def self.swagger_types
      {
        :'address_version' => :'String',
        :'status' => :'String',
        :'name' => :'String',
        :'port' => :'Integer',
        :'comments' => :'String',
        :'enable_access_logs' => :'String',
        :'session_timeout' => :'Integer',
        :'app_id' => :'String',
        :'group' => :'String',
        :'vsite' => :'String',
        :'type' => :'String',
        :'dps_enabled' => :'String',
        :'ip_address' => :'String',
        :'mask' => :'String'
      }
    end

    # Initializes the object
    # @param [Hash] attributes Model attributes in the form of hash
    def initialize(attributes = {})
      return unless attributes.is_a?(Hash)

      # convert string to symbol for hash key
      attributes = attributes.each_with_object({}){|(k,v), h| h[k.to_sym] = v}

      if attributes.has_key?(:'address-version')
        self.address_version = attributes[:'address-version']
      else
        self.address_version = "IPv4"
      end

      if attributes.has_key?(:'status')
        self.status = attributes[:'status']
      else
        self.status = "On"
      end

      if attributes.has_key?(:'name')
        self.name = attributes[:'name']
      end

      if attributes.has_key?(:'port')
        self.port = attributes[:'port']
      end

      if attributes.has_key?(:'comments')
        self.comments = attributes[:'comments']
      else
        self.comments = ""
      end

      if attributes.has_key?(:'enable-access-logs')
        self.enable_access_logs = attributes[:'enable-access-logs']
      else
        self.enable_access_logs = "Yes"
      end

      if attributes.has_key?(:'session-timeout')
        self.session_timeout = attributes[:'session-timeout']
      end

      if attributes.has_key?(:'app-id')
        self.app_id = attributes[:'app-id']
      end

      if attributes.has_key?(:'group')
        self.group = attributes[:'group']
      end

      if attributes.has_key?(:'vsite')
        self.vsite = attributes[:'vsite']
      end

      if attributes.has_key?(:'type')
        self.type = attributes[:'type']
      else
        self.type = "HTTP"
      end

      if attributes.has_key?(:'dps-enabled')
        self.dps_enabled = attributes[:'dps-enabled']
      else
        self.dps_enabled = "No"
      end

      if attributes.has_key?(:'ip-address')
        self.ip_address = attributes[:'ip-address']
      end

      if attributes.has_key?(:'mask')
        self.mask = attributes[:'mask']
      end

    end

    # Show invalid properties with the reasons. Usually used together with valid?
    # @return Array for valid properies with the reasons
    def list_invalid_properties
      invalid_properties = Array.new
      if @name.nil?
        invalid_properties.push("invalid value for 'name', name cannot be nil.")
      end

      if !@port.nil? && @port < 1
        invalid_properties.push("invalid value for 'port', must be greater than or equal to 1.")
      end

      if !@session_timeout.nil? && @session_timeout < 0
        invalid_properties.push("invalid value for 'session_timeout', must be greater than or equal to 0.")
      end

      if @ip_address.nil?
        invalid_properties.push("invalid value for 'ip_address', ip_address cannot be nil.")
      end

      return invalid_properties
    end

    # Check to see if the all the properties in the model are valid
    # @return true if the model is valid
    def valid?
      address_version_validator = EnumAttributeValidator.new('String', ["IPv4", "IPv6"])
      return false unless address_version_validator.valid?(@address_version)
      status_validator = EnumAttributeValidator.new('String', ["On", "Off"])
      return false unless status_validator.valid?(@status)
      return false if @name.nil?
      return false if !@port.nil? && @port < 1
      enable_access_logs_validator = EnumAttributeValidator.new('String', ["Yes", "No"])
      return false unless enable_access_logs_validator.valid?(@enable_access_logs)
      return false if !@session_timeout.nil? && @session_timeout < 0
      type_validator = EnumAttributeValidator.new('String', ["HTTP", "HTTPS", "Instant SSL", "Redirect Service", "Custom", "Custom SSL", "FTP", "FTP SSL"])
      return false unless type_validator.valid?(@type)
      dps_enabled_validator = EnumAttributeValidator.new('String', ["Yes", "No"])
      return false unless dps_enabled_validator.valid?(@dps_enabled)
      return false if @ip_address.nil?
      return true
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] address_version Object to be assigned
    def address_version=(address_version)
      validator = EnumAttributeValidator.new('String', ["IPv4", "IPv6"])
      unless validator.valid?(address_version)
        fail ArgumentError, "invalid value for 'address_version', must be one of #{validator.allowable_values}."
      end
      @address_version = address_version
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] status Object to be assigned
    def status=(status)
      validator = EnumAttributeValidator.new('String', ["On", "Off"])
      unless validator.valid?(status)
        fail ArgumentError, "invalid value for 'status', must be one of #{validator.allowable_values}."
      end
      @status = status
    end

    # Custom attribute writer method with validation
    # @param [Object] port Value to be assigned
    def port=(port)

      if !port.nil? && port < 1
        fail ArgumentError, "invalid value for 'port', must be greater than or equal to 1."
      end

      @port = port
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] enable_access_logs Object to be assigned
    def enable_access_logs=(enable_access_logs)
      validator = EnumAttributeValidator.new('String', ["Yes", "No"])
      unless validator.valid?(enable_access_logs)
        fail ArgumentError, "invalid value for 'enable_access_logs', must be one of #{validator.allowable_values}."
      end
      @enable_access_logs = enable_access_logs
    end

    # Custom attribute writer method with validation
    # @param [Object] session_timeout Value to be assigned
    def session_timeout=(session_timeout)

      if !session_timeout.nil? && session_timeout < 0
        fail ArgumentError, "invalid value for 'session_timeout', must be greater than or equal to 0."
      end

      @session_timeout = session_timeout
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] type Object to be assigned
    def type=(type)
      validator = EnumAttributeValidator.new('String', ["HTTP", "HTTPS", "Instant SSL", "Redirect Service", "Custom", "Custom SSL", "FTP", "FTP SSL"])
      unless validator.valid?(type)
        fail ArgumentError, "invalid value for 'type', must be one of #{validator.allowable_values}."
      end
      @type = type
    end

    # Custom attribute writer method checking allowed values (enum).
    # @param [Object] dps_enabled Object to be assigned
    def dps_enabled=(dps_enabled)
      validator = EnumAttributeValidator.new('String', ["Yes", "No"])
      unless validator.valid?(dps_enabled)
        fail ArgumentError, "invalid value for 'dps_enabled', must be one of #{validator.allowable_values}."
      end
      @dps_enabled = dps_enabled
    end

    # Checks equality by comparing each attribute.
    # @param [Object] Object to be compared
    def ==(o)
      return true if self.equal?(o)
      self.class == o.class &&
          address_version == o.address_version &&
          status == o.status &&
          name == o.name &&
          port == o.port &&
          comments == o.comments &&
          enable_access_logs == o.enable_access_logs &&
          session_timeout == o.session_timeout &&
          app_id == o.app_id &&
          group == o.group &&
          vsite == o.vsite &&
          type == o.type &&
          dps_enabled == o.dps_enabled &&
          ip_address == o.ip_address &&
          mask == o.mask
    end

    # @see the `==` method
    # @param [Object] Object to be compared
    def eql?(o)
      self == o
    end

    # Calculates hash code according to all attributes.
    # @return [Fixnum] Hash code
    def hash
      [address_version, status, name, port, comments, enable_access_logs, session_timeout, app_id, group, vsite, type, dps_enabled, ip_address, mask].hash
    end

    # Builds the object from hash
    # @param [Hash] attributes Model attributes in the form of hash
    # @return [Object] Returns the model itself
    def build_from_hash(attributes)
      return nil unless attributes.is_a?(Hash)
      self.class.swagger_types.each_pair do |key, type|
        if type =~ /\AArray<(.*)>/i
          # check to ensure the input is an array given that the the attribute
          # is documented as an array but the input is not
          if attributes[self.class.attribute_map[key]].is_a?(Array)
            self.send("#{key}=", attributes[self.class.attribute_map[key]].map{ |v| _deserialize($1, v) } )
          end
        elsif !attributes[self.class.attribute_map[key]].nil?
          self.send("#{key}=", _deserialize(type, attributes[self.class.attribute_map[key]]))
        end # or else data not found in attributes(hash), not an issue as the data can be optional
      end

      self
    end

    # Deserializes the data based on type
    # @param string type Data type
    # @param string value Value to be deserialized
    # @return [Object] Deserialized data
    def _deserialize(type, value)
      case type.to_sym
      when :DateTime
        DateTime.parse(value)
      when :Date
        Date.parse(value)
      when :String
        value.to_s
      when :Integer
        value.to_i
      when :Float
        value.to_f
      when :BOOLEAN
        if value.to_s =~ /\A(true|t|yes|y|1)\z/i
          true
        else
          false
        end
      when :Object
        # generic object (usually a Hash), return directly
        value
      when /\AArray<(?<inner_type>.+)>\z/
        inner_type = Regexp.last_match[:inner_type]
        value.map { |v| _deserialize(inner_type, v) }
      when /\AHash<(?<k_type>.+?), (?<v_type>.+)>\z/
        k_type = Regexp.last_match[:k_type]
        v_type = Regexp.last_match[:v_type]
        {}.tap do |hash|
          value.each do |k, v|
            hash[_deserialize(k_type, k)] = _deserialize(v_type, v)
          end
        end
      else # model
        temp_model = SwaggerClient.const_get(type).new
        temp_model.build_from_hash(value)
      end
    end

    # Returns the string representation of the object
    # @return [String] String presentation of the object
    def to_s
      to_hash.to_s
    end

    # to_body is an alias to to_hash (backward compatibility)
    # @return [Hash] Returns the object in the form of hash
    def to_body
      to_hash
    end

    # Returns the object in the form of hash
    # @return [Hash] Returns the object in the form of hash
    def to_hash
      hash = {}
      self.class.attribute_map.each_pair do |attr, param|
        value = self.send(attr)
        next if value.nil?
        hash[param] = _to_hash(value)
      end
      hash
    end

    # Outputs non-array value in the form of hash
    # For object, use to_hash. Otherwise, just return the value
    # @param [Object] value Any valid value
    # @return [Hash] Returns the value in the form of hash
    def _to_hash(value)
      if value.is_a?(Array)
        value.compact.map{ |v| _to_hash(v) }
      elsif value.is_a?(Hash)
        {}.tap do |hash|
          value.each { |k, v| hash[k] = _to_hash(v) }
        end
      elsif value.respond_to? :to_hash
        value.to_hash
      else
        value
      end
    end

  end

end
