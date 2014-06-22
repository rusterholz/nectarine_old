module Parameters
  extend ActiveSupport::Concern

  included do
    class << self
      def params_for( *objects )
        objects.extract_options!.each do |object, whitelist|
          permit_args = whitelist.map{ |w| ":#{w}" }.join(', ')
          class_eval <<-RB
            def #{object}_params
              params.require( :#{object} ).permit( #{permit_args} )
            end
          RB
        end
      end
    end
  end

end

