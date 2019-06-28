require "libxml_extensions/version"
require "libxml"

module LibxmlExtensions
  class DecoratedDocument < SimpleDelegator

    def add_xml_node_and_value(xpath, value_or_values)
      if value_or_values.is_a?(Array)
        value_or_values.each {|value| add_xml_node_and_value(xpath, value)}
        return
      elsif value_or_values.is_a?(Hash)
        value_or_values.each_pair{|key, value| add_xml_node_and_value([xpath, key].join("/"), value)}
        return
      end

      node = find_or_create_node_for_xpath(xpath)
      return node if value_or_values.nil?

      node << value_or_values
      node
    end

    private

    #similar to mkdir -p, creates the intermediate paths if they don't exist
    def find_or_create_node_for_xpath(xpath)
      remove_preceding_slash!(xpath)

      xpath_parts = xpath.split(/\//)
      ancestor_node_names, node_name = xpath_parts[0..-2], xpath_parts.last

      parent_node = root
      ancestor_node_names.each_with_index do |ancestor_node_name|
        child_node = parent_node.find_first ancestor_node_name
        if child_node.nil?
          child_node  = LibXML::XML::Node.new ancestor_node_name
          parent_node << child_node
        end
        parent_node = child_node
      end

      node = LibXML::XML::Node.new node_name
      parent_node << node

      node
    end

    def remove_preceding_slash!(xpath)
      xpath.gsub!(/\A\//, '')
    end
  end

end

