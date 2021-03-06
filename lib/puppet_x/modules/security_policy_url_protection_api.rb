=begin
#Security Policy url protection API

#No description provided (generated by Swagger Codegen https://github.com/swagger-api/swagger-codegen)

OpenAPI spec version: 3.0.0

Generated by: https://github.com/swagger-api/swagger-codegen.git
Swagger Codegen version: 2.2.3

=end

require "uri"

module SwaggerClient
  class SecurityPolicyUrlProtectionApi
    attr_accessor :api_client

    def initialize(api_client = ApiClient.default)
      @api_client = api_client
    end

    # FETCH Information of Security Policy url protection
    # 
    # @param authorization Login token
    # @param policy_name Policy Name of Security Policy url protection
    # @param [Hash] opts the optional parameters
    # @option opts [Array<String>] :fields 
    # @return [nil]
    def security_policies_policy_name_url_protection_get(authorization, policy_name, opts = {})
       data,status_code,headers = security_policies_policy_name_url_protection_get_with_http_info(authorization, policy_name, opts)
      return data,status_code,headers
    end

    # FETCH Information of Security Policy url protection
    # 
    # @param authorization Login token
    # @param policy_name Policy Name of Security Policy url protection
    # @param [Hash] opts the optional parameters
    # @option opts [Array<String>] :fields 
    # @return [Array<(nil, Fixnum, Hash)>] nil, response status code and response headers
    def security_policies_policy_name_url_protection_get_with_http_info(authorization, policy_name, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: SecurityPolicyUrlProtectionApi.security_policies_policy_name_url_protection_get ..."
      end
      # verify the required parameter 'authorization' is set
      if @api_client.config.client_side_validation && authorization.nil?
        fail ArgumentError, "Missing the required parameter 'authorization' when calling SecurityPolicyUrlProtectionApi.security_policies_policy_name_url_protection_get"
      end
      # verify the required parameter 'policy_name' is set
      if @api_client.config.client_side_validation && policy_name.nil?
        fail ArgumentError, "Missing the required parameter 'policy_name' when calling SecurityPolicyUrlProtectionApi.security_policies_policy_name_url_protection_get"
      end
      # resource path
      local_var_path = "/security-policies/{Policy Name}/url-protection".sub('{' + 'Policy Name' + '}', policy_name.to_s)

      # query parameters
      query_params = {}
      query_params[:'fields'] = @api_client.build_collection_param(opts[:'fields'], :multi) if !opts[:'fields'].nil?

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      header_params[:'Authorization'] = authorization

      # form parameters
      form_params = {}

      # http body (model)
      post_body = nil
      auth_names = []
      data, status_code, headers = @api_client.call_api(:GET, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: SecurityPolicyUrlProtectionApi#security_policies_policy_name_url_protection_get\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end

    # EDIT Information of Security Policy url protection
    # 
    # @param authorization Login token
    # @param policy_name Policy Name of Security Policy url protection
    # @param security_policy_url_protection Body Parameter of Security Policy url protection
    # @param [Hash] opts the optional parameters
    # @return [nil]
    def security_policies_policy_name_url_protection_put(authorization, policy_name, security_policy_url_protection, opts = {})
       data,status_code,headers = security_policies_policy_name_url_protection_put_with_http_info(authorization, policy_name, security_policy_url_protection, opts)
      return data,status_code,headers
    end

    # EDIT Information of Security Policy url protection
    # 
    # @param authorization Login token
    # @param policy_name Policy Name of Security Policy url protection
    # @param security_policy_url_protection Body Parameter of Security Policy url protection
    # @param [Hash] opts the optional parameters
    # @return [Array<(nil, Fixnum, Hash)>] nil, response status code and response headers
    def security_policies_policy_name_url_protection_put_with_http_info(authorization, policy_name, security_policy_url_protection, opts = {})
      if @api_client.config.debugging
        @api_client.config.logger.debug "Calling API: SecurityPolicyUrlProtectionApi.security_policies_policy_name_url_protection_put ..."
      end
      # verify the required parameter 'authorization' is set
      if @api_client.config.client_side_validation && authorization.nil?
        fail ArgumentError, "Missing the required parameter 'authorization' when calling SecurityPolicyUrlProtectionApi.security_policies_policy_name_url_protection_put"
      end
      # verify the required parameter 'policy_name' is set
      if @api_client.config.client_side_validation && policy_name.nil?
        fail ArgumentError, "Missing the required parameter 'policy_name' when calling SecurityPolicyUrlProtectionApi.security_policies_policy_name_url_protection_put"
      end
      # verify the required parameter 'security_policy_url_protection' is set
      if @api_client.config.client_side_validation && security_policy_url_protection.nil?
        fail ArgumentError, "Missing the required parameter 'security_policy_url_protection' when calling SecurityPolicyUrlProtectionApi.security_policies_policy_name_url_protection_put"
      end
      # resource path
      local_var_path = "/security-policies/{Policy Name}/url-protection".sub('{' + 'Policy Name' + '}', policy_name.to_s)

      # query parameters
      query_params = {}

      # header parameters
      header_params = {}
      # HTTP header 'Accept' (if needed)
      header_params['Accept'] = @api_client.select_header_accept(['application/json'])
      header_params[:'Authorization'] = authorization

      # form parameters
      form_params = {}

      # http body (model)
      post_body = @api_client.object_to_http_body(security_policy_url_protection)
      auth_names = []
      data, status_code, headers = @api_client.call_api(:PUT, local_var_path,
        :header_params => header_params,
        :query_params => query_params,
        :form_params => form_params,
        :body => post_body,
        :auth_names => auth_names)
      if @api_client.config.debugging
        @api_client.config.logger.debug "API called: SecurityPolicyUrlProtectionApi#security_policies_policy_name_url_protection_put\nData: #{data.inspect}\nStatus code: #{status_code}\nHeaders: #{headers}"
      end
      return data, status_code, headers
    end
  end
end
