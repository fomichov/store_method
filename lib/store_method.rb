module StoreMethod
  module ClassMethods
    def store_method *names
      @methods_to_store ||= {}
      
      names.each do |name|
        if instance_methods.include?(name.to_sym)
          store_method_create(name)
        else
          @methods_to_store[name.to_sym] = true
        end
      end
    end

    alias_method :store_methods, :store_method

    def method_added name
      super
      return if @methods_to_store.nil? || @methods_to_store[name].nil?
      @methods_to_store.delete(name)
      store_method_create(name)
    end

    def store_method_create name
      alias_method "#{name}_orig", name

      define_method(name) do |*args|
        if args.empty?
          val = attributes[name.to_s]
          unless val
            val = send("#{name}_orig")
            if new_record?
              assign_attributes({name.to_sym => val})
            else
              update_column(name.to_sym, val) if val
            end
          end
          return val
        else
          return send("#{name}_orig", *args)
        end
      end
      
      define_method("refresh_#{name}") do |*args|
        val = send("#{name}_orig")
        if new_record?
          assign_attributes({name.to_sym => val})
        else
          update_column(name.to_sym, val)
        end
        return val
      end
    end
  end
end

ActiveRecord::Base.send(:extend, StoreMethod::ClassMethods)