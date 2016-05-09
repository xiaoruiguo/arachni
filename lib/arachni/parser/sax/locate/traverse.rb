=begin
    Copyright 2010-2016 Tasos Laskos <tasos.laskos@arachni-scanner.com>

    This file is part of the Arachni Framework project and is subject to
    redistribution and commercial restrictions. Please see the Arachni Framework
    web site for more information on licensing and terms of use.
=end

module Arachni
class Parser
module SAX
module WithNodes
module Locate
module Traverse

    def push_child( child )
    end

    def close_node( node )
    end

    def traverse( klass = nil, &block )
        traverser children, klass, &block
    end

    def descendants
        @descendants ||= begin
            n = []
            traverse { |e| n << e }
            n
        end
    end

    def nodes_by_name( name )
        name = name.to_s.downcase

        fail_if_not_in_whitelist( name )

        @nodes_by_name ||= {}
        @nodes_by_name[name.hash] ||= begin
            descendants.select do |e|
                e.respond_to?( :name ) && e.name == name.to_sym
            end
        end
    end

    def nodes_by_names( names )
        @nodes_by_name ||= {}
        @nodes_by_name[names.hash] ||= names.map { |n| nodes_by_name( n ) }.flatten
    end

    def nodes_by_attribute_name( name )
        name = name.to_s.downcase

        @nodes_by_attribute_name ||= {}
        @nodes_by_attribute_name[name.hash] ||= begin
            descendants.select do |e|
                e.respond_to?(:attributes) && e.attributes.include?( name )
            end
        end
    end

    def nodes_by_attribute_name_and_value( name, value )
        name = name.to_s.downcase

        @nodes_by_attribute_name_and_value ||= {}
        @nodes_by_attribute_name_and_value[[name, value].hash] ||= begin
            nodes_by_attribute_name( name ).select do |e|
                e[name].to_s.downcase == value
            end
        end
    end

    private

    def traverser( nodes, klass = nil, &block )
        nodes.each do |node|
            block.call( node ) if !klass || node.is_a?( klass )

            next if !node.respond_to?( :children )

            traverser node.children, klass, &block
        end
    end


end
end
end
end
end
end

