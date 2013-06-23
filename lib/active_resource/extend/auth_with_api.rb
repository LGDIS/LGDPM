# -*- coding:utf-8 -*-
module ActiveResource #:nodoc:
  module Extend
    module AuthWithApi
      module ClassMethods
        def element_path_with_auth(*args)
          build_uri(element_path_without_auth(*args))
        end
        def new_element_path_with_auth(*args)
          build_uri(new_element_path_without_auth(*args))
        end
        def collection_path_with_auth(*args)
          build_uri(collection_path_without_auth(*args))
        end

        private

        def build_uri(request)
          [request, "key=#{self.api_key}"].join(request.include?("?") ? "&" : "?")
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
