# coding: utf-8

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Misaleanegager::Application.initialize!


WillPaginate::ViewHelpers.pagination_options[:prev_label] = '<div class="nav_prev"></div>' #'&lArr;'#በፊት'.force_encoding('utf-8') 
WillPaginate::ViewHelpers.pagination_options[:next_label] = '<div class="nav_next"></div>' #'&rArr;'#ቀትሎ'.force_encoding('utf-8') 