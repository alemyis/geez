require File.expand_path('../boot', __FILE__)

require 'rails/all'

# If you have a Gemfile, require the gems listed there, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(:default, Rails.env) if defined?(Bundler)

module Misaleanegager
  class Application < Rails::Application
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Custom directories with classes and modules you want to be autoloadable.
    # config.autoload_paths += %W(#{config.root}/extras)

    # Only load the plugins named here, in the order given (default is alphabetical).
    # :all can be used as a placeholder for all plugins not explicitly named.
    # config.plugins = [ :exception_notification, :ssl_requirement, :all ]

    # Activate observers that should always be running.
    # config.active_record.observers = :cacher, :garbage_collector, :forum_observer

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # JavaScript files you want as :defaults (application.js is always included).
    # config.action_view.javascript_expansions[:defaults] = %w(jquery rails)

    # Configure the default encoding used in templates for Ruby 1.9.
    config.encoding = "utf-8"

    # Configure sensitive parameters which will be filtered from the log file.
    config.filter_parameters += [:password]
  end
  
  
  # This class does the heavy lifting of actually building the pagination
  # links. It is used by the <tt>will_paginate</tt> helper internally.
  class AlemLinkRenderer #< WillPaginate::LinkRenderer

    # The gap in page links is represented by:
    #
    #   <span class="gap">&hellip;</span>
    attr_accessor :gap_marker
    
    def initialize
      @gap_marker = ''
    end
    
    # * +collection+ is a WillPaginate::Collection instance or any other object
    #   that conforms to that API
    # * +options+ are forwarded from +will_paginate+ view helper
    # * +template+ is the reference to the template being rendered
    def prepare(collection, options, template)
      @collection = collection
      @options    = options
      @template   = template

      # reset values in case we're re-using this instance
      @total_pages = @param_name = @url_string = nil
    end

    # Process it! This method returns the complete HTML string which contains
    # pagination links. Feel free to subclass LinkRenderer and change this
    # method as you see fit.
    def to_html
      links = @options[:page_links] ? windowed_links : []
      # previous/next buttons
      #links.unshift page_link_or_span(@collection.previous_page, 'disabled prev_page', @options[:previous_label])
      #links.push    page_link_or_span(@collection.next_page,     'disabled next_page', @options[:next_label])
      
      links = []
      links.push page_link_or_span(@collection.current_page, 'span_class', 'Random')
      links.unshift page_link_or_span(@collection.previous_page, 'disabled prev_page', @options[:previous_label])
      links.push page_link_or_span(@collection.next_page,     'disabled next_page', @options[:next_label])
      
      html = links.join(@options[:separator])
      html = html.html_safe if html.respond_to? :html_safe
      @options[:container] ? @template.content_tag(:div, html, html_attributes) : html
    end

    # Returns the subset of +options+ this instance was initialized with that
    # represent HTML attributes for the container element of pagination links.
    def html_attributes
      return @html_attributes if @html_attributes
      @html_attributes = @options.except *(WillPaginate::ViewHelpers.pagination_options.keys - [:class])
      # pagination of Post models will have the ID of "posts_pagination"
      if @options[:container] and @options[:id] === true
        @html_attributes[:id] = @collection.first.class.name.underscore.pluralize + '_pagination'
      end
      @html_attributes
    end
    
  protected

    # Collects link items for visible page numbers.
    def windowed_links
      prev = nil

      visible_page_numbers.inject [] do |links, n|
        # detect gaps:
        links << gap_marker if prev and n > prev + 1
        links << page_link_or_span(n, 'current')
        prev = n
        links
      end
    end

    # Calculates visible page numbers using the <tt>:inner_window</tt> and
    # <tt>:outer_window</tt> options.
    def visible_page_numbers
      inner_window, outer_window = @options[:inner_window].to_i, @options[:outer_window].to_i
      window_from = current_page - inner_window
      window_to = current_page + inner_window
      
      # adjust lower or upper limit if other is out of bounds
      if window_to > total_pages
        window_from -= window_to - total_pages
        window_to = total_pages
      end
      if window_from < 1
        window_to += 1 - window_from
        window_from = 1
        window_to = total_pages if window_to > total_pages
      end
      
      visible   = (1..total_pages).to_a
      left_gap  = (2 + outer_window)...window_from
      right_gap = (window_to + 1)...(total_pages - outer_window)
      visible  -= left_gap.to_a  if left_gap.last - left_gap.first > 1
      visible  -= right_gap.to_a if right_gap.last - right_gap.first > 1

      visible
    end
    
    def page_link_or_span(page, span_class, text = nil)
      text ||= page.to_s
      text = text.html_safe if text.respond_to? :html_safe
      
      if page and page == current_page
        rand_page_link 'Random', :class => span_class
      elsif page and page != current_page
        classnames = span_class && span_class.index(' ') && span_class.split(' ', 2).last
        page_link page, text, :rel => rel_value(page), :class => classnames
      else
        page_span page, text, :class => span_class
      end
    end

    def page_link(page, text, attributes = {})
      @template.link_to text, url_for(page), attributes
    end
    
    def rand_page_link(text, attributes = {})
      @template.link_to text, url_for(0), attributes
    end
  
    def page_span(page, text, attributes = {})
      @template.content_tag :span, text, attributes
    end

    # Returns URL params for +page_link_or_span+, taking the current GET params
    # and <tt>:params</tt> option into account.
    def url_for(page)
      page_one = page == 1
      unless @url_string and !page_one
        @url_params = {}
        # page links should preserve GET parameters
        stringified_merge @url_params, @template.params if @template.request.get?
        stringified_merge @url_params, @options[:params] if @options[:params]
        
        if complex = param_name.index(/[^\w-]/)
          page_param = parse_query_parameters("#{param_name}=#{page}")
          
          stringified_merge @url_params, page_param
        else
          @url_params[param_name] = page_one ? 1 : 2
        end

        url = @template.url_for(@url_params)
        return url if page_one
        
        if complex
          @url_string = url.sub(%r!((?:\?|&amp;)#{CGI.escape param_name}=)#{page}!, "\\1\0")
          return url
        else
          @url_string = url
          @url_params[param_name] = 3
          @template.url_for(@url_params).split(//).each_with_index do |char, i|
            if char == '3' and url[i, 1] == '2'
              @url_string[i] = "\0"
              break
            end
          end
        end
      end
      # finally!
      @url_string.sub "\0", page == 0 ? 'rand' : page.to_s
    end

  private

    def rel_value(page)
      case page
      when @collection.previous_page; 'prev' + (page == 1 ? ' start' : '')
      when @collection.next_page; 'next'
      when 1; 'start'
      end
    end

    def current_page
      @collection.current_page
    end

    def total_pages
      @total_pages ||= @collection.total_pages 
    end

    def param_name
      @param_name ||= @options[:param_name].to_s
    end

    # Recursively merge into target hash by using stringified keys from the other one
    def stringified_merge(target, other)
      other.each do |key, value|
        key = key.to_s # this line is what it's all about!
        existing = target[key]

        if value.is_a?(Hash) and (existing.is_a?(Hash) or existing.nil?)
          stringified_merge(existing || (target[key] = {}), value)
        else
          target[key] = value
        end
      end
    end

    def parse_query_parameters(params)
      if defined? Rack::Utils
        # For Rails > 2.3
        Rack::Utils.parse_nested_query(params)
      elsif defined?(ActionController::AbstractRequest)
        ActionController::AbstractRequest.parse_query_parameters(params)
      elsif defined?(ActionController::UrlEncodedPairParser)
        # For Rails > 2.2
        ActionController::UrlEncodedPairParser.parse_query_parameters(params)
      elsif defined?(CGIMethods)
        CGIMethods.parse_query_parameters(params)
      else
        raise "unsupported ActionPack version"
      end
    end
  end

end
