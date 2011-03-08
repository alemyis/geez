# coding: utf-8

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Misaleanegager::Application.initialize!
#Misaleanegager::AlemLinkRenderer.initialize


WillPaginate::ViewHelpers.pagination_options[:prev_label] = '&laquo; PREV' #'<div class="nav_prev"></div>' #'&lArr;'#በፊት'.force_encoding('utf-8') 
WillPaginate::ViewHelpers.pagination_options[:next_label] = 'NEXT &raquo;' #'<div class="nav_next"></div>' #'&rArr;'#ቀትሎ'.force_encoding('utf-8') 
WillPaginate::ViewHelpers.pagination_options[:outer_window] = 0
WillPaginate::ViewHelpers.pagination_options[:inner_window] = 0
WillPaginate::ViewHelpers.pagination_options[:renderer] = 'Misaleanegager::AlemLinkRenderer'