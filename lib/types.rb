# encoding: utf-8
# (c) 2011 Martin Kozák (martinkozak@martinkozak.net)

require "multitype-introspection"

##
# Root library module.
#

module Types

    ##
    # Type defining class.
    # @abstract
    #
    
    class Type
    
        ##
        # Returns classes which are part of this type.
        #
        # @return [Array] array of class objects
        # @abstract
        #
        
        def type_classes
            raise Exception::new("Class is abstract.")
        end
        
        ##
        # Returns types which are part of this type.
        # @return [Array] array of types objects
        # 
        
        def type_types
            [ ]
        end
        
        ##
        # Matches object is of this type.
        #
        # @param [Object] object object for type matching
        # @return [Boolean] +true+ if match, +false+ in otherwise
        #
        
        def match_type?(object)
            result = object.kind_of_any? self.type_classes
            if not result
                result = object.type_of_any? self.type_types
            end
            
            return result
        end
        
    end
    
    ##
    # Defines generic boolean type.
    # @abstract
    # 
    
    class Boolean < Type

        ##
        # Returns classes which are part of this type.
        # In case of boolean +TrueClass+ and +FalseClass+.
        #
        # @return [Array] array of types objects
        #
        
        def type_classes
            [TrueClass, FalseClass]
        end
        
    end
end

##
# Extension of built-in Object class.
#

class Object

    ##
    # Indicates object is type of some class.
    # If class isn't {Types::Type Type}, matches against +#kind_of?+.
    #
    # @param [Types::Type, Class] cls  some type or class specification
    # @return [Boolean] +true+ if it is, +false+ in otherwise
    #
    
    def type_of?(cls)
        cls_new = cls::new
        if cls_new.kind_of? Types::Type
            cls_new.match_type? self
        else
            self.kind_of? cls
        end
    end

    ##
    # Indicates object is type of some class in the list.
    # If class isn't {Types::Type Type}, matches against +#kind_of?+.
    #
    # @param [Array] classes array of {Types::Type Type} or +Class+ objects
    # @return [Boolean] +true+ if it is, +false+ in otherwise
    #
        
    def type_of_any?(classes)
        if not classes.kind_of? Array
            raise Exception::new("Array expected.")
        end
        
        classes.each do |cls|
            if self.type_of? cls
                return true
            end
        end
        
        return false
    end
end

##
# Redefines generic boolean type in main namespace.
# @abstract
# 

class Boolean < Types::Boolean
end
