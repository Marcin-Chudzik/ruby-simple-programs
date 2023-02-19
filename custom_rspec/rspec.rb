def describe(description, &block)
    ExampleGroup.new(block).evaluate
end

class ExampleGroup
    def initialize(block)
        @block = block
    end

    def evaluate
        self.instance_eval(&@block)
    end

    def it(description, &block)
        block.call
    end

    def expect(obj)
        ObjectWithExpectation.new(obj)
    end

    def eq(value)
        -> (x) { x == value }
    end

    def include(value)
        -> (x) { x.include?(value) }
    end
end

class ObjectWithExpectation
    def initialize(object)
        @object = object
    end

    def to(func)
        if func.call(@object)
            puts "."
        else
            puts "F"
        end
    end

    def not_to(func)
        if !func.call(@object)
            puts "."
        else
            puts "F"
        end
    end
end

describe "Amazing RSpec example" do
    it "just works!" do
        expect(2 + 2).to eq(4)
        expect(2 + 2).not_to eq(4)
        expect(["a", "b", "c"]).to include("b")
        expect(["a", "b", "c"]).not_to include("b")
    end
end
