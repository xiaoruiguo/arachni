=begin
    Copyright 2010-2016 Tasos Laskos <tasos.laskos@arachni-scanner.com>

    This file is part of the Arachni Framework project and is subject to
    redistribution and commercial restrictions. Please see the Arachni Framework
    web site for more information on licensing and terms of use.
=end

# Extracts paths from anchor elements.
#
# @author Tasos "Zapotek" Laskos <tasos.laskos@arachni-scanner.com>
class Arachni::Parser::Extractors::Areas < Arachni::Parser::Extractors::Base

    def run
        return [] if !check_for?( 'area' ) || !check_for?( 'href' )

        document.nodes_by_name( 'area' ).map { |a| a['href'] }
    end

end
