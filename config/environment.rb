# coding: utf-8

# Load the rails application
require File.expand_path('../application', __FILE__)

# Initialize the rails application
Misaleanegager::Application.initialize!


WillPaginate::ViewHelpers.pagination_options[:prev_label] = '&lArr;'#በፊት'.force_encoding('utf-8') 
WillPaginate::ViewHelpers.pagination_options[:next_label] = '&rArr;'#ቀትሎ'.force_encoding('utf-8') 