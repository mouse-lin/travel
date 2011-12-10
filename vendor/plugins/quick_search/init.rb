# Include hook code here
require 'quick_search'

ActionController::Base.send :include, QuickSearch::ControllerMethod
