# frozen_string_literal: true
module Emarsys
  class ParamsConverter

    attr_accessor :params

    def initialize(params={})
      self.params = params
    end

    def convert_to_ids
      params.is_a?(Hash) ? convert_hash_to_ids : convert_array_to_ids
    end

    def convert_to_identifiers
      new_hash = {}
      params.each do |key, value|
        matching_attributes = Emarsys::FieldMapping::ATTRIBUTES.find{|elem| elem[:id] == key.to_i && key.to_i != 0}
        new_hash.merge!({ (matching_attributes.nil? ? key : matching_attributes[:identifier]) => value })
      end
      new_hash
    end

    private

    def convert_hash_to_ids
      new_hash = {}
      params.each do |key, value|
        matching_attributes = Emarsys::FieldMapping::ATTRIBUTES.find{|elem| elem[:identifier] == key.to_s}
        new_hash.merge!({ (matching_attributes.nil? ? key : matching_attributes[:id]) => value })
      end
      new_hash
    end

    def convert_array_to_ids
      new_array = []
      params.each do |key|
        matching_attributes = Emarsys::FieldMapping::ATTRIBUTES.find{|elem| elem[:identifier] == key.to_s}
        new_array << (matching_attributes.nil? ? key : matching_attributes[:id])
      end
      new_array
    end

  end
end
