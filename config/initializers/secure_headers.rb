SecureHeaders::Configuration.default do |config|
  config.cookies = {
    secure: true, # mark all cookies as "Secure"
    httponly: true, # mark all cookies as "HttpOnly"
    samesite: {
      strict: true # mark all cookies as SameSite=lax
    }
  }
  # Add "; preload" and submit the site to hstspreload.org for best protection.
  # config.hsts = "max-age=#{20.years.to_i}; includeSubdomains"
  config.x_frame_options = "DENY"
  config.x_content_type_options = "nosniff"
  config.x_xss_protection = "1; mode=block"
  config.x_download_options = "noopen"
  config.x_permitted_cross_domain_policies = "none"
  config.referrer_policy = "strict-origin-when-cross-origin"
  config.clear_site_data = [
    "cache",
    "cookies",
    "storage",
    "executionContexts"
  ]
  config.csp = {
    # "meta" values. these will shaped the header, but the values are not included in the header.
    # report_only: true,      # default: false [DEPRECATED from 3.5.0: instead, configure csp_report_only]
    preserve_schemes: true, # default: false. Schemes are removed from host sources to save bytes and discourage mixed content.
    #
    # # directive values: these values will directly translate into source directives
    default_src: %w('self'),
    base_uri: %w('self'),
    block_all_mixed_content: true, # see http://www.w3.org/TR/mixed-content/
    child_src: %w('self'), # if child-src isn't supported, the value for frame-src will be set.
    connect_src: %w(wss: streaming.somewhy.com 'self'),
    font_src: %w('self' data:),
    form_action: %w('self'),
    frame_ancestors: %w('none'),
    img_src: %w(https://somewhy.s3-us-west-1.amazonaws.com 'self' data:),
    media_src: %w(https://somewhy.s3-us-west-1.amazonaws.com),
    object_src: %w('none'),
    plugin_types: %w(application/x-shockwave-flash),
    script_src: %w('self'),
    style_src: %w('self'),
    # style_src: %w('unsafe-inline' 'self'),
    upgrade_insecure_requests: Rails.env == 'production', # see https://www.w3.org/TR/upgrade-insecure-requests/
    # report_uri: %w(https://report-uri.io/example-csp)
  }
  # # This is available only from 3.5.0; use the `report_only: true` setting for 3.4.1 and below.
  # config.csp_report_only = config.csp.merge({
  #   img_src: %w(somewhereelse.com),
  #   report_uri: %w(https://report-uri.io/example-csp-report-only)
  # })
  # config.hpkp = {
  #   report_only: false,
  #   max_age: 60.days.to_i,
  #   include_subdomains: true,
  #   report_uri: "https://report-uri.io/example-hpkp",
  #   pins: [
  #     {sha256: "abc"},
  #     {sha256: "123"}
  #   ]
  # }
end
