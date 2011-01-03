# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "multitype-introspection"

module Types
    class Type
    
        ##
        # Returns classes which are part of this type.
        #
        
        def type_classes
            raise Exception::new("Class is abstract.")
        end
        
        ##
        # Returns types which are part of this type.
        # 
        
        def type_types
            [ ]
        end
        
        ##
        # Matches object is of this type.
        #
        
        def match_type?(object)
            result = object.kind_of_any? self.type_classes
            if not result
                result = object.type_of_any? self.type_types
            end
            
            return result
        end
        
    end
    
    class Boolean < Type

        ##
        # Returns classes which are part of this type.
        # In case of boolean <tt>TrueClass</tt> and <tt>FalseClass</tt>.
        #
        
        def type_classes
            [TrueClass, FalseClass]
        end
        
    end
end

class Object

    ##
    # Indicates object is type of some class.
    # If class isn't Type, matches against kind_of?.
    #
    
    def type_of?(cls)
        if cls.kind_of? Types::Type
            cls.match_type? self
        else
            self.kind_of? some_class
        end
    end


    ##
    # Indicates object is type of some class in the list.
    # If class isn't Type, matches against kind_of?.
    #
        
    def type_of_any?(classes)
        if not classes.kind_of? Array
            raise Exception::new("Array expected.")
        end
        
        classes.each do |cls|
            if cls.type_of? cls
                return true
            end
            
            return false
        end
    end
end

class Boolean < Types::Boolean
end
