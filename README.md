Ruby Types
==========

**Ruby Types** introduces *group of classes* as eqivalent to some data 
types in other languages such as `boolean` and allows introspection 
according to type of class too. In fact, partially replaces multiple 
inheritance because introduces unlimited formal genericity for every 
class.

For example define:

    class Boolean < Type
        def type_classes
            [TrueClass, FalseClass]
        end
    end
    
Then you can call:

    foo = 5
    bar = true
    
    foo.type_of? Boolean    # returns false
    bar.type_of? Boolean    # returns true
    
Binding back to classic behaviour works:

    foo.type_of? Numeric    # returns true


Contributing
------------

1. Fork it.
2. Create a branch (`git checkout -b 20101220-my-change`).
3. Commit your changes (`git commit -am "Added something"`).
4. Push to the branch (`git push origin 20101220-my-change`).
5. Create an [Issue][1] with a link to your branch.
6. Enjoy a refreshing Diet Coke and wait.


Copyright
---------

Copyright &copy; 2011 [Martin Kozák][2]. See `LICENSE.txt` for
further details.

[1]: http://github.com/martinkozak/types/issues
[2]: http://www.martinkozak.net/
