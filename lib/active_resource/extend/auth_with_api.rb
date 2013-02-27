# -*- coding:utf-8 -*-
module ActiveResource #:nodoc:
  module Extend
    module AuthWithApi
      module ClassMethods
        def element_path_with_auth(*args)
          element_path_without_auth(*args).concat("?key=#{self.api_key}")
        end
        def new_element_path_with_auth(*args)
          new_element_path_without_auth(*args).concat("?key=#{self.api_key}")
        end
        def collection_path_with_auth(*args)
          collection_path_without_auth(*args).concat("?key=#{self.api_key}")
        end
      end

      def self.included(base)
        base.class_eval do
          extend ClassMethods
          class << self
            alias_method_chain :element_path, :auth
            alias_method_chain :new_element_path, :auth
            alias_method_chain :collection_path, :auth
            attr_accessor :api_key
          end
        end
      end  
    end
  end  
end